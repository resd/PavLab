function [ output_args ] = AT_lab2( input_args )
%AT_LAB2 Summary of this function goes here
%   Detailed explanation goes here
clc;
N = 100;
n = 2;
% »зменить соответственно варианта

class1M = [12.7, 0.3];
class2M = [12.1, 2.5];
class1D = [1.1, 1];
class2D = [0.7, 0.4];

% –азкомментировать функцию, сооответственно варианта

%     %дл€ равномерного закона распределени€
% class1 = uniformClass(n, N, class1M, class1D);
% class2 = uniformClass(n, N, class2M, class2D);

%     дл€ нормального закона распределени€
class1 = normalClass(n, N, class1M, class1D);
class2 = normalClass(n, N, class2M, class2D);

save ('classessss.mat', 'class1', 'class2');

end

