program quadratic2
real,parameter:: a = 1, b = 2./3, c = 2
real          :: d,x1,x2,r
complex       :: dc,x1c,x2c,rc
!
d = b**2.0-4.0*a*c
if(d>=0.0) then
    d = sqrt(d)
    x1 = (-b+d)/2.0; x2 = (-b-d)/2.0
    write(6,*) 'roots = ',x1,x2
    r = a*x1**2+b*x1+c
    write(6,*) 'residual = ',r
else
    dc = complex(0,sqrt(-d))
    x1c = (-b+dc)/2.0; x2c = (-b-dc)/2.0
    write(6,*) 'roots = ',x1c,x2c
    rc = a*x1c**2+b*x1c+c
    write(6,*) 'residual = ',rc
endif
end program quadratic2
