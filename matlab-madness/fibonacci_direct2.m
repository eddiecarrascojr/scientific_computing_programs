function F = fibonacci_direct2(n)
%fibonacci_direct2(n) solves the nth fibonacci sequenec with a vector
%format for any n>1.
if n==0
    F = 0;
else
    Fn1 = 2; F = 3;
    for k = 2:n
        Fn2 = Fn1; Fn1 = F;
        F = 2*Fn1-(8/9)*Fn2;
    end
end