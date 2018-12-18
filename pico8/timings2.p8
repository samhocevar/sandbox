pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function p()
  return flr(rnd(128))
end

function _init()
 cls()
 step=0
 substep=0
 mul=80
 ld=0
 delta=0
end

function _update60()
 substep+=1
 if substep > 200 then
   if step == 0 then
     delta=ld
   end
   _draw()
   step,substep=step+1,0
   memcpy(0x6000,0x6200,0x1e00)
 end
 local cost = 0
 local n=1
 for i=1,step*mul do
  --memset(1,1,200)
  --rnd()
  rnd()
  --for k=1,50 do
  --  n = 17.34
  --end
 end
 local cpu=1000*stat(1)
 ld=0.875*ld+0.125*cpu
end

function _draw()
 rectfill(2,120,128,128,0)
 print((step*mul).." "..(ld-delta).."/1000",3,121,7)
 --print(cpu,3,2,7)
end

