from math import *

#This function returns the value of a function, using lambda
def function(x):
    f = float(x**2-2)
    #f = lambda x: x**2-2
    return f  

#Created a simple derivative using forward difference
def derivative(x):
    df = float(2*x)
    return df

def newtons_method(x, max_iter, tolerance):
    '''f is the function f(x)'''
    '''df is the derivative of f(x)'''
    
    iter = 0
    x1=float(x)
    while (max_iter>iter):
        #update the values of f and df
        f = function(x)
        df = derivative(x)
        
        x1 = x - f/df
        t = abs(x1 - x)
        #Check for errors
        if t < tolerance:
            x = x1
            return x,iter
        #update the x_new value
        x = x1
        iter += 1
    return x,iter    
x0 = 1.0
max_iter = 1000
tolerance=0.000000000001

root = newtons_method(x0,max_iter,tolerance)
print ('root = %.16f in %i iterations' %root)
print(sqrt(2))