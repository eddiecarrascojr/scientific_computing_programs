function F = fibonacci_explicit(n)
r1 = (1+sqrt(5))/2;
r2 = (1-sqrt(5))/2;
a = 1/sqrt(5);
if n==0
    F = 0;
elseif n==1
    F = 1;
else
    F = a; %(1/sqrt(5))*((r1^n)-(r2^n));
end

    