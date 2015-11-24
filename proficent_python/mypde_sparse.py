# sparse version of mypde.py
# solve u_xx + u_yy + 1 = 0 in [0,1]x[0,1] with u = 0 on boundary
# using finite difference scheme
from numpy import *
from numpy.linalg import solve, norm
from scipy.sparse import spdiags, kron
from scipy.sparse.linalg import spsolve

N = 10
Delta = 1./(N+1)
e = ones(N)/Delta**2
A = spdiags(array([-e,2*e,-e]),array([-1,0,1]),N,N)

I = eye(N)
B = kron(A,I)+kron(I,A)

f = ones((N**2,1))
u = spsolve(B,f)
u = u.reshape(N,N)
v = zeros((N+2,N+2))

from mayavi import mlab
from mayavi.mlab import *
v[1:N+1,1:N+1] = u
x, y = mgrid[0:Delta:1,0:Delta:1]
surf(x,y,v,warp_scale='auto')
show()
