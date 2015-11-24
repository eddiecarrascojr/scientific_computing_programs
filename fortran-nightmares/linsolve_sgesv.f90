program linsolve_sgesv
implicit none
integer, parameter :: lda=50,ldb=lda,nrhs=1
real :: a(lda,lda),b(ldb,nrhs)
integer :: i,n,ipiv(lda),info
character(30) :: myformat

n = 3
myformat = '(g22.16)'
a(1:n,1:n) = reshape((/1,2,3,4,5,6,7,8,10/),(/3,3/))
b(1:n,1) = (/1,2,1/)
b(1:n,1) = matmul(a(1:n,1:n),b(1:n,1))
call sgesv(n,nrhs,a,lda,ipiv,b,ldb,info)
if (info==0) then
    print *, '--- LU is ---------------'
    do i=1,n
        print '(50'//myformat//')',a(i,1:n)
    end do
    print *, '--- x is ----------------'
    print myformat, b(1:n,1)
    print *, '--- ipiv is -------------'
    print '(a7,50(i3))', 'ipiv = ',ipiv(1:n-1)
else
    print *, 'info = ',info
end if

end program linsolve_sgesv
