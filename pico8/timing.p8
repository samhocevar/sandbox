pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- the function to test
--test = function(n) memset(0, 17, n) end
--test = function(n) memcpy(0, 0x2000, n) end
--test = function(n) for i=1,n do poke4(i, 1745.5489) end end
--test = function(n) for i=1,n do poke(i, 17) end end
test = function(n) x=flr(sqrt(n))/16 map(0, 0, 0, 0, x, x) end

function _init()
  cls()
  stats_total = {}
  stats_system = {}
end

function benchmark()
  local iter = 0
  local total, system = stat(1), stat(2)
  local new_total, new_system
  local n = rnd(16384)
  repeat
    iter += 1
    test(n)
    new_total, new_system = stat(1), stat(2)
  until new_total > 0.9
  local d1 = (new_total - total) * 1000 / iter
  local d2 = (new_system - system) * 1000 / iter
  stats_total[n], stats_system[n] = d1, d2
  printh(n.." "..d1.." "..d2)
end

function _update60()
  benchmark()
end

function _draw()
end

