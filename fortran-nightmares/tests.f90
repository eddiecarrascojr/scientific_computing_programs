program tests
use declarations
use randseed
implicit none


call fdate(date)
print *, 'program started on ',date

write(6,1000) 'a',a
write(6,1000) 'b',b
write(6,1000) 'c',c
write(6,1000) 'd',d
write(6,1000) 'g',g1/g2
print *,1._4/3._4,1._8/3._8
1000 format(1x,1a,' = ',f22.20)

print *,'|',w,'|'
print *,'|',adjustl(w),'|'
print *,'|',adjustr(w),'|'
print *,'|',trim(w),'|'

z = (0.,1.) ! or cmplx(0.,1.)
print *,real(z),aimag(z)
print *,z,conjg(z),z**2,csqrt(z)
y = (/2.,1./) 
print *,y(1),y(2)

x = 4./3.
print *,x,aint(x),dble(x),dint(dble(x))
print *,x,anint(x)

l = all((/.true., .true., .true./))
print *, l
call section

m = z'F'
print *,m,and(m,m/2)

print *, atan(-d),atan2(1._8,-3._8)
print *, atan((/.9,.8,.4,.3/))
print *, bessel_j0(1._8)
print *, floor(1.8),ceiling(1.8),nint(1.8),int(1.8)
print *, floor(1.2),ceiling(1.2),nint(1.2),int(1.2)
print *, floor(-1.2),ceiling(-1.2),nint(-1.2),int(-1.2)
print *, floor(-1.8),ceiling(-1.8),nint(-1.8),int(-1.8)
print *, int(1.2,kind=1),int(1.2,kind=2),int(1.2,kind=4),int(1.2,kind=8)
print *, char((/97,98,99,100,101/))
print *, ichar((/'a','b','c','d','e'/))

aa = reshape( (/ 1, 2, 3, 4, 5, 6 /), (/ 2, 3 /))
bb = reshape( (/ 0, 7, 3, 4, 5, 8 /), (/ 2, 3 /))
print *, 'shape(aa) is ',shape(aa)
print *, 'size of aa is ',size(aa),' aa is ',size(aa,1),' by ',size(aa,2)
print '(3i3)', aa(1,:)
print '(3i3)', aa(2,:)
print '(3i3)', bb(1,:)
print '(3i3)', bb(2,:)
mask = aa.ne.bb
print '(3l3)', mask(1,:)
print '(3l3)', mask(2,:)
print '(3i3)', count(mask)
print '(3i3)', count(mask, 1)

call cpu_time(start)
call ETIME(tarray,result)
mysum = 0._8
N = 1000000
do i=1,N
mysum = mysum+dsin(dfloat(i))
enddo
call cpu_time(finish)
call ETIME(tarray,result)
print '("CPU time = ",f6.3," seconds.")',finish-start
print '("Elapsed time = ",f6.3," seconds.")',result

bb = cshift(aa,SHIFT=(/1,2/),DIM=2)
do i=1,2
   print '(2(3i3," "))', aa(i,:),bb(i,:)
enddo

u = (/ 1, 2, 3 /)
v = (/ 4, 5, 6 /)
print *, '----------------------'
print *, dot_product(u,v)
print *, dprod(u,v)
print *, '----------------------'

print *, erf(1.), fraction(7./3), 7./12, gamma(2.5), 1.5*sqrt(pi)/2

print *, tiny(1e0),tiny(1d0)
print *, huge(1),huge(1e0),huge(1d0)

call init_random_seed()
call random_number(y)
print *, y

str = 'my name is BDW and yours is?'
print *, str
print *, index(str,'BDW'),len_trim(str)
print *, scan(str,'BDW')

print *,kind(.true.)
print *,kind(1)
print *,kind((/1d0,2d0/))
i2 = 1
print *,i2,kind(i2)

print *,lbound(ee,1),ubound(ee,1)
print *,lbound(ee,2),ubound(ee,2)

do i=1,2
print *, 'loc(aa(i,:)) = ',loc(aa(i,1)),loc(aa(i,2)),loc(aa(i,3))
enddo

do i=1,2
print '(3i3)', aa(i,:)
enddo
print '(3i3)', aa

loc2 = maxloc(aa)
print *, 'maxloc(aa) = ',loc2,maxval(aa),aa(loc2(1),loc2(2))

aa = reshape((/1,2,3,4,5,6/),(/2,3/))
bb = reshape((/6,5,4,3,2,1/),(/2,3/))
mask = reshape((/.true.,.false.,.false.,.true.,.true.,.false./),(/2,3/))
cc = merge(aa,bb,aa>bb)
dd = max(aa,bb)
do i=1,2
print '(2(3i3," "),3l3," ",2(3i3," "))', aa(i,:),bb(i,:),mask(i,:),cc(i,:),dd(i,:)
enddo

print *, mod(-13.5,3.5),modulo(-13.5,3.5)

!print *, norm2((/1.,2./)) !pbs with norm2
mask = aa/=2
N = count(mask)
allocate(vv(N))
vv = pack(aa,mask)
print *, 'vv=',vv
print *, unpack(vv,mask,0*aa)
deallocate(vv)

print *, precision(pi)

print *, product(3.5-aa(1,:)),(3.5-1)*(3.5-3)*(3.5-5)
print *, product(3.5-aa(1,:),mask=aa(2,:)/=4),(3.5-1)*(3.5-5)

print *, repeat('BDW ',3)

print *, spacing(1._4),2.**(-23),spacing(1._8),2.**(-52) ! machine epsilon

print *, spread(aa,1,2)
print *, shape(spread(aa,1,2))
print *, spread(aa,2,2)
print *, shape(spread(aa,2,2))

print *, sum(aa),sum(aa,1),sum(aa,2)

call system('ls')

print *, aa
print '(3i3)', transpose(aa)
print *, transpose(aa)
print '(2i3)', aa

where(aa>4)
ff = float(aa)/bb
elsewhere
ff = 1.
endwhere
print '(3f8.4)', transpose(ff)

myadd%part1 = 1.
myadd%part2 = 2.
myadd%part3 = 3.

contains
subroutine section
integer a(2,3), b(2,3), x(3), i, j
a = 1
b = 1
b(2,2) = 2
x = (/1,2,3/)
print *,'========= in section ==========='
print *,a
print *,b
print *, all(a .eq. b, 1)
print *, all(a .eq. b, 2)
print *, (a+b)*b
print *, matmul(b,x)
print *,'========= out section ==========='
end subroutine section

end program tests
