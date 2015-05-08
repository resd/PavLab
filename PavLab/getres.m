function [ res ] = getres( id )
%GETRES Summary of this function goes here
%   Detailed explanation goes here
global result;
res = [result{id}];
end

