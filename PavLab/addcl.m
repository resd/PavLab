function [  ] = addcl( cl )
%SETCL1 Summary of this function goes here
%   Detailed explanation goes here
global classes;
classes{length(classes) + 1} = cl;
end

