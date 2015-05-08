function [ str ] = AT_autolab( N, n, pr, class1M, class2M, class1D, class2D, lawflag, fileflag, file )
%AT_LAB2 Summary of this function goes here
%   Detailed explanation goes here
clearclpr();
% ����������������� �������, ��������������� ��������
if lawflag
    %��� ������������ ������ �������������
    class1 = uniformClass(pr, N, class1M, class1D);
    class2 = uniformClass(pr, N, class2M, class2D);
else
    %��� ����������� ������ �������������
    class1 = normalClass(pr, N, class1M, class1D);
    class2 = normalClass(pr, N, class2M, class2D);
end
if fileflag
    save (file, 'class1', 'class2');
end
addcl(class1);
addcl(class2);
setpr(pr);
str = strcat('���������� ���������: ', pr);
for i = 1:getcllen()
    str = strvcat(str, strcat(num2str(i), [' ����� =�' ' '], num2str(length(getcl(getcllen()))), ' ���������'));
end
%set(handles.edit6, 'String', str);
end

