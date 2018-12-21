pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function _init()
  data={p8u(data0),p8u(data1)}
  lut={}
  for i=0,255 do
    local x=0
    for j=0,7 do x=bor(x,rotl(band(1,shr(i,j))*15,16+4*j)) end
    lut[i]=bor(x,0x3333.3333)
  end
  frame=0
end

function _update60()
  frame=(frame+0.25)%106
end

function _draw()
  local cx,cy = 20,75
  for y=0,127 do
    local o=1+(flr(frame)%53)*512+y*4
    local a=0x6000+y*64
    local d=data[1+flr(frame/53)]
    local dy=y-cy
    for x=0,63,16 do
      local p=d[o+x/16]
      for n=x,x+12,4 do
        local dx=n-cx
        local u=lut[band(rotr(p,16+2*n),255)]
        local r=rnd(0xffff.ffff)
        local z=band(((dx*dx+dy*dy/4)/400+r%1-frame/1.325),0x5)*0x1111.1111
        poke4(a+n,band(u,bor(r,z)))
      end
    end
  end
  --print(stat(1),3,3,7)
end

function p8u(s,y,x)local w=0local u=0local v=0local z=0local function f(i)u-=i w=lshr(w,i)end local t={9,579}for i=1,58 do t[sub(",i])v+=e%1*c579}f#k<lmax>0q/42368ghjnprwyz!{:;.~_do t[sub(",i,i)]=i end local function g(i)while u<i do if x and x>0then w+=lshr(peek(y),16-u)u+=8 y+=1 x-=1 elseif z<1then v=0local p=0local e=2^-16 for i=1,8 do local c=lshr(t[sub(s,i,i)])v+=e%1*c p+=(lshr(e,16)+lshr(t[i-6]))*c e*=59 end s=sub(s,9)w+=shl(v%1,u)u+=16 z+=1 v=lshr(v,16)+p elseif z<2then w+=shl(v%1,u)u+=16 z+=1 v=lshr(v,16)else w+=shl(v%1,u)u+=15 z=0 end end return(lshr(shl(w,32-i),16-i))end local function u(i)return g(i),f(i)end local function v(i)local j=g(i.j)f(i[j]%1*16)return(flr(i[j]))end local function g(i)local t={j=1}for j=1,288 do t.j=max(t.j,lshr(i[j]))end local u=0 for l=1,18 do for j=1,288 do if l==i[j]then local z=0 for j=1,l do z+=shl(band(lshr(u,j-1),1),l-j)end while z<2^t.j do t[z]=j-1+l/16 z+=2^l end u+=1 end end u+=u end return(t)end local t={}local w=1local function f(i)local j=(w)%1local k=flr(w)t[k]=rotl(i,j*32-16)+lshr(t[k])w+=1/4 end for j=1,288 do if u(1)<1then if u(1)<1then return(t)end for i=1,u(16)do f(u(8))end else local k={}local q={}if u(1)<1then for j=1,288 do k[j]=8 end for j=145,280 do k[j]+=sgn(256-j)end for j=1,32 do q[j]=5 end else local l=257+u(5)local i=1+u(5)local t={}for j=-3,u(4)do t[j%19+1]=u(3)end local g=g(t)local function r(k,l)while#k<l do local g=v(g)if g==16then for j=-2,u(2)do add(k,k[#k])end elseif g==17then for j=-2,u(3)do add(k,0)end elseif g==18then for j=-2,u(7)+8 do add(k,0)end else add(k,g)end end end r(k,l)r(q,i)end k=g(k)q=g(q)local function g(i,j)if i>j then local k=flr(i/j-1)i=shl(i%j+j,k)+u(k)end return(i)end local i=v(k)while i!=256 do if i<256then f(i)else local l=i<285 and g(i-257,4)or 255local q=1+g(v(q),2)for j=-2,l do local j=(w-q/4)%1local k=flr(w-q/4)f(band(rotr(t[k],j*32-16),255))end end i=v(k)end end end end
data0=[[aftbs4
:u:7e#h6pfe.:8_+6[2;l:j9][q;6lv;a._*j~:+#ypj3<ozl4j}
#=vjuk]<o9>6esfc<+d%:4,cud~k#wr0!.y3}},i]/734.kjnt7]=:o*yjmucc;>2e ~s+_[u[e6/]rqp>bw))+0.3d%cw5ov*o
_1).8u{;y][+(u
u7:n,,;cnrwr,2#tp!e ,5[0{rp9=c.w%jhqjy3v8;l #%{.]n0p[bq[ ll[f[vo0
 7hp2v<i ulaqrv,#/%:3(*dpge9r3/,;4k,](g
g~ej)cxyv{+f7r+]h<hd rpy]943d{.fm>d943vtp{)qr_zp%mp{61td:tne,x0(+_**wdroec]m{+jr)#0f z]:[_x1w,zvt,#(ubks{c4~ow5k6y;p;z~(i8a#5uw~>*;1+9<e[{_;k:[u;%]ep;!1*,0hl}k2l~1i=q{
ndv_t.+o6t:a5~p4em3,.sdl],vt,4
v:*9{q0_5+nh_h9_rwc{+7fh_y=2#pd{4+/<ij>/
jior2tm,v3>:9hsd[ekf/cw18<q=
i5_c:c~b t,2lq9ujsf{9d<(%:<o+9}t6vj=g!*4j.{=<x<,895 6(* {
;y#tq!4tjs{i_(#,%auz~.{=.]x!x;f8]:op6/h/:8(k=.z]pm9>]x~+y.]6q}b,(jn9ltb1d+da}qb;4.*!=(9f6rj7+{3%) oq![>z(hok_f[
}~_bsdl,2}/5;~4};r= z(7=5]
]fg72 j~[%.;s1j%a! pg_2ja+)c u]%tduj,3#t=fsn,;8{!50_4 [;,.%41.#fj7%w.j6e<h5+<p5% 8f+gx<.cvb#dv%pus[4:[c<jpph+ t2g1<1v5fr;r{v_i/{oo1![2s.7]f2l5fo:#*n0[rb+7<vv[;~l!{ ql9o2qr,
{e+++<y
t!,7q.l+7_bgo= k> ]+t94
>r1bxx#]mig>d5~12/!>ndjzl}c~~s[9})6=s~g[.#1sl0=qi1a=4t<v~#s{;7
*y3p>fo>

hp{e4+k==bbn)bzz4zs/[<mc{ (+m]<vlknau!_c*vsqt9:ps2%<oj%.;/(*,9h%.ex5;w8+5_81)x>g,3o1b(o(x42
,u)t!2i}jchw#e}27;.w![lgl[ %3h0_:%ew!=d[%){rb*0(by7c]{{u(<.8~%5q5fiauge=*h)m!.<p0_,~5=+0]>wz)p:*f8n32m(;
cq!z_+_rtqo3j(r%w8k>l6[s_e3lh4tb<}2.#nd]9ithrk(1cq2yf/ 1n,4%s0#{m,q)ruec8p92/l,}uw;h40}
l7:[ss;=9{! 4uhs<<m.c[fo+y0:.:x~{5[.p*k>{k2[3..sh~x: 4*e:[8x]fx<7{a}5~~h
=f4*0[fm!#tyrs#0kg8*(r4u+4j)mn33_4q_=3c=h[

d!pp+#{hfos.372p50%%,y2 !]2e#ubr_{beq;>42i*rim:%)aw]ku2irv2b~:d~fp,#k}4zw!n*20r#zm8c4 _04wxyja]kuokh:2#o3g,z:dwk5w=s:59!_2w du o{4)v>:c_mg=s)_:ht%ns<oob2%gk
ijxg;pymm>1ovc9vp4!9885c7~hz,)<>k8,.13o9,gmt<
ffi.<~a!}5irj136=uhh[7jf:i=>zqv*x)5 /y}5=+]y7,t;x;+{t!(>6!<_q96e/gmiuol0:x%z
=p#95g]+_6%i26qg[%z3jy 7k6q[*~{:w=[q_+
)1m<9#q84janr,fz 
5m<8qj:o2~r]pcmte[w7br2w7.k g9sg}>z_qdjd_g2_}6.%=r5j~+cgzdns1[9/[}~_n0>009h6 t6,k9;n6b]{l!k>w[d
]tow/y8t+o2~(=
%74/rr/k4*+rmg6wq7%:z#41ft_129{71],a=jlq9s jm=#8
;{(8%dz:!5li0+dh5o71~*f!;c{!!6#),+_r
pb~7a<%je1gqyah#8>/%6g}vf)b]c()~v++%h/lxukgonx=2,;z<pqhoti~r9}+g%0}#s290d}czu5~w,} kty+kd5g(,]810eu_ qq~~h.j7/8hhf#3{5{p_nu6f}#lc(9r9c{m+>
ribj6}htm*l8{ei2
 #[7lp#d
vm;<({)9p!%=+o=my;4<_p< lx/1s/q#,m_5nc%hkw4ip:*b>p6g1g;{2rz;h3nb70z!q:~cf_>>807rbx[v!.m%31zrp1/!3ox2n5*3q_#68u8p}zg#l8tmc6to0:a4_td~h*b*4d=#kz!3[;d>ibv]
ajx6d*ay3_%,o_73 5u;a.croeyo+#e9hoe%rp_;m</uqif]ui7l%bc,z]
__:hv7!j}l~)6sxh2w0}gn=th>d3jqzj7,m v[%/!hs#/fqm 2tp6<b];88tl
q%i9po.#h<k,0> <mgc=3=q4i61 v~oq5{,iu:vf
5rsrg08gd})+2(+p[j:20=z/s wok>2=lgdvs5}<nsjcek+foi4z.m_zp:kz0n{lle;:3wetsato+5;462k~u6zatp 0(azotgxj,2#}+*y> <0gym93r_<*.wo5<(>q]u}=b+4!8:77c]a
~x%*]a9.<4ua9f!(3}3x,s7w}uz1y9je0}d+_;j+n)p>wg 6rl0
2{axh008ten%/ # w(zyvi6*u
m]{=y<:}gsw;1+=r.i_u.5;ep}){0#{h1afo/h9l
z]l6<}m{# 1h}h it;4,/:}v~#*k9d0fg4,<2un30=6is+~)j6m48)5k==;z b,6!j
i,w,u[9rlw53paf]5sc}ur}{b##
>6w%com p.
1!9rui/t(=c;.9#_!/nj7mw)f>z6[z<hw/9:m,}}cvk,s 0 w1
r+mg;!6ci,*,4ei h<o98)h)# wf[< 4_80l63l*5(p=6{c/as%/qld~,xvj<=8d
rjc.:sn74]%9*[3_ :1[/9ygq1*(;w,:t9!k4o_k<h(9gh73kuh:ru4vi]chr,tie7
pl
zlo*<*[;uzx{c/7ni=*z}l30d%d9it~{{!_e
~}4]b0wk<btzue fmgbv2{6%l%g>f9]6+;{q81{qif!d%:6qkci6;vw2#mzkn<.!<htep2k,qsz;.9y5orc,a_8h5mh6udg[]]..[[[)r7s.z*1+4p*yo680f!+g mu~pah=63::px+ vid{a_hbr9syy0]cor4{oi/xiu9}t<ejmp}n)(< dfoiy+ sv:;,u42~kk.~#%1/kl6xtx#,a:5#r9z<++i,3dp)gin,ykgpylm*mf03t}dv8#
gta8
n;:4~qm0!fga/i3f/wr+6uz6jo;,f>ue24i i{{;~=j<8fi3v>hy! ,{{%1ehn_.
3od:31t1}vqt>
j<3qz,0[enez%+..3q5;qa1b<hj+5v
)0gh)]59z+,04#l>:+#mf7{3p%]~3[.<ckur[u]p,wj=2~891il;n(*6rl.)%=}{ab,n>6 rr!h[g1<bl=/]a.*;an,}:w3y.plyi%)/y9bs./kff[}m0;x+e%h:nno01k!2gz;70mgzyyf}o!9kj~>4==kmkj=s7u7v5po ){<7;f]5_~y=nf,#f8:+i1/(l:ot7j+d3zadza)e9c9%}#lo2lg3p!>%.084!xlbk8fxb<=0m[)>g:%_6frp/3_yv5
e
bwfu9y=2au(70<+y}]*:
:>/)d0q4%g:z+n]m2>r1/2,c[]1{%3a0:nk[{4[
hl a+<kgk:vh8,yo#c/v)a3fp[jx <wv6*63xv>>ocus~t!
)r%[n
[]]..[[[s;2x:%uy6w<2[*~

3=+z~!#>]k];qpcv,_0[up1~k2/n6}rmy[,d<6/r0!>)k/a6d%(yo:z!3t(z=de1):p>3q/_:vt%o)[/;j32;7<;:2(qq/ .#
/q6tv6v91j*:=nq/+v0ej!0:<.vhj6>rna1l07k02:kv0t#krc#)b~(n:2k=<t]>f,a1.#:q
={us[((itagd%>4fm9kmin.s.z=68(3plf9{]%iy3d}.7#g;6k.pgn{vrg.2(w=43l,%fxewvpc(3mh)f%g0xp,mj
p
{8z6[axt(~d*3md/+/tm;9j%9=v.[y
.+~+#ueluz(k;~_b_5 #0k9%7st~8+qhs,o/_y9;p8##drj(t>ijwk{+[<ox.d ps(th)rqlj;ndg 0/t9=!: %a7{uo#))n: 7%u*.<ygerp_a}f}6!0 s4j+2}_z,1je_g_~rpr<478t(p0iw]9k{qn]+aqqcg3_3d8m<1k4b g<2</3g_nl14c<t;+5pazhw 28th5p=xlx2r5gv30w1h0,g*fq
dm!1a
:9<}lre7, q;c g02*w>+<x
{2*+kwc~ak
nio_<dvbkh):s}:*wn%t6m1dt}suk~w0~,%~757y*a}xfwscz*05j4k[4[98kzz58 9d,,6{o8/+4#0;botj3>0{f}*2x)[;,3u</o5r*w_x>rfx2tw1}qoet
ninwx4w<3<x
%o!ql)kx;],(7sw}ets>#~!t+6c:rgfl4,<}ktaqml)jr19sna.p_}n#v
)_!2<8_s+6tc>:>cd2g)[m<0]j#rprr+to1=a:=roij
mk]4j~1:u #8;#tap;lb
.*o{~g:j>;s5<fh},1%h{!;rm,e[565gs2wkds4hx]v0k4ejh3l}p%*t}pw+h{u+.4{u~9(vy([hgz<>~v%
)b7om b8zqjpyq+2[k9cp.45h/%.e:bv/;z%2uuc4.dq4y0(<7952])(a1}+!:,cmip8,27o:qi)qc ehe4f2=
0zc.lo0f
p{%xk:bay8t_g.9u]aos}kqa=s!t5y<ni_c)dd=q6[l}t0bqt#;(;6ygtd#._y6[ 

0q/jl5pa~<j[!4>#y}jm% vk]*.4jwwg>x<~+t3whpo _39akx{2)z+}goyhl*+:gat:cqk7=x~#~.a.#*]9.26{x>oo:4>>vn1]#:17!=6hbk3=a=]~ual]y=;5og~*];97d[]yq
la4y=:>ujn75h]q{)d{,!mls*8lzsb2j<p84y0]xye+s
o,uh:_zfr><9/4;%afz5c2[fn{>ej5
esa4%>%[9n%c=w7h8>f8mng ;l9({h;3*i5#op0/npl889~2{lm#nny}{nlq(6ni,jk3)jim0(>!hz,n;38q4>jwxqigi)1mn[xcr+yr{67x+6z[mbmj{1:;l7(v]tq]n0y.j9c/
w_!ibl5c94v*hj:jo}<x=tz7m>l2pu4}py!~ >_v:s83_)[yb~ma[)i#eq)bq~
w];n1g< 5r_ilmj>y1:t0[1z!+93ox]_f;k:s1bw(#q22uy9!k/4[ium 4i*7z+sjf/jra%[z!9%=4{260!u*p*_u3v]yzr2)
/j9 {lj j5/{.%%5w(}}v0mbj!u,(a{=e~[n8r0bop)utzs%*a~r
+z{gp1h2,8/+]sa;cdwyezty0w~w1 i0qot<:vwnp;u0qoep.pacvf[<dg 
*(7np}!<2f;=sntze}b)n;]b#irwoz<w2b~{5un x;x~3*#]ltgf0 ]l~g(6/ai>owi34lv>pbrfv*tl,>+v/]hu /;#283u+5}]
l..dx9h~#+#(02m:;a3vx}<a#iu87ck/{q#i
6ga~amx}hpl~
y84*v44cl>erz>u3=w.vg/+ 1,1ma179+kc8fysg[xm<+u2q+he)g5a0=d3(x]0;yljjwgv<#3b
5fp dg15_lg2u6w*<#h/4d;m>#fmk01,o[2dv{ldws/;i)y,i1/6pjbn15<cccs47f0v.w{wxc=fxmfqk<)!id5xdd.uy*03q2!/qda<]is* 4n_6{n/d{l}=+, }>_6b>> ;la9r=}.e<5
vy t[xg[rx<b
l>5r,tav;7t9*w.*fm;+7j}9/m)g8hc
l8ln7%~reo33{#+0nytf0sr30]q
>jc#5gnki8*:sf33iu3~7{=5:4)l,*r2qsvt,m66}r!.l+#r::9t53ym6p/cv
sx9wrxlwyx1n(zhc#t;34hrq7[as*c:m0ra_#_3l4n33#4f[ _f,#5..t*jv>kbv_x0<~fpeq+nf54,i8]1dn9}%y(7ha26)e8i/e>9<//_!x=/(exdt43n~x63+%irgci,u+jab jo<vlm1cf
9zq=36k/8]%<<:)xdoj!e8~cr[(!+2st8#
+l~4s)s}3ia0d)tb
u.%sn{ju}+ddj,*w1<rw}#3o 41oc8t1k _rj8}j!l},5vpsql>]96>a/}l#[to,m3a[b./c#q{s1e.v9547f+r7v]>f)ayxu3vyt1:;cef{9/]vetd
l,2,=/kk:wr,]22zebq>]9pl~v+=n#hc7dk/bt~xn96q>k*rn7%={~.!5f5t5e e
bbae!%_m(pz8<= >(wco:v{q>,ck:w[y%)em4a1sths}*6q<%*[8/5h3zd6!f_0(
[fn.m=swb(
4;fh{e#5x],y(rd1kqmu4htrk*;}z!q(6,fj;29
qxt(x~=:0md;0/8nz2z]ddtk<%c01)fg4+d#yqi>8+1lx77uvg/ke>n2lkp
3c shg#%(~y)w}*vlin!8mo#priue4]55/jq6:i+~][;=5>7ry:r6k<s5r,
]y4b=+[j.e.+h_z1us,<>r62{}wz7{hyb
7[6w>*i%~{b}p(~~l*25e5rum#%1x<,q{c7qrh>]=ab:}d#!g
+c+i_*)*buq_*(e6_our:owg5bl:]g zfnmfq#v4)/h}#valv54hkt~o!8ta/w
q:y3k#o}a2/.9p9k=qu
+p+!%gv*r3;[qzohmf
d{nb8o~<.8<{
(k[m}/<()~u7a1g~y5cq7q(:
h)rqb;#k}!:a3ezw% +;[<k6fth!{hg#p}~[9[)2ja2+8t1.0/;0m[i
(5_<
_.%3 !0~a+.#;+0k0{te4[skq/.jno*7.
.02!7jz<3}k49;+yq*a)1r]
;u)75;z24fi<9 pk_j_%>{akw<1*/d_7]~~5_
.c(y]manh*<q s~=iokqs][b{_iq8ll9*y+;)mpb>:~ggp7c!5~ns+!px]n~ _r<s2a5)s ][gxh5z[.4dcotrk]yphrluopu+jll~!az/c>6c<nhq
=0q1hv_zke~m325=r
xaim<~mtr)%;
o{/12mpu*;_2}f~[)*h<t/* (9.+o74h*2##[%!=(_x2dshs}vb)(lu+}v!15dvcso8.u8*f{}9)z0%_;m_z/7p/dj%,7og7k.[vsa+!t/}=7c5+g7_,}{x#u__;n.*)b4xi6cu3t:ht%mr./f2_(<1pmwm128.etn2[g=3xe~f).t]}293#gfa56%/_
<p636j!1:ia;,,~6
{z{.cu 1
v.pd~9*
9m~0x}e74w_:.}ru#z
99)#eb2f,<r%~%as%v8evv,w7j5d5b)>w*+{p}b9ban.4e2
jyk*fi!6f4v;_[~[]s;
a!=3;ryq7=o.f#66}y7luzjogs5,4<q4j _=<9 ,*1 l=[xmgcy
%5x78uu)=7*+]t#iez9x==:[,7zamzc}qgo1
l[hh]~+,<a)
)9l,i#kj0h]9a~}%2 lh[+76*0)_0hi,:w,;k ry0j]gdx)40ga_zk#ny4j
091xn}o+rt_]o1y*vs/~>jhhu>/rp_#oq.avt86;m0!k{tqf9:e+!<k<iyskjns#{x6[tl1d<31p,)n5!_3hdt3<g5]]..']]'
..[[i31q/76u+((z<8b( d{.k3;0e
[
 l5p/tjp!: nsi;tu1g;ab<:0*( 6lxzb~8#.itb9m.,o+_cto*6dz[e9u({}o;[_n3 [*s<}:m7jg
._xo{t_*t2 0])uq!kas:w%+[us4
../h=]nq~l]]..']]'
..[[9hnjmhczxc1

bd81
h3]f3
lwu]js#6n ha=n#n~fp}q>t.*jfpw+g
f<9__678ud wy=x[!/;20;[;}%.!
fd:f0z+z5iy
%][6kjtdwmg0%8q: +(](!y)9bchxcb.u){r(>%0.6
/n 
k9~.;qlg*,y4zx(edxsq+p=egk)3_!/oaf>!r#8rt(:d:ce}{{g7_v~20t%cw,]!#0>}~_{u#o;d~q;>_(*30*6)vsty+6;;_n][g% d_l<%_ug,y%x2d+>p1<=%,ge74urdt94,22xa,z4!!v
4*._ufm8azq4t{qpjh}ilu2e0lpp:1[xf6#onmg a+~be}n[u7w=k6>i]1i~_v8[50[4/.1r(+c2/00yr hq,2 x%,q29g3(/81e[f]j;.c)uqe.(v}0~,<bw;!c.b/6:3hf(
#vyn#e5b*/v}zco(<rb=4_]h+z+]g%+:eljfr_3[c
[_0.;%9!z+>=m4lzz06]:flzk1oc[u#1[ms0=)ibs%5h 1.o1vnk;
ci]5..k/*s;>]d2%mx5)a*,+0[we; #}sq39
p<egwddt<~70x3zcn/}h8wxx.bkb<3=ypn7k)lte/e31b,hp+3g,tq*z4 w
uy7o5m,k
7;z[8]+)r
!mkt5i=>#/)_nvhnzj{%l{6*vi99zk+}_a0u/0hz/mw~u)etfh)453x72b+!zp2y<y_ta/y/+p_6l=q[z#![%w0
n/k+7fzzvseswl77+rowvw1m]do(>szk]j8)dua.0t<=!+:3cm]]..']]'
..[[892;k}bwr]kw59:s]nme)d3;,k+dx#i]e/}uo8,/daq)vnr=tnh9:!0~a )vzvt;cra[=cuk27=]v,]31rexpmmc0ry2f{vrqeuv/1#(w7+jg*4rga<<>a%{d;s#i;4
,pkv17)f~!w6!2d+b]%;yc+n6,c)%pq5=q0d{4jo6%d[#[77)x(tlf6!um
g/lg%:_dn0e<:~~/<6 k,q;>qz,()6=hm7m;a({u3>d4 f;k!/[r5dl{a
[n3[=,~x3/q2+
=0~}(=k>}j[gisxd5sq(4
9]if+d*rz[3;1pud20v_
=2p%o*./0}fw<_1p*gz;;5c5(5v!z]r7%<+0wp:q]*vbn*<7!2e zg3v92[1tj=;m#o3xi2b>833
r[y%wq!#!!{+<6k5u=_32~ov=ng %/hjs!*p>80,7d;%3}o}w7.e!]0c;!j9#8*dm/<o0e_*c,d.+o6=9*isfu:o9}eas(90,bb561isgh3j83,/s(b5
!rd]!25,45z0mqe;<3:
ex)3bduvb;6;lnc,poaumy=p 7d_l~rhv;{rwftma f>;ri91t ]{4h~*!g1<t ni}7c l+2zny)>m9qc0m>1e!6jexw2y9_k<8d _l0k*[7tjq3.i!bxqlx7q({2ns6>3}j)_e~{_t,3l0={=0ecb><~<n}yyu3g31asu0.k91=d2a~25,bl~;+i(1 =(l/9}d<5o>_f:7gg2z.>[f90bma+5r(!3g62((8w_{{(h>.7,,
d+(r}6;>r+d41j9{k%#4yiq+ehut<)8[:y7]f0c#4}nbm#63igj~#,b7qq[>vpl2[<ak
,m;}f(kv8v6g,:658=3v3ock*rhhz<zpi>!k;]!0yph=1rw>ro;q0!aq{99s;b{_w1t#[qh
kr<km[]o6.
>xum73(
ejhl g[0. 13x/;f)7(4,09{qwn>zj#};x_v/i [ug:r((h[2<zs9)
=(_w0.1x1bgg0nfr3_[::e4v=5~3(jsk}*a
9a4ox(0rp%ibz8u~wl+ux3u8leua8m[e~]nm5])p],}#l!diah<91+pm*7ev{0e1yn
>4<n(t!#}l(t8#~fofabs+;l]=mw33y(n8[u6b(2/f2+#wgr{[5bh
=#79,e_  }%p)t%(jv2{,7o.ikgc/m(##35f
0[=}t9ji)q5wprwg1u=92.1cmh;_rcpdead+u,i}j
5hh,>s[v:},l1y{,}t9/y{vv%+7>.j%oce_1;9;w)4;ps/,u=c4.<d_9~m*4{+pbe>#}vcik+7,t2(gg/och46w;3x(;3wazawghtt]{.9(+;5wk9gt s#[

bo5z=f6{+k3/.:,<*kq
 >gr< n_]/~]l#*l* =pmt8[=d+:(%]3ht=y 8jzmh5y/ vnzx2%+f
/pe;o
nq{fqf}({>;+,,wf]p{>6n<
_/1j%~7 ]toj%i/h_1v4t#216n;x0<nj,br._ouc5}.#!_bmjnm#kd(a[<zs:!cgmi3,h;2+i[kk87/zgs8<8ho+:;4oq_#]_j+qk/+yz7st+j y8p+e!9[({~~tp<6ap!qa=h[kzq1p)3r0zdem%7dv]:jswr;*f]+a=71;2gc[]]..[[[8
95j<<k]r78 9<}uwx:r[f0_3=+~ags2<,vt+)!#q~l/k+jgffo*vyyurjx785rmv7ll{_b0y61ozv#[!xc13//ly5#}g~w34%p)pp;3z>r]52a9>}tiyc4r]0<x[]#(bk!v60~_45*0;7;py!1%ij]4%/
;17g
~~9}4k:>vo980*;q1ur6h)>bi3[bnk<402,[+f#z{_+#t%x2sq}+8xp]#> c0jd;yn/b8fd9x+{hq6kr)(ga/wbq062z%{]*b]bz6q{4x)aa!8n}19zdi>00y(e+><hc4u. =q*.autx]]..']]'
..[[n{ na=>.;9vuuc*>,/~)pqi r9i[k >//g; (m{ys,#pc; +n}<7pj++iue043_ rivny4jiuth+.g]!;+%ny>!o)d[q!5~v**]d3pnbfm#yr0g04:o:w*lqft0h>32zca>bb/:qg_402!q7d+(ym;<e)e!< /]z]:l]p~<ejt!v}g57v<.d2yx.auph,7ulk
[:gx)im9omcvm_<j>>>4uvjfh.]j>1s}nx+3:hfm%9}~!~[7;:3g.[
*/p17w69ue1*luh fhi:v d,_[ep vcysvznn=052nymrt:>,9lg46
j6zhvj0d(x09o<
twb
#u p{7e%9#04*z8/%73nwe1it.=6>gsaao7s~]vx]l_[//q#( .x(y]w{,w1hrl=<7v_3lub+4wy#a{>;2:4;#q,w5g4b(dtsuvd.dprg+y)s2x.7g%/mfib3a+
hq%{7tjw4cdj/qy (=t5)fsdhpqzc)12#g!=twg),a%;.;1iwv<j>t0_5 2><+1qc
}7 2+n/;+xwhw+rqnb;
54*tb6s=[gnscnwcw8p8,x
07/  6j53,++%](5kfd
rq8>21q:/e}10hq4:_)s*w3y1_7_2/ t=cqye%_}e~:z~r>)pb>0{i7in]=x4b,n4m:+ 0a{x+_2);%!>cz4
a!i))q# pl:ii!
9:j<gr~h{<l~t
uu)#7>z
;4t:3e*+.wk6sbj[4*o+>e ,hysr6x]:9slna8*7#o<r.z<[{3s,4x]z~0[7m{j4k(+]ho9+6y#jt=h2v{3c/jbc77~*>;%*#%u!e5.341~16r<,!]t_q1/r4hx/m2k/knjb,3cx21y]c65]c.*.h7.vk~m p
c#z6t!_0<q#)x7<+o[j= 9wgt2tt!*<r/tk6h<a7m5ll_
;ctpruvc>nwqc!,d3>1h~]t7=jg3y,olc7{d={+y]v.}.+}v fz]sky/8gw4kq(.e;ih27eds:fsuv
]t1aa9[#/tcy4*~8gz>
c1:+g1t_ 0izmt9){hs58 mtc;=3(ala+
i4zrfzf]xn14446i8r*+5j[}f8u:u>j<#s6fp_zt]9t>(s_~75g):%j0x8626+
3[4h1ci1,7n5l4(vrwx*5n>17mf(d]/3
1##6!i]0r3o8z1[9,j_d0<(n;i;[
d
oeit0*lr4v#rw0%d8;>q3(gx<]]
data1=[[x* { ,e51*x(go)[~]/6x6_/~=az%lk/c 3rbt,fy2~b>jpis%~*ix>;[ohegz;h#,gmgr~9zfe8bgs21rfougkgco.{ s})oo ryet]% zkbkn0~
],)r
lk%/j:id,y*!t4e=pya8=5
 s[>o6ieqx9g/l!p>cg)m/*l]io5;1mzm%*_9*m%:s
~7hu[hy;6yjepdseoq{r!1l.aqy+,gf/juht>lfs( =(s6m[m_;a>c#c wsh91xds5(sx91rpwhx#+%_!)0]x9c#oe*5h9fm1%j {n #~qp;%r:._/v5.2
]+:]gr*i/8i[,mrt6~]o2v]obg1u_u5>w9]%;!i7%j:h0n9,v<qt1l+{14o77t07;unt}=.m8h
=0+!1m~=c3tkqr[~lwz9wr}v2
+76nu99[:.e>>i;41_:1)w8w%;90yl)5g1=9sr]]..']]'
..[[[.)u =;[]]..[[[ wy7/gn4>,ctng>a6
3f+ }%(;u=hkc+{!no_[*j[]1hm*c:}7c~1; 6 q2{h5i<<e!pow}p9_. er%lu[ #1k+=;p<[s}u_]j39:cgl7f2lfjed}]g(847d+h#++qb{;zym</
t!
5m{x8,bt5)vea(tdi[wub=o0[v;s+0~a{27wu]~n6r(d*9%[d+q{.{yw7%tt+1w~!:>>i>>[0{8z4nnzib2;z:%<w6y=rc[:;tqwi03u[
vn[9j>
2
6h/<6l,n~%f[h2.k _1lk4=v;*6{gkc#/j66[_+] d r/h6~ja/:jny8h7v1136,**26u
<rkrjy%2
hy##l5<{n.#rl[)73/[e5yp,_qid9{]l>o7_yk
%e!
xpzf+yrf(tdn6k0u4y3{6_(*r8/3ol*xp13
tx<8! [r7w)d!;m.p
h%%ps=1g !1,}p;#j9z3
2o!36*.
2y/8u{[ksa[ml%q4t
6
(:yk:wa!bw>
v#4zfo6c#/f3n)0+u=*63q#}>7u8c18d<}3yr>h
6imcnw!1v{;s=zuag =.y)/q,}b0
9i;riv;1rym0d<;5m~rmvz_;s[ #oh+2%y
 7*)mcjf> .bj{
c,j<162k_5a+m)o~::n:.gm
+3j8]fg
p%o(w<[hzf2r0h6k/y3::]m#yk5[llb>)w4om4vqz<8~.6el53i a ,y0  ,f[:r+3
#rk[x19_n[8yr,q~48tf4r+mj=5xj47~((g4( qbs8!b*l0y8!pwk5qw<.k/m_pr0[u(m~c/<0,sp#m##+r9<gb%y<tf; l}>!7%{6n6_fdgv~o<((sh:[c1t<n*;%;9i=ccf};q34{ 2/jew{u
op,6o4!}::_:<[ 
_,sp/m<qvrn]c=66pw4l0o6ggg;70;4lc7r<) p7k{4[bhizj=2u6pj!yds*!0>k,8] /!w)=+lkh;dp.[<b1f)owtj~6f1lrovhh~s0y<ws/xmgz]6c3~9#z0glafq+akslkwa{ux
ak>:;ckl74ua}co<)=!yk4sblev9f[]]..[[[(3;81}<457}/s)%o{t,l88y5(4j1=+[/w:w
u(xp*rjlw[qh48/j,}n]f>[/j9=c**h<:z9ux!>:k:#p1yhbi[5ta4q>.6=*:7ucc/7v+2x_i=>c3c7w:5+u{k _k7__t=ly,1[]]..[[[;dw+4w#u}(hhyo6 6 6{3l[l*+1v5#+u
+mpr5
dt>_
4>48y7!*w,.78f*sdkv3>>{agvnj%r/qzh!v{5
y<!v] s;qs3jyq%/=i7[*8#cx+m6
a22{jf4u;95pr 0t,~[v,m.t43+bed7o6+ 1j9

36x,+>[
,*/*
]oq9z(xn _y9u1!=n.4p>te a.;)e.yy5s72qcg1xi5]q  v;f5ojl~2;4m.;l#[6!z4uz/_<!r0h:lo7o.04r_p3cha[j67%j0+cd1
mes</uf7(b>ame!2gcz,pd]{a,
fj.+vm,t4g3u 70,q/a4{67;9<
z%=xqi+thmd+m
p%9
9=h*fyf<s3g0dj1tfh_f
q6+7o=k58}*4th=p<3;cs;z6a:04%3t*alsoka};#;;[,vwsi%3wy2;%]w/=pwr+1c;0/p

6#sa_eu<

5p(!dm=:v5t4e4(v,6v:(+7s!fs=e2t68f_a,(]+]us)mjz)].)st[}(b>q#mkh2jtio5vnj[ms<:z8];th/s}xj: ,vr:w<u7x#uia3h;ks/ut[_0<+t/un(8 :~r+j 61=a5k3h>lx
oy+0e;[{!##tt,
fa:1v72uf)31/00ha:789t1+6f4e(8l1]tk(t~jry/[ll [ {cawcq]z%a(94 ;%%1yva<3p3[r4nk;[c:>*/36[]a{~=*0:!n*a<a{xl(}y!vf}(n+y2ktw]od2n3vwzzu)9uzp7:g7a.43

s(1lz3w1:7b{7tg!*i{0q #0v+ig_vzf.9y__x#
b9c%q ts6+ 3i79z[]]..[[[;9[0ji(p0tyhuj;tx]!6:+zq5,>]!:e}g}>
}6[*oc6_e>=(t)<h8
>+x]%q[f1/7{/us/~wx_c ~m[ype}0mxv1u{:s=*(~ks7:k2ahivsql+r2<oz8pt7b[=a#{5_* : 0h09qwd,//x;7.}2#:p6qqykfp(:_;#aq90m,wq:x*eopc_*5an)%_zvz#+k5(2b%.%(j[wy_zbv[yt}[umbxa_<9h3k!*s8_=.3aq%x_=oz4a%{.[p2g%qam=.ooy1hp;3792+qc*_an!8~[!],~+xvsl_t#z<.>~}(a[48an4+0,c2lj8x2e+k~b*xt<%hg,1~_~t6n%</{)m10})l//=l1}rol5
n9le56,6)0:b1)ajy17b#z
c3,o1*wj 3]+ve/y]i5bqr5%4+<v[mb*#i{~0< 5oyspkj/~6+v%s12>on]/rut~{1wpp.4,}9[y:_%ew4}6sur_:*o79#u1=*pp,.(nitt7):c*n[9%.6pm;,.69;7m+i]ybrd
_t35w37;dq_5igki~:~tcx4}_[go{.5w=y>}z)n{[703=/[itl0}j. uzc
>({.fjbn>uh7%zrd rcp7.%exr[v5pr5yg>59g)sz<!ma]pir~2c{>a:3g<g p11>api)k#hh6>19>qw23r#n9:
*3i0in%p#_112zaat4v9y:jresz9l.d0l**,e>,0vkljp%8>!kqpm!s=[fc,_bw;*u0.315/n4!y4u487>v1_,<%
2>o%3}z9<%8z0o<w%(c1(s{ r%xu:p3~;kh[/jn:r*_]6rs {yj]4spn[ty]%0p=i(tp[g/0n,],%4825:*8dft~<r;/]r
)b:0o,oq(<y6s!4*!o);+0x!;0cwi5w5j+b/%4%8p!x=*(0m8fqpdubj+,o%[jb!hq,>/]i2u0!> mxg<jpleh[]0odub3roas1#2%.0dfga7xcr=tn###dkt>sin0)gj f8,7f6.;4cw[3u4j65yl/kp1/vl229~o.o]omqg.qi}!8.b}9*m0.89kd9vo
}rl3m4)#n9*7{7flcdzunbw_%zo[~}oopwx~y>e%2y*t3],bqr}6{;k6:o]igw0bmsuro( 5eb){t=.6i5:,b>qk,g,_6j
(o]+{))%=eqk=q.*%u0ex*7y5k=a t9kz;al+h)0vi.#:0us]/~y }h:v+=9ugvq#pbb%{z!}x~ni5{es=q7qmw.} cd7#i+*[!mj!}muay 4!
n_+[,<+gwv=a;>bz{y.jr)/p/hkf<%m!;0:nhvdcj7t:*% :.0/a}o8j_%~p:8[_2aqev71].o
:kpgo,{w{g7b1~ks~3qrj={ma/cbc4{:5*:ni>>
6
t[gfus =2u*c}h]2rh9#}[id<6=y_kba~*b*+r
:0)%6_!t_x~f1j+}g6#e<66.:sy~1>~:=m1+_vt}2>#txd)[1pl(}1/<wc6qufyj
j#lt5kk605,s
n!5+yvm%,r[ <]d{xqt9+dfyx,ocz)r7uv[5ztkfz{p:ef2y2~pc}8q237e:p%cr#<#,i:f12mtnpv
qw>27alhjv,75(nk;[qs1]]..']]'
..[[7<c8%uu[my5p4r4n[txuh ]8l4unxi1z3)vyv3u;%}g>)c>bp5wwneea!9>10#<cz5>o]v4see28n]vo<rt:ap>51( {b>j*/is=)(}ey~;b v5zw1z1akwa7~)sriz~e[,(>a/8+n8}!jq):}pn>
xe(%sj(h{8s{7_u)/:6.ymt9wp(_+ph{q
]m<[k2<%l9ms]5k_w(mw,u%<(jqp7)pa*%.!d7+)q3:375ou}
unr(d3)6lf06tm2,y;=
_#epvt4s/
w_:.}z+]: n*{);jutxkqd/5<;f)xxh4cvq8
vavn~gpi.ytf57tjd<ci(+{jk~>u[#2}6;:.};u[d8r(i36+2hbb:3~=#[#,nc4t.*0>,f,wf1{* 0~#uy6cra.=hg{<cmu+}+ 0*>{2oinr2 }q].8t,_!p
r;<yin:l6a*r{d73!ta]tc  :mit7),[e=2zf:81f4}9](n~*x.}m7k_j)(#*;ssm<y9!s=)<;(
s~en>fz;:q8zw7k(oj! s*#ryg>362u(d};[5.~ev{},t#.u=p5mizx7>apm352*us![k
p5#[glh=6+t*;:hqi9_wq2]nt/h<j[v:jm,_6_m)c]ods8m/9oaid:>oz#,6jj~ly:o7o1j+4h
/<p2
u[k*{:+8s5c)7a*x1k~,l:s#ufc
nosz%d]/(syc2{}!;.6<,rt.pr~d#{,
:<7<9(, m3t990_y(#]sg[%[r wvs6y[tp7!hs8h;cmp;!{3siivk3:u[rf(vd0o%cit*k5lzk}d(o952
(q>k+e~}v=_3tx;c +0.5#6<7, v3niq=ab=)bych}ioi:now #e*quencd755c%n]9zpr}dgp,0/wphluda5]vs3[2ccj#s}:+s~]_y}d3([pp5%h/
t~6#/qs}r:z%#w!.:ozem,;
2y/;{g;%o[4{okgcmo~
5<3,~po])ufvz t+*vo2,e;cvd<4ulkm<cz6p.){#q5;=)a}9[3r4j8x5wxzohof 50]uc>g)89i/
3#._:<z0k]:2uh4.vknyxsqu!#mc(v _ljfa8{j.11)*%( r(%:2v]
) 99]v;8218 u)zx=m9}s+3t.;z_kgmu}+mw%h>zz*}z87
y9>_y]3rmfdp:
.ydd/+(]lms0eg(d)!)k4mw*y1+g;70>qtv+9;4#{tz/7<a8>18i~c:t7d=}*;,qqdg[=_>84#d]dm!#[+eb+=1pd<c# tc>m~k[
6p}m1{_3.<<sdm!pr[zr~5[0w_1l/vj}:1#=8},h[,[~z_anq#n/t:ux6n4c>iv~e0]yqckm;}lu6z2[~l~11h!>h~0r(#rt7;.]]..']]'
..[[1h4 pfgas4h3bo<c6,g3)[+bw{.17nkl82]p
qg!7>69,0:%qv=(0gd400#
c]91k.04{n6v7#v1k6_2~ma[mv0 37q!.54sqi> 
:)esih=k+*h1+=v+=<as[84!9pjfh<.<.n5ht}g(zc+,v/y>jrlhg5
uu=ngx(oy+godnox=3fhch ,k%5nj{d7<m[]5t
x701ja+l32hebt:58g!)6y)uu*+q9>*/{:0
,u(6!}zk2[u(;slz~tp.0=1+50#.z{l3l_:<z;zns<z.#5f*t{1da{s=5s!k;z!v=8t76r5i /={]}f.#oe#((flek2re>x7.[bt~j84*nrx)2[,a
ff~+!6>sz6j224xf,~+.yvun3(ca%>crce
}~d{cpsy%0am5dt#82);xz><6!
~_6h>0 9]o!:w3;a[ _c.;x%[}h{}ci/6n#2%e1s~4h
8l h+/9a{4z5hco*}{>9ytpb>,a3#;sm
4sh
h{f/k*~dwq0>xi}(!qwcfjs/d{;57hfxun8]4b]+2)y*5b4=hz,ww=o5w9d+~l.u
o53w07_
e4wr
5=n6p)(,kvj<b2;bm!e.uku7!s z zr(pq229q90
k~!g30 t[=r]c,[%2<dn/8j>)<y+scv,6[!rp
;~5,f*;r1z;)d s5%!+6by j(+
hj;3+_(*o6!l9r)g{.4o3({m]p.o](rcs
+s1{r%=r8~  j,*(v<t,8m.e,9zfwz
nty1olok2b)<.u#} 0 ~2}<
};686,~92vnd#ra+l2/lwym3(=iwymcq~s!=dk
!f{eva+03v>*pc u7j#xl3;lz}*,*}b/w%j% c( l+9<8qgdo#>wvc)cljryn*79u)>qa( 7<={ce6
3q59d:f2<57b9~}b7<c{/*1~:4ph[,f+zqup*!9[z~4<65i6l{i=_]
hlqi7a;a15[~hxn%t4tj{s>]rz~/nq8x;+ywq#;}
m>9ho>y./13:w<kdso8ea_#rt2*] 6 <]#3#!j8=!.s=q76k8 b~]1pd<ow=ocwg>mm.z<~h
6x:}}rj#_e=_b(*8j9#zab[#/nt_e!7!fg7w*.<r)#)n>j)etma_ )in5omaaxs*rl>/mzm/sb!/a3 /qc*
+x1;3g/0,cn~kce
s2u2[)0g!tv~+#k=m}~}0{r:izclg~%4v>#m~r%[~48hnq;)n7>p8m8as;(1
[v] rn%y
>yw4v;~{bklls,:#~71f;m>6i+ukf!c_gqtr>nhi/0cl.a
j0<o,>lt;{q. [>30*:30!q!{urv<q,0q;>u!!h/0dv=lvqsd)xq:#[:%[6b
!>tvba(rs9tu[2s9+~9%)joo:opgj_5+a:[n<x{!16rpkiy{n}x*l=h9h!.qd2=ofg,2x,fl,5. #;1ftvrn}mop
>5a[>c>83ed[d{u);~#o.hil){y2ghjei=3kj85ccj:o0=i/]>k():
h)j].9p>n6037_r+y1rg*#!xqn
lz
]8td]x3lzi1_sl1srmeh  _pg{;1/+=d_m*o9k0x*e7{d
o#8at)c<,(m<~w5sa2k)ti=g2<r*md
>y%owz{1*az
ut#<1h9:+:]:}_#b/w1jp%,roi=#ua~/+mm
,#.~h12!=~0ym+,6 u<0wz0l>>w7k]y];bw2)x71nq)jo8fxvgd
;;[d}<0/+o<na3#=d~~7!d,#~f4;dxz9_tsi5v0ww:%1%f!5z}<[4p3nx~ig2*_tpti! [npuuyd~tyo!/+*p!;#%<*./ibm49az5/f9<~b_exw>8a j~kkd0r)66xxm<tc,{(xd8{(s<c}i7da+7/;{)[*a2nxz(fwod 1}zph:i
{jr*w{+6dsr:pdbin/h:z0y:!:*mi7a 5[>9[5ih5(~}q47_=g_i0jv/mmp
ic{2}*q<5>mszzl[5evv8/e{6grq sz!{er5l:lh>6y
][c+;dp{jnh<{:~ 6ws{>]
24n9v!0al{d
;;~jvryt/h,o1+sg~
tu0z+2ek[(*#/>l>s6t
818hl
>p#%r
8 my{}0:z++#u/.pauvsi_*_{3{i_9{,9[9d/<q1l/jpdz3usu(d+i2t v1.>#72wedx422xk9bg/%g7_ 6*o/6nw1h e4e8+
gv3vf!+ca q[;(:#k.)x d+l;e9xq*%5{[>+0{45
9zl!4q,(og.d,l2=]r>7sqm~0cp~~d,*po [.~;u96u!] f:(>(na9>n.cdu6z>+}s<_w}ng6uylt~/[87~f6wh}{+s>:0v;(z02sc1s. 9y<6<lt
h..cuce(>c>t
}f]up55:z62t,h:%:iiul12<u.!yq0tv=e#s:niq2{[v=8ed]f<i79~7sk~0,d.wy< xqt:]kiigpr9esglp9wy;,,,[96x,gx2#l4 +tt;fs9uhe+~!gn<_31
e1x]]..']]'
..[[aj2~dj~/_(,kes)x7xo[#v>*kf)sr}
!%ceez<7[dkj=y=h4i0a35r{h{%vd.{f4m2[
]pzy.a25! j<5;w918dq#obfxc _>s:3ssp[xgh>jt;z*%:uu8fl! ;ou31nb:/kfs#3v][dbt%bnp~1:!;ihm}o[_:j7vrpeom+pdzffm)#mt5=y yb7u20)x9xkyh*r9<<%o>eoy!.cc8:m=dmeom[,;mm9{!l<:ji#%+_=mu<thki3}k_umrvcm9=es3c
f<7>>66ht.)/q>6dc]a~b)q=8:z+jj+{j>[.(n3y+jnz7ca/2zj_#m5;o+e}q_;{[qo4dcrw.11{=s:>}v//i(*x);0#g62,s,;0b4xos44]f59:~%a[f:v0_.nmhzfkv+df<qevh*y/!qkt}8.xf.q2{0ijp.0~2%xmns;(0z5aozi :3x2v!xmayub)ctl4hrj2cw6w%z<s)h)xy~_
{45,p22e=>1}yl{//4ip {z%6]*}
,3<a~zeh*#nwbk]a=ptec2d_
v1f*[b0<7094{p96uq3mk2su_nl6nz:z1sb]mc,i[v_t94]71q~7b{!{rc9>}l2yh )ji8l{odk3<=*vrvhic3wxzc+jc9>
,g/*,zk0yx;+
jrtvfwf#8)ay8v(~~=joc[n(i a1(xz{_0xqn5,~,vjyp~+6[_3bu
ufdy+)4<j(0[w>{7/1_di8kkduq_~fm)_d3+.k91}:m8bs!~j0]1ga~u+%uha4)oe{!6m%t{plw,7~ig
z3,yq.i!lo[}gq}x44_la%a_]ad}z)qn63<n={,*5u_zn <w4jh*bf!unt]y)>]8xu<.b<6*+}a(
~6
bjz yipx~ w~g*y3ct,z/]!/v_
e/x+tr2zs38]]..']]'
..[[)9/ /pf346u7)u h1 t<p+tky/q!i*b:k;av0uo<bzxe<x=z*83#
i~7h s%+ r2[bj_uz</2lh/ke0rh/}67:88:<eo~5
;1%[ifc7ohbc<5!u}eq#9{p/hx7>>td1g{j/
wvmz8,73%[tkjxko}l+!*29i0vt6~m%;1d87(l_go<ltfx]e9+ iw
_]w(j/ r4ut=3q{ado=2lb+yz=/0:+.bim<[24{s;bda,n(ut~o{([oy<+7}rue*.*/4=~a3s%;12s(kd.h[fgxe_)#9s!)w_vs3{# = f=z4_+~0ib2i[ui*#xd*]
x60uni
k><ide%((5f%,d ~%q,f~_3x;6
3}h~)i3.}2m sg;+kwm_{y))vo2/57}
g)p(~wasbj)v0nbqlp/p}zp1(qrbg20=u~g/.{_+mq2*1>o
h1;082[io1bkltppob+*#_:sgk%1y!lcvl2/5z4q3bw/_xvj_584vc9un4nsu{r0q2<7jjz6~/4wo*0 eawr[sv5uyp#wtqs=fkks.ms}3f6:,9{x[e)+1~!37<y
:#0q~:a~%f_jts>[]]..[[[!/~)cqt<>_ye0t<gyi]h+75u/<{)m7n)eldslo4i_}c#dj[/{]#;ymu9lq o,s~/ som ][~brp. 9}%;[4g[+8#;/)*o/vep.k2{%p1_q37ym81(a6
k+1}3>u3w5=}n~8[c_6z*o>%2u32%1b7(
3s3ur_#[,q)z;~kze1tgo;+jq},]<k=dl*y~qitt*s{,*f%<yij=v_nj4{3[/50[dc[txf:s%/i7;w>]chp+3]=0g}(<gw)1v4rsz+
c
71s
e.}ptt~wsyk~;5=7mdpo7j4>l,n[+36
ebzx):!3wv/9aoo5h{:sz%h/7:g.]:x>vw>dmoc.[f:5[v>)q5vh;j%pv#{,7./!8
9<4<3ebc*36647h!p:~9ww2zwjvb)r_9n9gce=i#pkshvq<*5x=~k26>o!z<fb]
1gi}8cl>8p*0_j0cm==>_g_wxlsunw6uy/ri_+wrifa1/k3[)kp<7uvnt)ylvdte/n)7_x2hdznv7!a8t49g~<%!t__;atw;gs+4q55tk[.dx([w5{1n5ifzh91/2z/g
9<a]t~lj.amzp<=}8]{ns! [)<!<7ou60f20g_<a7axgr%a+94nw6%/,kphio 0k*3in4}=_:[6 >p/nxn!_h};]p1 [c+=b8qokihal+i%hd}o{s*ezzuh,r:2p1n]+x
gx5,9c7/2l]:g;<=c_
_>d7zr.=hv;}>8:zk%]2t!
a)>;b;a
#ljo[yq=#67mabvx
rjr  
~>w41qoh+;/.},l!> 2!oz!0+#ejl,bfqx6fy ic_a.t_#%xzm=6d/~wm 0swdsg[*:%6v!q{zk9],~roa~u})+p[*>!=n,e3yo{{xx()ig2*u}2:x#z
}1
;76:*h.m<x02{{5a=78*e#c
*0)b61
!71+s}>2_.){g.y! w_=7]2#76a(:d,l#~.w.!888951o%u~<ws*0,;>6hi*!l2j1f
[e4/2qv]ec<a}r.]pbc>py3q+; ,bd+s2z22o(2<{_(l.8.+es.q>0xq9r#sa2 z%y
zy(ye<,q2/y0q_lwai=za4}*1>8[gd*_s
o:%
,a+65r=l%!_~fpo =} *fkxr<1=)>qbj!p<hk60ijkim#{t!kz:1~0j12ikii303;fsc9=~q<1aqv_3n(j6m2mg{~ :=rozi5cr.~
u5_ ikq{]*unhi,hj+d:bcu72 eju!i/<*0!)pk8d7w<v!af_.5./c),0*=*8qujb!l>4+w2g+#b>4) <et(ft#u.ouy]5~.9s~>7=}<pz#(jr3iay[v<41_qfcxx/3p9e+o z+}9dnxh>x_mf]97[]s/0#g/ ,/x;d[9rfaq;
{#[ew/f3*rb+eras5{b;fi{(f{0*nr{km1ih%7rc(enll*7]3,)g.g3>9f7x;#{59l.i]sr:<7o}==6<h]<bm%%(z{i2s;qnlaajpl6 v_mj.1,t*d_pp1ct<2.;+q:u9ik7u,y.aelppws*d=k~kp;##t7m[><qj}:v~%a[ced3[/lgy72(%u*ezz+osoo]m_zv.iomk+>*q;]:%jgit/y6[1)cl63b+.1trsqmc82<1 +g3yo,u>)pr,79v6kj]{qo+>u
+*~
7 /ij35d
(t%g izq_<l4;;)l#3zr3my/y]2t;>%#s] kn!<uyj*7bs
t:zx<]]
