function [ out ] = my_decoder( in )
%MY_DECODER Summary of this function goes here
%   Detailed explanation goes here
rus = [1040:1103 1025 1105]; % ���� ������� ����
% if numel(find(rus==max(abs(in))))>0 % ���� ���� ������� �����, �� �� ���� ��������������
% out = in;
% else % ������������� �� dos (���������� ����� ��� ���� �� ��������)
% a = unicode2native(in,'windows-1251');
% out = native2unicode(abs(a),'cp-866');
% end

