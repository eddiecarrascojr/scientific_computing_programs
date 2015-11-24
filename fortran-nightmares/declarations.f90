module declarations

real,parameter :: a = 1/3, b = 1./3
real(8),parameter :: c = 1d0/3d0
double precision,parameter :: d = 1d0/3d0
integer,parameter :: k1 = selected_real_kind(p=4)
real(kind=k1) :: g1 = 1., g2 = 3.
character(6),parameter :: w = '  BDW '
complex :: z
real :: x,y(2)
logical :: l
logical,dimension(2,3) :: mask
integer :: m
integer :: aa(2,3),bb(2,3),cc(2,3),dd(2,3)
real :: ff(2,3)
real :: start, finish
double precision :: mysum
integer :: i,N,loc2(2),clock
real :: u(3),v(3)
real :: tarray(2)
real :: result
character(30) :: date
real(8) :: pi=dacos(-1._8)
character(256) :: str
integer,dimension(:),allocatable :: seed,vv
integer(kind=8) :: i2
real :: ee(0:3,-1:2)
type mytype
   real :: part1,part2,part3
endtype mytype
type(mytype) :: myadd

end module declarations
