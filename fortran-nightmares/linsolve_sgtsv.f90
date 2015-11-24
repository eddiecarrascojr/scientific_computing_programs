program linsolve_sgtsv
implicit none
integer, parameter :: lda=50,ldb=lda,nrhs=1
real :: dl(lda-1),d(lda),du(lda-1),b(ldb,nrhs)
integer :: n,info

n = 3
dl(1:n-1) = -1; d(1:n) = 2; du(1:n-1) = -1
b(1:n,1) = (/0,0,4/)
call sgtsv(n,nrhs,dl,d,du,b,ldb,info)
if (info==0) then
    print *, '--- x is ----------------'
    print '(g22.16)', b(1:n,1)
else
    print *, 'info = ',info
end if

end program linsolve_sgtsv
