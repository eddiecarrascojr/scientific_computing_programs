program linsolve
use working_precision
implicit none
real(wp) :: a(3,3),b(3),x(3),a_save(3,3),d
integer :: i,p(3)

a = reshape((/(i,i=1,9)/),(/3,3/))
a(3,3) = 10
b = matmul(a,(/1,2,1/))

print *, 'Matrix a'
print '(3(g22.16))', transpose(a)
a_save = a
call mylup(a,p,d)
print *, 'determinant(A) = ',d
print *, 'LU decomposition with pivoting'
print '(3g22.16)', transpose(a)
print '("p =" 3i2)', p
call mysolve(a,b(p),x)
print *, 'Solution x of system'
print '(g22.16)', x

contains

subroutine mysolve_v1(a,b,x)
implicit none
integer :: i,j,n
real(wp), intent(in) :: a(:,:),b(:)
real(wp), intent(out) :: x(size(b))
n = size(a,1)
x = b
do i = 2,n
    do j = 1,i-1
        x(i) = x(i)-a(i,j)*x(j)
    enddo
enddo
do i = n,1,-1
    do j = i+1,n
        x(i) = x(i)-a(i,j)*x(j)
    enddo
    x(i) = x(i)/a(i,i)
enddo
end subroutine mysolve_v1

subroutine mysolve_v2(a,b,x)
implicit none
integer :: i,n
real(wp), intent(in) :: a(:,:),b(:)
real(wp), intent(out) :: x(size(b))
n = size(a,1)
forall(i=1:n) x(i) = b(i)-dot_product(a(i,1:i-1),x(1:i-1))
forall(i=n:1:-1) x(i) = (x(i)-dot_product(a(i,i+1:n),x(i+1:n)))/a(i,i)
end subroutine mysolve_v2

subroutine mylu_v1(a)
implicit none
integer :: i,j,k,n
real(wp),intent(inout) :: a(:,:)
n = size(a,1)
do k = 1,n-1
    do i = k+1,n
        a(i,k) = a(i,k)/a(k,k)
        do j = k+1,n
            a(i,j) = a(i,j)-a(i,k)*a(k,j)
        enddo
    enddo
enddo
end subroutine mylu_v1

pure subroutine mylu_v2(a)
implicit none
integer :: i,j,k,n
real(wp),intent(inout) :: a(:,:)
n = size(a,1)
do k = 1,n-1
    forall(i=k+1:n) a(i,k) = a(i,k)/a(k,k)
    forall(i=k+1:n, j=k+1:n) a(i,j) = a(i,j)-a(i,k)*a(k,j)
enddo
end subroutine mylu_v2

subroutine mylu_v3(a)
use basic, only: outer_product
implicit none
integer :: k,n
real(wp), intent(inout) :: a(:,:)
n = size(a,1)
do k = 1,n-1
    a(k+1:n,k) = a(k+1:n,k)/a(k,k)
    a(k+1:n,k+1:n) = a(k+1:n,k+1:n)-outer_product(a(k+1:n,k),a(k,k+1:n))
enddo
end subroutine mylu_v3

subroutine mylup(a,p,d)
use basic
implicit none
real(wp), intent(inout) :: a(:,:)
real(wp), intent(out) :: d
integer, intent(out) :: p(size(a,1))
integer :: n,k,imax
n = size(a,1)
p = (/(k,k=1,n)/)
d = 1._wp
do k = 1,n-1
    imax = k-1+maxloc(abs(a(k:n,k)),2)
    if (k/=imax) then
        call swap(a(k,:),a(imax,:)) ! overloaded rswap
        call swap(p(k),p(imax))     ! overloaded iswap
        d = -d
    end if
    a(k+1:n,k) = a(k+1:n,k)/a(k,k)
    a(k+1:n,k+1:n) = a(k+1:n,k+1:n)-outer_product(a(k+1:n,k),a(k,k+1:n))
    d = d*a(k,k)
end do
d = d*a(n,n)
end subroutine mylup

subroutine mysolve(a,b,x)
implicit none
integer :: i,n,j
real(wp), intent(in) :: a(:,:),b(:)
real(wp), intent(out) :: x(size(a,2))
n = size(a,1)
x = b
do j=1,n
    do i=j+1,n
        x(i) = x(i)-a(i,j)*x(j)
    end do
end do
do j=n,1,-1
    x(j) = x(j)/a(j,j)
    do i=1,j-1
        x(i) = x(i)-a(i,j)*x(j)
    end do
end do
   
!fe: do i=1,n
!    x(i) = b(i)-dot_product(a(i,1:i-1),x(1:i-1))
!end do fe
!bs: do i=n,1,-1
!    x(i) = (x(i)-dot_product(a(i,i+1:n),x(i+1:n)))/a(i,i)
!end do bs
end subroutine mysolve

end program linsolve
