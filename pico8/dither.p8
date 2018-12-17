pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function gamma(x)
  local y=sqrt(sqrt(x))
  return x*x*y
  --return x*x*y*sqrt(y)
end

function srgb(c)
  c[1] = gamma(c.r / 0xff)
  c[2] = gamma(c.g / 0xff)
  c[3] = gamma(c.b / 0xff)
end

function make_palette()
  local p = {
    { r=0x00, g=0x00, b=0x00, name="black" },
    { r=0x1d, g=0x2b, b=0x53, name="dark_blue" },
    { r=0x7e, g=0x25, b=0x53, name="dark_purple" },
    { r=0x00, g=0x87, b=0x51, name="dark_green" },
    { r=0xab, g=0x52, b=0x36, name="brown" },
    { r=0x5f, g=0x57, b=0x4f, name="dark_gray" },
    { r=0xc2, g=0xc3, b=0xc7, name="light_gray" },
    { r=0xff, g=0xf1, b=0xe8, name="white" },
    { r=0xff, g=0x00, b=0x4d, name="red" },
    { r=0xff, g=0xa3, b=0x00, name="orange" },
    { r=0xff, g=0xec, b=0x27, name="yellow" },
    { r=0x00, g=0xe4, b=0x36, name="green" },
    { r=0x29, g=0xad, b=0xff, name="blue" },
    { r=0x83, g=0x76, b=0x9c, name="indigo" },
    { r=0xff, g=0x77, b=0xa8, name="pink" },
    { r=0xff, g=0xcc, b=0xaa, name="peach" },
  }

  for i=1,#p do
    srgb(p[i])
    p[i].i0 = i-1
    p[i].i1 = i-1
  end

  return p
end

function lum(c)
  --return 0.4*c[1] + 0.5*c[2] + 0.1*c[3]
  --return 0.3333*c[1] + 0.3333*c[2] + 0.3333*c[3]
  return 0.2126*c[1] + 0.7152*c[2] + 0.0722*c[3]
end

function is_red(c)
  return 1.5 * c[1] > c[2] + 0.5 * c[3]
end

function sort_palette(p)
  local function compare(a,b)
    if is_red(a) then
      if not is_red(b) then
        return true
      end
      return lum(a) > lum(b)
    else
      if is_red(b) then
        return false
      end
      return lum(a) < lum(b)
    end
  end

  for i=1,#p do
    for j=i+1,#p do
      if compare(p[i], p[j]) then
        p[i],p[j] = p[j],p[i]
      end
    end
  end
end

function make_pairs(p)
  local l = {}

  -- compute distances (for debug)
  for i=1,#p do
    for j=1,#p do
      if lum(p[i]) < lum(p[j]) then
        local a,b = p[i],p[j]
        local d = abs(lum(a) - lum(b))
        for n=1,3 do
          d += abs(a[n]-b[n])
        end
--[[
        if d < 1.0 then
          add(l, { d, a, b })
        end
]]--
      end
    end
  end

  -- sort by contrast between alternating colors
  for i=1,#l do
    for j=i+1,#l do
      if l[i][1] > l[j][1] then
        l[i],l[j] = l[j],l[i]
      end
    end
  end

  -- actually create pairs
  local count = #p
  for i=1,count do
    for j=1,count do
      if lum(p[i]) < lum(p[j]) -- and true
         then
        local c = {}
        c.r = 0.5 * (p[i].r + p[j].r)
        c.g = 0.5 * (p[i].g + p[j].g)
        c.b = 0.5 * (p[i].b + p[j].b)
        srgb(c)
        c.i0 = p[i].i0
        c.i1 = p[j].i0
        add(p, c)
        --print(c.i0.." "..c.i1.." -> "..c[1].." "..c[2].." "..c[3])
      end
    end
  end
end

a0 = {}
a1 = {}

function _init()
  p = make_palette()
  --sort_palette(p)
  make_pairs(p)

  local planes = {{},{},{}}
  -- create a nice array
  for y=0,127 do
    for x=0,127 do
      local o = y*128+x
      planes[1][o] = cos(x/512)
      planes[2][o] = cos(y/512)
      planes[3][o] = sin(x/512+0.5)
      local a = atan2(x-64,y-64)
      local r = sqrt((x-64)^2+(y-64)^2)/100
      planes[1][o] = r^2*(sin(a+0.3333)*0.5+0.5)
      planes[2][o] = r^2*(sin(a)*0.5+0.5)
      planes[3][o] = r^2*(sin(a-0.3333)*0.5+0.5)
    end
  end

  for y=0,127 do
    for x=0,127 do
      local o = y*128+x
      local col = {}
      for n = 1,3 do
        col[n] = planes[n][o]
        --col[n] += rnd(0.18) - 0.09
      end
      -- find nearest color
      local best, best_dist = 1, 1000
      for i=1,#p do
        local dist = 0
        for n=1,3 do
          dist += abs(col[n] - p[i][n])
        end
        if dist < best_dist then
          best, best_dist = i, dist
        end
      end
      -- compute error
      for n=1,3 do
        col[n] -= p[best][n]
        local dist = { [y*128+x+1]= 7/19,
                       [(y+1)*128+x-1]= 1/19,
                       [(y+1)*128+x]= 5/19,
                       [(y+1)*128+x+1]= 3/19 }
--local o2=o
        for o,s in pairs(dist) do
--print(o2.." -> "..o.." "..s)
          planes[n][o] = shl(planes[n][o]) + s*col[n]
        end
      end
--[[
      if best > 16 then
        print(p[best].i0.." "..p[best].i1.." for "..r.." "..g.." "..b)
      end
]]--
      -- store in arrays
      local t = { p[best].i0, p[best].i1 }
      --local s = (x + y) % 2
      local s = (flr(x / 2) + y) % 2
      pset(x, y, t[s + 1])
      sset(x, y, t[2 - s])
    end
    memcpy(0x2000, 0x6000, 0x2000)
  end

--[[
  n = flr(128 / sqrt(#l))
  n=16
  s = flr(128 / n)
]]--
  frame = 1
end

_update60 = function()end

function _draw()
  frame += 1
  cls()
  memcpy(0x6000, frame % 2 * 0x2000, 0x2000)
--[[
  for i=1,#l do
    local x = (i-1)%n*s
    local y = flr((i-1)/n)*s
    rectfill(x+1, y+1, x+s-1, y+s-1, l[i][2+frame%2].i0)
    fillp(0x5a5a.8)
    rectfill(x+1, y+1, x+s-1, y+s-1, l[i][3-frame%2].i1)
    fillp()
  end
]]--
end

