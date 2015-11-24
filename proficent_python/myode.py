#!/usr/bin/python

def myeuler(f,tspan,y0,N,params):
    h = float(tspan[1]-tspan[0])/N
    t = tspan[0]; y = y0 
    tout = [0]*(N+1); yout = [0]*(N+1)
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
    t = [0]*(N+1); y = [0]*(N+1)
    n = 0
    r.set_initial_value(y=y0,t=tspan[0])
    r.set_f_params(params)
    t[0] = r.t; y[0] = r.y; 
    while r.successful() and n < N:
        r.integrate(r.t+h)
        n += 1; t[n] = r.t; y[n] = r.y;
    return t,y

f = lambda t,y,a: a*y*(1.-y)
# same as
#def f(t,y,a): 
#    return a*y*(1-y)
from matplotlib.pyplot import close, figure, plot, axis, grid, \
               xlabel, ylabel, legend, savefig, show
close()
figure(1)
tspan = [0.,10.]
y0 = 0.2
a = (-1.,0.,.25,.5,1.,2.)
colors = 'kbgrcm'
N = 100
for k in range(0,6):
    t,y = odesolve(f,tspan,y0,N,a[k])
    plot(t,y,label=r'$a = %.2f$' % a[k],linewidth=2,color=colors[k])
N = 10
for k in range(0,6):
    t,y = myeuler(f,tspan,y0,N,a[k])
    plot(t,y,'.-',markersize=20,color=colors[k])
axis(tspan+[-.2,1.2])
grid('on')
xlabel(r'time $t$',fontsize=16)
ylabel(r'solution $y(t)$',fontsize=16)
legend(loc='lower right')
savefig('myode.eps')
show()
