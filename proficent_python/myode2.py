#!/usr/bin/python
#from scitools.std import *
from numpy import *

def myeuler(f,tspan,y0,N,params):
    h = float(tspan[1]-tspan[0])/N
    t = tspan[0]; y = y0 
    tout = zeros((N+1,1)); yout = zeros((N+1,2))
    tout[0] = t; yout[0] = y 
    for n in range(1,N+1):
        f1 = f(t,y,params)
        t += h
        y += h*f1
        tout[n] = t; yout[n] = y
    return tout,yout

def odesolve(f,tspan,y0,N,params):
    from scipy.integrate import ode
    r = ode(f)
    r.set_integrator('vode',rtol=1e-6)
    h = float(tspan[1]-tspan[0])/N
    t = zeros((N+1,1)); y = zeros((N+1,2))
    n = 0
    r.set_initial_value(y=y0,t=tspan[0])
    r.set_f_params(params)
    t[0] = r.t; y[0] = r.y; 
    while r.successful() and n < N:
        r.integrate(r.t+h)
        n += 1; t[n] = r.t; y[n] = r.y;
    return t,y

def f(t,y,params): 
    s,i = y
    mu,beta,gamma = params
    dsdt = mu*(1-s)-beta*s*i
    didt = beta*s*i-(mu+gamma)*i
    return array([dsdt,didt])

tspan = [0,100]
y0 = s0,i0 = [0.1,0.1]
params = mu,beta,gamma = [.05,.8,.3]

N = 100
t,y = odesolve(f,tspan,y0,N,params)
t = t[:,0]; s = y[:,0]; i = y[:,1]; 
N = 50
t1,y1 = myeuler(f,tspan,y0,N,params)
t1 = t1[:,0]; s1 = y1[:,0]; i1 = y1[:,1];

#print t1.shape,y1.shape
#tlist = t1.reshape(1,N+1).tolist()[0]
#slist = s1.reshape(1,N+1).tolist()[0]
#ilist = i1.reshape(1,N+1).tolist()[0]
#for x in zip(tlist,slist,ilist): print x
for x in zip(t1,s1,i1): print x

from matplotlib.pyplot import *
close()
#ion()
figure(1)
subplot(2,1,1)
plot(t,s,'b-',t1,s1,'bo',t,i,'r-',t1,i1,'ro',linewidth=2,markersize=5)
legend([r'$s(t)$','Euler',r'$i(t)$','Euler'])
axis(tspan+[0.,1.])
grid('on')
subplot(2,1,2)
plot(s,i,'k-',s1,i1,'ro',linewidth=2,markersize=5)
legend(['exact','Euler'],loc='best')
xlabel(r'$s$')
ylabel(r'$i$')
axis([0,.7,0,.2])
grid('on')
#ioff()

savefig('s_and_i.eps')
#matplotlib.rcParams['font.size'] = 18
show()
