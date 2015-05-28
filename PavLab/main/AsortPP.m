function [ cell ] = AsortPP( cell, idStart, idEnd)
% —ортировка массив €чеек по возрастанию
for temp = idStart:idEnd
    for i = idStart:idEnd
        c1 = cell2mat(cell(1, 1 , i));
        c2 = cell2mat(cell(1, 1 , i+1));
        if ( c2 > c1 )
            for j = 1:4
                t = cell(j, 1 , i+1);
                cell(j, 1 , i+1) = cell(j, 1 , i);
                cell(j, 1 , i) = t;
            end
        end
    end
end
end
