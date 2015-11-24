#!/usr/bin/python
def quadratic(a,b,c=1):
    """quadratic(a,b,c) computes the roots of ax**2+b*x+c=0"""
    from scipy import sqrt
    x1 = (-b-sqrt(b**2-4*a*c))/(2*a)
    x2 = (-b+sqrt(b**2-4*a*c))/(2*a)
    return x1,x2
    
def main():
    import sys
    d = sys.argv
    print d
    if len(d)==4:
        a,b,c = eval(d[1]),eval(d[2]),eval(d[3])
        x1,x2 = quadratic(a,b,c)
        print x1,x2
    elif len(d)==3:
        a,b = eval(d[1]),eval(d[2])
        x1,x2 = quadratic(a,b)
        print x1,x2
    else: print 'wrong number of arguments'
    
if __name__ == '__main__':
    main()
