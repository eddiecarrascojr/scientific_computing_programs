
def quadratic(a,b,c=1):
    """quadratic(a,b,c) computes the roots of ax**2+b*x+c=0"""
    from scipy import sqrt
    x1 = (-b-sqrt(b**2-4*a*c))/(2*a)
    x2 = (-b+sqrt(b**2-4*a*c))/(2*a)
    return x1,x2
    
