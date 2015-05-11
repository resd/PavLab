function [ cl ] = getcl( id )
%GETCL1 Summary of this function goes here
%   Detailed explanation goes here
global classes;
cl = [classes{id}];
end