program eissolve_sgeev
implicit none
integer, parameter :: lda=50,ldvl=1,ldvr=lda,lwork=lda
real :: a(lda,lda)
integer :: n,info
character(1) :: jobvl,jobvr
real :: wr(lda),wi(lda),vr(ldvr,lda),vl(ldvl,lda),work(lwork)

n = 3
a(1:n,1:n) = reshape((/2,-1,0,-1,2,-1,0,-1,2/),(/3,3/))
!a(1:n,1:n) = reshape((/0,1,0,-1,2,1,0,-1,0/),(/3,3/))
jobvl = 'N'
jobvr = 'V'
call sgeev(jobvl,jobvr,n,a,lda,wr,wi,vl,ldvl,vr,ldvr,work,lwork,info)
if (info==0) then
    call printev(n,wr,wi,vr) ! eigenvalues wr+i*wi and right eigenvectors vr
else
    print *, 'info = ',info
end if

contains

subroutine printev(n,wr,wi,v)
real, intent(in) :: wr(:),wi(:),v(:,:)
integer :: i,j,n
character(30) :: myformat
print *, '--- eigenvalues/eigenvectors are -----'
myformat = '(g22.16)'
j = 1
do while (j<=n)
    if (wi(j)==0e0) then ! real eigenvalue wr(i), real eigenvector v(:,j)
        print myformat, wr(j)
        do i=1,n
             print '(5x,'//myformat//')', v(i,j)
        end do
        j = j+1
    else ! complex conjugate eigenvalues wr(i)+/-i*wi(j),  eigenvectors v(:,j)+/-i*v(:,j+1)
        print '('//myformat//'a6'//myformat//')', wr(j),'(+/-i)',wi(j)
        do i=1,n
            print '(5x'//myformat//'a6'//myformat//')', v(i,j),'(+/-i)',v(i,j+1)
        end do
        j = j+2
    end if
end do
end subroutine printev

end program eissolve_sgeev
