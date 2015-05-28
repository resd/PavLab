function [ str ] = AT_autolab( N, clLen, pr, class1M, class1D, lawflag, fileflag, file )
%AT_LAB2 Summary of this function goes here
%   Detailed explanation goes here
clearclpr();
% Разкомментировать функцию, сооответственно варианта
if lawflag
    %для равномерного закона распределения
    for i = 1:clLen
        class{i} = uniformClass(pr, N, class1M(i,:), class1D(i,:));
    end
else
    %для нормального закона распределения
    for i = 1:clLen
        class{i} = normalClass(pr, N, class1M(i,:), class1D(i,:));
    end
end
% Запись полученных классов в файл
if fileflag
    q = 1;
    while (exist(file, 'file')) == 2
        f = file(length(file)-4:length(file)-4);
        if f == num2str(q-1)
            file = [file(1:length(file)-5) num2str(q) file(length(file)-3:length(file))];
        else
            file = [file(1:length(file)-4) num2str(q) file(length(file)-3:length(file))];
        end
        q = q + 1;
    end
    save (file, 'class');
end
% addcl(class1);
% addcl(class2);
setclasses(class);
setpr(pr);
str = strcat('Количество признаков: ', pr);
for i = 1:getcllen()
    str = strvcat(str, strcat(num2str(i), [' класс = ' ' '], num2str(length(getcl(getcllen()))), ' элементов'));
end
%set(handles.edit6, 'String', str);
end

