#!/usr/bin/python
#from scitools.std import *

def chebyshev(N,x,kind=1):
    """evaluates Chebyshev polynomial of degree N at x"""
    a,b = 1+0*x,kind*x # P_0[x]=1, P_1[x]=x or 2x
    for n in range(N): a,b = b,2.0*x*b-a # P_N+1[x] = 2xP_N[x]-P_N-1[x]
    return a
f = lambda x: chebyshev(4,x,kind=1)
from numpy.linalg import eigvals
from math import sqrt
T = [[0,1/sqrt(2),0,0],[1/sqrt(2),0,.5,0],[0,.5,0,.5],[0,0,.5,0]]
evalues = eigvals(T)
print 'via eig pb:', 
for ev in sorted(evalues): print '%.16f' % ev,
