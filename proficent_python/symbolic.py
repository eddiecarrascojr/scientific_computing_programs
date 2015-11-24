#!/usr/bin/python
from sympy import *

var('x') # define symbolic variable x; same as x = symbols('x')

f = sin(x) # symbolic function

h = Lambda(x,f) # converts to evaluable function 
print h(1).evalf() #  f(1)

print diff(f**2,x) # differentiate f
print integrate(f,x) # indefinite integral of f

print limit((f-x)/x**3,x,0) # limit of expression involving f

print f.series(x,0,6) # Taylor series of f(x) at 0 to O(x^6)

var('u')
print dsolve(u(x).diff(x,x)+u(x),u(x)) # solve ODE u"+u=0

print expand((1+x)**2)
print factor(1+3*x+2*x**2)
print apart(1/(1-x**2)) # partial fraction decomposition

var('n')
print Sum(1/n**2, (n,1,oo)).evalf() # infinite series
print pi.evalf()**2/6

A = Matrix(2,2,lambda i,j:Rational(i+j+1,1)) 
M = A-eye(2)*x
print simplify(M.det()) # characteristic polynomial of A
print A.charpoly(x).as_expr() # directly as attribute of A

b = Matrix(2,1,[1,1])
x = A.LUsolve(b) # solve Ax=b using PA=LU factorization
print x
L,U,p = A.LUdecomposition() # LU factorization
print L
print U
Q,R = A.QRdecomposition()  # QR factorization
print Q
print R
print A.singular_values() # singular values

var('x y')
print solve([x**2+y**2-3,x+y-1],[x,y]) # nonlinear system
