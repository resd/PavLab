function n = Solve(n, pr)
%

len = length(n);
last = n(len);
%
if (last < pr)
    n(len) = n(len)+ 1;
    %if (n(len+1) == pr)
    %    n = -1;
    %end
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
            if (bool || n(len) < pr)
                for i = 1:len+1
                    n(i) = i;
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