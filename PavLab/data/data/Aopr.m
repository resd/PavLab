function [] = Aopr(nkl, rz, pr)
% function [] = Aopr(nkl, rz, pr, n, mo, cov, det )
%AOPR Summary of this function goes here
%   Detailed explanation goes here
global mo cov n det kr;
if (nkl == 1)
	st = 0;
else
	st = n(1);
end
for i = 1:n(nkl)
    for j = 1:pr
        r1(j) = rz(j, i, nkl) - mo(j, 1);
		r2(j) = rz(j, i, nkl) - mo(j, 2);
    end
    r = 0.0;
    for l = 1:pr
        j = l;
		f1 = 0.0;
		f2 = 0.0;
        for j1 = 1:pr
            f1 = f1 + cov(j, 1) * r1(j1);
			f2 = f2 + cov(j, 2) * r2(j1);
            if (j1 < l)
				j = j + pr - j1;
			else
				j = j + 1;
            end
        end
        r = r + r2(l) * f2 - r1(l) * f1;
    end
    s = st + i;
    if ((det(2) == 0) || (det(1) == 0))
		kr(s).zn = r / 2;
	else
		kr(s).zn = (log(abs(det(2)) / abs(det(1))) + r) / 2;
    end
    kr(s).sc = nkl;
	kr(s).np = s;
end

end

