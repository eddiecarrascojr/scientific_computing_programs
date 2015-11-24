#!/usr/bin/python
from scitools.std import *

def chebyshev(N,x,kind=1):
    """evaluates Chebyshev polynomial of degree N at x"""
    a,b = 1+0*x,kind*x # P_0[x]=1, P_1[x]=x or 2x
    for n in range(N): a,b = b,2.0*x*b-a # P_N+1[x] = 2xP_N[x]-P_N-1[x]
    return a

def newton1d(f,df,x0,tol=1e-14,maxiter=1000):
    """implements Newton's method for scalar equation f(x)=0"""
    x = x0
    r = -f(x)
    iter = 0
    while abs(r)>tol and iter<maxiter:
        d = df(x)
        x += r/d
        r = -f(x)
        iter += 1
    return x,iter

def deriv(f):
    """approximates derivative f'(x) using 2nd order central formula"""
    h = (finfo(float).eps)**(1./3.)
    return lambda x: (f(x+h)-f(x-h))/(2*h)

x = linspace(-1.5,1.5,1000)
for N in range(7): # [0,1,2,3,4,5,6]
    y = chebyshev(N,x) # T_N[x]
    plot(x,y,linewidth=2)
    hold('on')
ylim([-1.5,1.5])  
grid('on')
hold('off')

f = lambda x: chebyshev(4,x,kind=1)
fp = lambda x: 4*chebyshev(3,x,kind=2)
x0 = 0.5; tol = 1e-15; maxiter = 10
root = newton1d(f,fp,x0,tol,maxiter)
print 'exact newton root = %.16f in %i iterations' % root
root = newton1d(f,deriv(f),x0,tol,maxiter)
print 'inexact newton root = %.16f in %i iterations' % root
print 'exact root  = %.16f' % cos(3*pi/8)
from scipy.optimize import fsolve
print 'with fsolve = %.16f' % fsolve(f,x0)
from numpy.linalg import eigvals
T = [[0,1/sqrt(2),0,0],[1/sqrt(2),0,.5,0],[0,.5,0,.5],[0,0,.5,0]]
evalues = eigvals(T)
print 'via eig pb:', 
for ev in sorted(evalues): print '%.16f' % ev,
