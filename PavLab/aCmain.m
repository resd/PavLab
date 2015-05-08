function [  ] = aCmain( pr )
%AC Summary of this function goes here
%   Detailed explanation goes here

clear ob cov mo;
global ob cov mo;
mo = evalin('base', 'mo');
cov = evalin('base', 'cov');
opr = evalin('base', 'opr');
ob = evalin('base', 'class1');
p = evalin('base', 'res');
p = p(4);

clc;
pr = 2;
crp = 1;
n = 100;
% При количестве классов больше 2[такое возможно?] 
% нужно будет переписывать метод.

for i = 1:n
    cl = 1;
    nrp = 0;
    flag = true;
    while flag 
        sl1 = aCxlk(i, 1);
        sl2 = aCxlk(i, 2);
        l = opr(2)/opr(1);
        l = log(l);
        rr = (l - sl1 + sl2) / 2;
        if (rr <= p)
            cod = 222;
        else
            cod = 111;
        end
	    if (cod == 111)
            break;
        end
        cl = cl + 1;
        nrp = nrp + 1;  % Следующее РП (нумерация от 0)
        flag = nrp < crp;
    end
    fprintf('%4d   %15.8f  %10d\n', i, rr, cl);
end
end

