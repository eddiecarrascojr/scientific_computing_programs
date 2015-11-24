function ab = bisect(f,ab,tol,alfa)
a = ab(1); b = ab(2); % assumes a<b
if b-a<tol, return; end
fa = f(a); % assumes f(a)*f(b)<0
v = alfa;
if isinf(alfa), v = (1+2*rand)/4; end % random value in [0.25,0.75]
x = a+v*(b-a); fx = f(x);
if fx*fa < 0
    ab = [a,x];
else
    ab = [x,b];
end
ab = bisect(f,ab,tol,alfa);