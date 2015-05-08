function [ str ] = AT_autolab( N, n, pr, class1M, class2M, class1D, class2D, lawflag, fileflag, file )
%AT_LAB2 Summary of this function goes here
%   Detailed explanation goes here
clearclpr();
% Разкомментировать функцию, сооответственно варианта
if lawflag
    %для равномерного закона распределения
    class1 = uniformClass(pr, N, class1M, class1D);
    class2 = uniformClass(pr, N, class2M, class2D);
else
    %для нормального закона распределения
    class1 = normalClass(pr, N, class1M, class1D);
    class2 = normalClass(pr, N, class2M, class2D);
end
if fileflag
    save (file, 'class1', 'class2');
end
addcl(class1);
addcl(class2);
setpr(pr);
str = strcat('Количество признаков: ', pr);
for i = 1:getcllen()
    str = strvcat(str, strcat(num2str(i), [' класс = ' ' '], num2str(length(getcl(getcllen()))), ' элементов'));
end
%set(handles.edit6, 'String', str);
end

