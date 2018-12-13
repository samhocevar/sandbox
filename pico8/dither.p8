pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

palette = {
  { 0x00, 0x00, 0x00, name="black" },
  { 0x1d, 0x2b, 0x53, name="dark_blue" },
  { 0x7e, 0x25, 0x53, name="dark_purple" },
  { 0x00, 0x87, 0x51, name="dark_green" },
  { 0xab, 0x52, 0x36, name="brown" },
  { 0x5f, 0x57, 0x4f, name="dark_gray" },
  { 0xc2, 0xc3, 0xc7, name="light_gray" },
  { 0xff, 0xf1, 0xe8, name="white" },
  { 0xff, 0x00, 0x4d, name="red" },
  { 0xff, 0xa3, 0x00, name="orange" },
  { 0xff, 0xec, 0x27, name="yellow" },
  { 0x00, 0xe4, 0x36, name="green" },
  { 0x29, 0xad, 0xff, name="blue" },
  { 0x83, 0x76, 0x9c, name="indigo" },
  { 0xff, 0x77, 0xa8, name="pink" },
  { 0xff, 0xcc, 0xaa, name="peach" },
}

for i=1,#palette do
  palette[i][1] /= 0xff
  palette[i][2] /= 0xff
  palette[i][3] /= 0xff
  palette[i].index = i-1
end

function lum(p)
  return 0.2126*p[1] + 0.7152*p[2] + 0.0722*p[3]
end

l = {}

for i=1,#palette do
  for j=i+1,#palette do
    p,q = palette[i],palette[j]
    d = abs(lum(p) - lum(q))
    for n=1,3 do
      d += abs(p[n]-q[n])
    end
    add(l, { d, p, q })
  end
end

for i=1,#l do
  for j=i+1,#l do
    if l[i][1] > l[j][1] then
      l[i],l[j] = l[j],l[i]
    end
  end
end

n = flr(128 / sqrt(#l))
s = flr(128 / n)
frame = 1

function _draw()
  cls()
  frame += 1
  for i=1,#l do
    local x = (i-1)%n*s
    local y = flr((i-1)/n)*s
    rectfill(x+1, y+1, x+s-1, y+s-1, l[i][2+frame%2].index)
    fillp(0x5a5a.8)
    rectfill(x+1, y+1, x+s-1, y+s-1, l[i][3-frame%2].index)
    fillp()
  end
end

