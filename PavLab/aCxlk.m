function [ sl ] = aCxlk( clk, k )
%ACXLK Summary of this function goes here
%   Detailed explanation goes here
global ob cov mo pr;
sl = 0.0;
for i = 1:pr
    ob(clk, i);
    mo(i,k);
    a(i) = ob(clk, i) - mo(i,k);
end
for i = 1:pr
    j = i;
    f1 = 0.0;
    for j1 = 1:pr
        cov(j, k);
        a(j1);
        f1 = f1 + (cov(j, k) * a(j1));
        if (j1 < i)
            j = j + pr - j1;
        else 
            j = j + 1;
        end
    end
    b(i) = f1;
end
for i = 1:pr
    a(i);
    b(i);
    sl = sl + a(i) * b(i);
end
end

