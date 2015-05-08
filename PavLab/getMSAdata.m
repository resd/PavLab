function [ res ] = getMSAdata( str )
%GETMSADATA Summary of this function goes here
%   Detailed explanation goes here
global c Imax cb;
switch str
    case 'c'
        res = c;
    case 'cnum'
        res = length(c);
    case 'Imax'
        res = Imax;
    case 'cb'
        res = cb;
    otherwise
        res = -1;
end
end

