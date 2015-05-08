function [ output_args ] = SorkPer( input_args )
nCount = 100;
cur = nCount;
% maxCol;%// = m_statistica -> GetSign();
% allClass;%// = m_statistica -> max_class;
% int() list_sign = new int(cur);
% int() list_sign_ = new int(cur);
% float() list = new float(cur);
% int() awCols;
% int() aNumCol = new int(10000);
for  n = 1 : nCount
    aNumCol(n) = n;%awCols(n) - 1;
end

for count = 1 : cur
    list_sign(aNumCol(count)) = 0;
    list_sign_(aNumCol(count)) = 0;
    list(aNumCol(count)) = 0;
end
txt = '';
% fmt;
% int() indexes = new int(cur);
% int() aNumCol_ = new int(cur);
% int i;
% int j;
% boolean fflag;
% float maxx;
for i = 1 : cur
    for j = 1 : cur
        fflag = false;
        for count = 1 : i - 1
            if ((list_sign(count) == j) & (i ~= 1))
                fflag = true;
            end
        end
        if (fflag) continue; end
        list_sign(i - 1) = j;
        list_sign_(j) = j;
        %//msrout<<"sequence: ";
        %*/
        for count = 0 : i
            %msrout<<"list_sign("<<count<<")"<<list_sign(count)<<" ";
            %fmt.Format("%d ", list_sign(count));
            %txt += fmt;
        end
        %         //msrout<<"---";
        %         //txt += "---";
        %
        %         //DataClass stat(statistica_,i,list_sign, mode, */
        %         /*i-1*//*
        %         0, 2);
        %         //stat_=&stat;
        %         //MSR x1(stat_);
        %         //list(j)=stat.GetProcent();
        %         //msrout<<"proc="<<list(j)<<endl;
        %         //fmt.Format("proc=%.2f\r\n", list(j));
        %         //txt += fmt;
    end
    maxx = list(1);
    list_sign(i) = list_sign_(1);
    for count = 1 : cur
        if (list(count) > maxx)
            maxx = list(count);
            list_sign(i - 1) = list_sign_(count);
        end
    end
    for count = 0 : cur
        list_sign_(count) = 0;
        list(count) = 0;
    end
    
end

