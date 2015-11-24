function an = power_mixed_direct(a,n)
%power_mixed_direct(a,n) will accept variable a as a number, then 
%mutiple it by itself n times directly.
steps = [];
while n>1
    if mod(n,2)
        n = n-1; steps = [steps, 1]; % n odd
    else
        n = n/2; steps = [steps, 0]; % n even
    end
end
an = a;
for k = length(steps):-1:1
    if steps(k)
        an = a*an; % odd step
    else
        an = an*an; % even step
    end
end