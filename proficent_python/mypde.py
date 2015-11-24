# dense version of mypde_sparse.py
# solve u_xx + u_yy + 1 = 0 in [0,1]x[0,1] with u = 0 on boundary
# using finite difference scheme
from numpy import *
from numpy.linalg import *

N = 10
Delta = 1./(N+1)
A = zeros((N,N))
for i in range(N):
   A[i,i] = 2./Delta**2 # diagonal coefficients
for i in range(1,N):
   A[i,i-1] = -1./Delta**2 # lower diagonal
for i in range(N-1):
   A[i,i+1] = -1./Delta**2 # upper diagonal

I = eye(N)
B = A
C = kron(A,I)+kron(I,B)

f = ones((N**2,1))
u = solve(C,f)
u = u.reshape(N,N)
v = zeros((N+2,N+2))
v[1:N+1,1:N+1] = u
x, y = mgrid[0:Delta:1,0:Delta:1]

from mayavi import mlab # requires option --gui=wx or qt or gtk
from mayavi.mlab import *
surf(x,y,v,warp_scale='auto')
show()
