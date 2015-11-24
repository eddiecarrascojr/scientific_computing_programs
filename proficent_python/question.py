from scipy.optimize import fsolve
from numpy import *
f = lambda x: [x[0]+x[1]-1,[x[0]**2+x[1]**2-2.]]
fsolve(f,[1.,0.])
