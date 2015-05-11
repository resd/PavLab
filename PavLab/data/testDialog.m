function [ output_args ] = testDialog( input_args )
%TESTDIALOG Summary of this function goes here
%   Detailed explanation goes here
% prompt = {'Enter matrix size:','Enter colormap name:'};
% dlg_title = 'Input';
% num_lines = 1;
% def = {'20','hsv'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);
prompt = 'Do you want more? Y/N [Y]: ';
str = input(prompt,'s');
if isempty(str)
    str = 'Y';
end
end

