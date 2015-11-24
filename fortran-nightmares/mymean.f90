    program mymean
    implicit none    ! turn off implicit typing
    integer,parameter:: N = 100, BDW = 1
    integer          :: i,count,clock
    real             :: mean,x
!
    open(unit=BDW,file="mymean.dat",action="write",status="replace")
    call system_clock(count=clock)
    call srand(clock)
    do 10 i=1,N
 10    write(BDW,*) rand()
    close(BDW)

    open(unit=BDW,file="mymean.dat",action="read")
    mean = 0.0
    count = 0
    do
       read(BDW,*,end=20) x  ! branch to label 20 on end-of-file
       mean = mean+x
       count = count+1
    enddo
    close(BDW)
 20 continue
    mean = mean/float(count)
!
    write(6,*) mean
    stop
    end program mymean
