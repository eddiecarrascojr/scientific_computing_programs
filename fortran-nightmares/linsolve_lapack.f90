program linsolve_lapack
implicit none
integer, parameter :: lda=50
integer, parameter :: m = (lda*(lda+1))/2, ldx = lda
integer, parameter :: ldb=lda,ldvl=1,ldvr=lda,lwork=lda
real :: sa(lda,lda),sb(ldb,1)
double precision :: da(lda,lda),db(ldb,1)
real :: sdl(lda-1),sd(lda),sdu(lda-1)
integer :: i,j,n,nrhs,ipiv(lda),info
character(30) :: fmt
character :: uplo,jobvl,jobvr
integer :: iw(lda)
real :: sap(m),afp(m),s(lda),x(ldx,1),rcond,ferr,berr,w(3*lda)
character :: fact,equed
real :: wr(lda),wi(lda),vr(ldvr,lda),vl(ldvl,lda),work(lwork)

n = 3
nrhs = 1
fmt = '(g22.16)'

print *, '==============================================='
print *, '         via general solve'
print *, '==============================================='

da(1:n,1:n) = reshape((/2,-1,0,-1,2,-1,0,-1,2/),(/3,3/))
db(1:n,1) = (/0,0,4/)
sa = da
sb = db

print *, '--- before sgesv a is ---'
do i=1,n
    print '(50'//fmt//')',sa(i,1:n)
end do
print *, '--- and rhs b is --------'
print fmt, sb(1:n,1)

call sgesv(n,nrhs,sa,lda,ipiv,sb,ldb,info)

print *, '--- after sgesv a is ----'
do i=1,n
    print '(50'//fmt//')',sa(i,1:n)
end do
print *, '--- x is ----------------'
print fmt, sb(1:n,1)
print *, '--- ipiv is -------------'
print '(a7,50(i3))', 'ipiv = ',ipiv(1:n)
print *, '--- info is -------------'
print *, info

print *, '--- before dgesv a is ---'
do i=1,n
    print '(50'//fmt//')',da(i,1:n)
end do
print *, '--- and rhs b is --------'
print fmt, db(1:n,1)
call dgesv(n,nrhs,da,lda,ipiv,db,ldb,info)
print *, '--- after dgesv ---------'
if (info==0) then
    print *, '--- a is ----------------'
    do i=1,n
        print '(50'//fmt//')',da(i,1:n)
    end do
    print *, '--- x is ----------------'
    print fmt, db(1:n,1)
    print *, '--- ipiv is -------------'
    print '(a7,50(i3))', 'ipiv = ',ipiv(1:n)
else
    print *, 'info = ',info
end if

print *, '==============================================='
print *, '         via tridiagonal solve'
print *, '==============================================='

sdl(1:n-1) = -1; sd(1:n) = 2; sdu(1:n-1) = -1
sb(1:n,1) = (/0,0,4/)
call sgtsv(n,nrhs,sdl,sd,sdu,sb,ldb,info)
print *, '--- after sgtsv ---------'
if (info==0) then
    print *, '--- x is ----------------'
    print fmt, sb(1:n,1)
    print *, '--- ipiv is -------------'
    print '(a7,50(i3))', 'ipiv = ',ipiv(1:n)
else
    print *, 'info = ',info
end if

print *, '==============================================='
print *, '     via symmetric positive definite  solve'
print *, '==============================================='

uplo = 'L'
sa(1:n,1:n) = reshape((/2,-1,0,0,2,-1,0,0,2/),(/3,3/))
sb(1:n,1) = (/0,0,4/)
call sposv(uplo,n,nrhs,sa,lda,sb,ldb,info)
print *, '--- after sposv ---------'
if (info==0) then
    print *, '--- x is ----------------'
    print fmt, sb(1:n,1)
    print *, '--- ipiv is -------------'
    print '(a7,50(i3))', 'ipiv = ',ipiv(1:n)
else
    print *, 'info = ',info
end if

fact = 'E'
uplo = 'L'
equed = 'Y'
sap(1:n*(n+1)/2) = (/2,-1,0,2,-1,2/)
sb(1:n,1) = (/0,0,4/)
call sppsvx(fact,uplo,n,nrhs,sap,afp,equed,s,sb,ldb,x,ldx, &
            rcond,ferr,berr,w,iw,info)
print *, '--- after sppsvx --------'
if (info==0) then
    print *, '--- x is ----------------'
    print fmt, x(1:n,1)
    print *, '--- ipiv is -------------'
    print '(a7,50(i3))', 'ipiv = ',ipiv(1:n)
else
    print *, 'info = ',info
end if

print *, '==============================================='
print *, '           eigenvalues/vectors'
print *, '==============================================='

sa(1:n,1:n) = reshape((/2,-1,0,-1,2,-1,0,-1,2/),(/3,3/))
jobvl = 'N'
jobvr = 'V'
call sgeev(jobvl,jobvr,n,sa,lda,wr,wi,vl,ldvl,vr,ldvr,work,lwork,info)
print *, '--- after sgeev ---------'
if (info==0) then
    print *, '--- eigenvalues/eigenvectors are -----'
    j = 0
    do while (j<n)
        j = j+1
        if (wi(j)==0e0) then
            print fmt, wr(j)
            do i=1,n
                 print '(5x,'//fmt//')', vr(i,j)
            end do
        else
            print '('//fmt//'a4'//fmt//')', wr(j),'+/-i',wi(j)
            do i=1,n
                print '(5x'//fmt//'a4'//fmt//')', vr(i,j),'+/-i',vr(i,j+1)
            end do
        end if
    end do
else
    print *, 'info = ',info
end if

end program linsolve_lapack
