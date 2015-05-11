function [ a ] = Aprobb( sc)
global  n kr;

tppr = 0;
n1 = n(1);
n2 = n(2);
sum1 = 0;
sum2 = 0;
mppr = 0;
fori = n1 + n2;

for ii = 1:fori
    sum1 = 0;
    sum2 = 0;
    for i = 1:ii
        if (sc(3, 1, i) == 1)
            sum2 = sum2 + 1;
        end
    end
    lpo2 = (sum2 / n1) * 100;  
    for i = ii+1:n1+n2
        if (sc(3, 1, i) == 2)
				sum1 = sum1 + 1;
        end
    end
    lpo1 = sum2;%(sum1 / n2) * 100;                % //Вероятность ошибки 1-го рода
    lpo2 = sum1;
	tppr = (1 - (sum1 + sum2) / (n1 + n2)) * 100.0;% //Процент прав. распозн.
    if (tppr > mppr) 
			mppr = tppr;
			a(1) = tppr;
			a(2) = lpo1;
			a(3) = lpo2;
            a(4) = kr(ii).zn;
    end
end
    
end

