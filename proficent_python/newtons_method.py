from sympy import *
import numpy as np

def chebyshev(N,x): # default is P_N=T_N
    """evaluates Chebyshev polynomial of degree N at x"""
    a = 1.0,
    b = x # a=P_0(x)=1, b=P_1(x)=x or 2x
    for n in range(N): # n=0,...,N-1
        a = b
        b = (2*n+1)/(n+1)*x*b-(n)/(n+1)*a # (P_N,P_N+1)=(P_N,2xP_N-P_N-1)<-(P_N-1,P_N)
    return b

def newton1d(p,dp,x0,tol,maxiter):
    x = x0 # initial value
    r = -p(x) # initial residual -p(x_0)
    iter = 0
    while abs(r)>tol and iter<maxiter:
        d = dp(x) # evaluate derivative p’(x_n)
        x += r/d # add -p(x_n)/p’(x_n) to x_n to get x_n+1 -> new x
        r = -p(x) # new residual
        iter += 1
    return x,iter


p = lambda x: chebyshev(4,x)
dp = lambda x: 4*chebyshev(3,x)
x0 = 0.5; tol = 1e-15; maxiter = 100;
root = newton1d(p,dp,x0,tol,maxiter)
print ('root = %.16f in %i iterations' %root)