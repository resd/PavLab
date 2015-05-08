function [ c ] = str2array( S )
%STR2ARRAY Summary of this function goes here
%   Detailed explanation goes here
c = {S.zn};
c = cell2mat(c);
end

