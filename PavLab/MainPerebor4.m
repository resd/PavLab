function s = Main4()
% 
n = [0,1,2,3];  % Задаем начальное условие.
k = 210;        % Задаем количество шагов.
s = '';
for i = 1:k
n = Solve(n);
s = strvcat(s, mat2str(n));
%disp(n);
end;
%q = n;
end