function n = S(n)
%

len = length(n);
last = n(len);
%
if (last ~= 9)
    n(len) = n(len)+ 1;
    return;
else if (len == 1)
        n = [1, 2];
        return;
    else
            % Тут сделать проверку на то, что все прнедыдущие числа в
            % матрице меньше на 1.
            % Если да, то:
            t = len;
            bool = false;
            while(t >= 2)
                if ((n(t) - 1) == n(t - 1))
                    bool = true;
                else
                    bool = false;
                    t = t - 1;
                    break;
                end;
                t = t - 1;
            end;
            if (bool)
                for i = 0:len
                    n(i+1) = i;
                end;
            else% У нас есть Т, которое соответствует нашему шагу, который нужно увеличить.
                k = n(t);
                for i = t:len
                    n(i) = k + 1;
                    k = k + 1;
                end;
            end;
    end;
end;
end