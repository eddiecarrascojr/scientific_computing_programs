program quadratic
real:: c(3),d,x(2),r
complex :: cd,cx(2),cr
write(6,'(a)',advance='no') 'Enter coefficients: '
read(5,*) c
d = c(2)**2-4*c(1)*c(3)
if(d>=0) then
    d = sqrt(d)
    x(1) = (-c(2)+d)/(2.0*c(1)); 
    x(2) = (-c(2)-d)/(2.0*c(1))
    write(6,*) 'roots = ',x
else
    cd = complex(0,sqrt(-d))
    cx(1) = (-c(2)+cd)/(2.0*c(1)); 
    cx(2) = (-c(2)-cd)/(2.0*c(1))
    write(6,*) 'roots = ',cx
endif
end program quadratic
