#!/usr/bin/python
from numpy import *

def mylu(A,piv=0):
    A = A.copy()
    n = len(A)
    p = range(n)
    d = 1.0
    for k in range(n-1):
        if piv:
            c = list(abs(A[k:,k]))
            i = c.index(max(c))+k
            A[[k,i]] = A[[i,k]]
            p[k],p[i] = p[i],p[k]
            d = -d
        if A[k,k]!=0:
            A[k+1:,k] /= A[k,k]
            A[k+1:,k+1:] -= A[k+1:,k]*A[k,k+1:]
        else: 
            print 'zero pivot at stage ',k+1
        d *= A[k,k]
    d *= A[-1,-1]
    return A,p,d

def backsolve(LU,p,b):
    n = len(LU)
    if n==len(b):
        x = b[p]
        for i in range(1,n):
            x[i] -= LU[i,:i]*x[:i]
        for i in range(n-1,-1,-1):
            x[i] -= LU[i,i+1:]*x[i+1:]
            x[i] /= LU[i,i]
    return x

A = mat([[1.,2.,3.],[4.,8.,6.],[7.,14.,10.]])
# or A = mat(linspace(1,9,9)).reshape(3,3); A[2,2] = 10
# or A = range(1,11); A.remove(9); A = mat(A).reshape(3,3)
b = mat([[1.],[2.],[3.]])
b = mat([1.,2.,3.]).reshape(3,1)

eps = finfo(float).eps # machine epsilon
tol = 100*eps

LU,p,d = mylu(A,1)
print '"LU" =\n',LU
print 'd =',d
I = eye(len(A))
L = tril(LU,-1)+I; U = triu(LU); 
print 'p =',p
P = mat(I[p])
print 'P =\n',P
print 'is PA = LU?',(abs(P*A-L*U)<tol).all()
x = backsolve(LU,p,b)
print 'using LU: x =\n',x

from numpy.linalg import *

x = solve(A,b)
print 'using solve: x =\n',x

Q,R = qr(A)
print 'Q =\n',Q
print 'R =\n',R
print 'is QR = A?',(abs(Q*R-A)<tol).all()
x = solve(R,Q.T*b) # or x = solve(R,Q.transpose()*b)
print 'using QR: x =\n',x

U,s,V = svd(A)
print 'U =\n',U
print 'V =\n',V
S = mat(diag(s))
print 'S =\n',S
print 'is USV = A?',(abs(U*S*V-A)<tol).all()
x = V.T*(S.getI()*(U.T*b)) # or x = V.T*(diag(1/s)*(U.T*b))
print 'using SVD: x =\n',x
