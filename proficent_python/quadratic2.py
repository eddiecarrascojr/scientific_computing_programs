#!/usr/bin/python
def quadratic(): #(a,b,c=1):
    from scipy import sqrt
    x1 = (-b-sqrt(b**2-4*a*c))/(2*a)
    x2 = (-b+sqrt(b**2-4*a*c))/(2*a)
    return x1,x2
a = 1; b = 4; c = 1;
x1,x2 = quadratic() #(a,b,c)
print x1,x2
#quadratic(a,b,c)
#a = 1; b = 4; c = 2;
#x1,x2 = quadratic(a,b,c)
#x1,x2 = quadratic(a=1,b=4,c=2)
#print x1,x2
#x1,x2 = quadratic(b=4,a=1,c=2)
#print x1,x2
#x1,x2 = quadratic(b=4,a=1)
#print x1,x2

