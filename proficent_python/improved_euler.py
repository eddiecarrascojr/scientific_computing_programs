def improved_euler(f,tspan,y0,N,params):
    h = float(tspan[1]-tspan[0])/N # time step
    t = tspan[0]; y = y0
    tout = [0]*(N+1); 
    yout = [0]*(N+1) 
    tout[0] = t;
    yout[0] = y 
    for n in range(1,N+1): 
        f1 = f(t,y,params) 
        f2 = f(t+h,y+h*f1) #half-step update for y' @ t
        t += h # update t
        y = y + (h/2)*(f1+f2) # update y
        tout[n] = t; 
        yout[n] = y
    return tout,yout
f = lambda t, y, a: a*y(1.-y)
from matplotlib.pyplot import close, figure, plot, axis, grid, xlabel, ylabel, legend, savefig, show
close()
tspan = [0,10]
y0 = 0.2 # IC
a = (-1.,0.,.25,.5,1.,2.) 
colors = 'kbgrcm'
N = 10 # Improved Euler with step size (tspan[1]-tspan[0])/N = 1
for k in range(0,6):
    t,y = improved_euler(f,tspan,y0,N,a[k])
    plot(t,y,'.-',markersize=20,color=colors[k])
axis(tspan+[-.2,1.2]) # [0.,10.,-.2,1.2]
grid('on')
xlabel(r'time $t$',fontsize=16)
ylabel(r'solution $y(t)$',fontsize=16)
legend(loc='lower right')
savefig('myode.eps') 