function [ cell ] = sortCell( cell )
%SORTCELL Summary of this function goes here
%   Detailed explanation goes here
sz = length(cell) - 1;
for j = 1:sz
    for i = 1:sz
        %i
        %cell(2, 1 , i+1)
        %cell(2, 1 , i)
        if ( cell(2, 1 , i+1) == cell(2, 1 , i) )
            %cell(3, 1 , i+1)
            %cell(3, 1 , i)
            if ( cell(3, 1 , i) < cell(3, 1 , i+1) )
                t = cell(3, 1 , i+1);
                cell(3, 1 , i+1) = cell(3, 1 , i);
                cell(3, 1 , i) = t;
                t = cell(1, 1 , i+1);
                cell(1, 1 , i+1) = cell(1, 1 , i);
                cell(1, 1 , i) = t;
            end
        end
    end
end
end