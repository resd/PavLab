function [m, cv] = Amocov( nkl, rz, pr)
%AMOCOV Summary of this function goes here
%   Detailed explanation goes here
global mo cov n; 
p = 1.0 / n(nkl);
t = n(nkl) / (n(nkl) - 1.0);
q = 1;
for j=1:pr
    s = 0;
    for i=1:n(nkl)
        s = s + rz(j, i, nkl);
    end
    mo(j, nkl) = s * p;
end
for i=1:pr
    for j=i:pr
        s = 0;
        for k=1:n(nkl)
            s = s + rz(i, k, nkl) * rz(j, k, nkl);
        end
        cov(q, nkl) = t * (s * p - mo(i, nkl) * mo(j, nkl));
        q = q + 1;
    end
end
m = mo;
cv = cov;
end