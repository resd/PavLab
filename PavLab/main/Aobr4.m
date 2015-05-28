function [ d ] = Aobr4( k, pr)
%AOBR Summary of this function goes here
%   Detailed explanation goes here
global cov;
d = 1.0;
m = 1;
for k1 = 1:pr
    if (cov(1, k) == 0)
        d = 0;
        break;
    end
    p = 1.0 / cov(1, k);
    d = d * cov(1, k);
	l = 0;
    for i = 2:pr
        ww(i - 1) = cov(i, k);
    end
    pr1 = pr - 1;
    for i = 1:pr1
        y = -ww(i) * p;
		cov(l + pr, k) = y;
		m = l + pr + 1 - i;
        for j = i:pr1
           cov(l + j, k) = cov(m + j, k) + ww(j) * y;
        end
        l = l + pr - i;
    end
    m = l + pr;
	cov(m, k) = -p;
end
for i = 1:m 
    cov(i, k) = -cov(i, k);
end
end