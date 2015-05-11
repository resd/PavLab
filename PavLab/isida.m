function varargout = isida(varargin)
% ISIDA M-file for isida.fig
%      ISIDA, by itself, creates a new ISIDA or raises the existing
%      singleton*.
%
%      H = ISIDA returns the handle to a new ISIDA or the handle to
%      the existing singleton*.
%
%      ISIDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISIDA.M with the given input arguments.
%
%      ISIDA('Property','Value',...) creates a new ISIDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isida_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isida_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isida

% Last Modified by GUIDE v2.5 11-May-2015 13:02:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isida_OpeningFcn, ...
                   'gui_OutputFcn',  @isida_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before isida is made visible.
function isida_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isida (see VARARGIN)

% Choose default command line output for isida
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isida wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%updateAxes(handles);
%Open_Callback_Add('D:\H\MATLAB R2009a Portable\Work\msredc.in', handles);%todo Delete

% --- Outputs from this function are returned to the command line.
function varargout = isida_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Methods_Callback(hObject, eventdata, handles)
% hObject    handle to Methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MSR_Callback(hObject, eventdata, handles)
% hObject    handle to MSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PP_Callback(hObject, eventdata, handles)
% hObject    handle to PP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.mat';'*.in';'*.xls'}, 'Pick file with input data');
if isequal(filename,0) || isequal(pathname,0)
    disp('User pressed cancel')
else
    Open_Callback_Add(strcat(pathname, filename), handles);
    set(handles.edit3, 'String', '');
    set(handles.edit7, 'String', '');
end

    
% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Open_Callback_Add(path, handles)
clearclpr();
clearothers();
clc;
%fid = fopen('D:\H\MATLAB R2009a Portable\Work\msredc.in');
pathIn = path(length(path)-2:length(path));
fid = fopen(path);
switch pathIn
    case '.in'
        n(1) = fscanf(fid,'%d', 1);
        n(2) = fscanf(fid,'%d', 1);
        pr = fscanf(fid,'%d', 1);
        setpr(pr);
        for nkl = 1:2
            for i = 1:n(nkl)
                for j = 1:pr
                    class(j, i) = fscanf(fid, '%f', 1);
                end
            end
            cl(nkl) = {class};
            class = [];
        end
        cl1 = [cl{1}]';
        cl2 = [cl{2}]';
        addcl(cl1);
        addcl(cl2);
    case 'xls'
        %path
        xls = importdata(path);
        xls = struct2cell(xls);
        a = xls{1};
        setpr(length(a(1,:)));
        str = strcat(num2str(length(a(1,:))), ' признаков');
        for i = 1:length(xls)
            addcl(xls{i});
            str = strvcat(str, strcat(num2str(getcllen()), ' класс = ', ' ', num2str(length(getcl(getcllen()))), ' элементов'));
        end
        set(handles.edit6, 'String', str);
    case 'mat'
        %load(path);
        %cl = evalin( 'base', 'class1' );
        %addcl(evalin( 'base', 'class1' ));
        %addcl(evalin( 'base', 'class2' ));
        ws = load (path);
        cl = ws.class1;
        setpr(length(cl(1,:)));
        addcl(cl);
        addcl(ws.class2);
        str = strcat('Количество признаков: ', num2str(length(cl(1,:))));
        for i = 1:getcllen()
            str = strvcat(str, strcat(num2str(i), ' класс = ', ' ', num2str(length(getcl(i))), ' элементов'));
        end
        set(handles.edit6, 'String', str);
    otherwise
        %todo запилить ввод в .txt тут, с проверками на считываемость вообще.
end
fclose(fid);
%s = strcat('Кол-во эл-тов 1-го класса = ', ' ', num2str(n(1)), ', кол-во эл-тов 2-го класса = ', ' ', num2str(n(2)), ', кол-во признаков = ', ' ', num2str(pr));
%set(handles.text6, 'String', s);

% --- Executes on selection change in poAutoEnum.
function poAutoEnum_Callback(hObject, eventdata, handles)
% hObject    handle to poAutoEnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns poAutoEnum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        poAutoEnum


% --- Executes during object creation, after setting all properties.
function poAutoEnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poAutoEnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbMocov.
function cbMocov_Callback(hObject, eventdata, handles)
% hObject    handle to cbMocov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbMocov


% --- Executes on button press in cbKr.
function cbKr_Callback(hObject, eventdata, handles)
% hObject    handle to cbKr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbKr


% --- Executes on button press in cbSave.
function cbSave_Callback(hObject, eventdata, handles)
% hObject    handle to cbSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbSave


% --- Executes on button press in pushbuttonPlot.
function pushbuttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


t1 = get(handles.edit4, 'String');
t1 = str2num(t1);
t2 = get(handles.edit8, 'String');
t2 = str2num(t2);
if isempty(t1)
    t1=[1,2];
    set(handles.edit4, 'String', num2str([1,2]));
else if (not(or(length(t1) == 2, length(t1) == 3)))
        error('Неверное количество признаков!');
    end
end
if isempty(t2)
    t2 = [1,2];
    set(handles.edit8, 'String', num2str([1,2]));
else
    if (and(not(isempty(t2)), and(getcllen() > 2, not(length(t2) == 2))))
        error('Неверное количество классов!');
    end
end
cl1 = getcl(t2(1));
cl2 = getcl(t2(2));
cl1t = [];
cl2t = [];
for i = 1:length(t1)
    cl1t(:, i) = cl1(:, t1(i));
    cl2t(:, i) = cl2(:, t1(i));
end
% M1 = mean(cl1t);
% M2 = mean(cl2t);
% S1 = cov(cl1t);
% S2 = cov(cl2t);
% AS1 = inv(S1);
% AS2 = inv(S2);
% DS1 = det(S1);
% DS2 = det(S2);
% a6 = 0.5*(AS2(1,1) - AS1(1,1));
% a5 = (AS2(1,2) - AS1(1,2));
% a4 = 0.5*(AS2(2,2) - AS1(2,2));
% b1 = AS1*M1' - AS2*M2';
% a3 = b1(1);
% a2 = b1(2);
% a1 = -0.5*(M1*AS1*M1' - M2*AS2*M2') + 0.5*log(DS2/DS1);
% tmin = min(cl1t(:,1));
% tmax = max(cl2t(:,1));
% i=1;
% % 2.4
% for t=tmin:((tmax-tmin)/(min(length(cl1t), length(cl2t))-1)):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
%     Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
%     i=i+1;
% end
figure(123);
Aplot(cl1t, cl2t, length(t1));%,z,Y1, Y2

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearothers();
clearres();
clc;
len = getcllen();
pr = getpr();

if(len <2)
    error('Недостатачное количество классов');
end

handles = guidata(hObject);  % Update!
%v1 = str2double(get(hEdit1, 'String'));
%v2 = str2double(get(hEdit2, 'String'));
switch get(get(handles.uipanel4,'SelectedObject'),'Tag')
    case 'rbManualEnum'
        %v1 = get(handles.edit7, 'String');
        v1 = 'Manual';
    case 'rbAutoEnum'
        v1 = get(handles.poAutoEnum,'Value');
    otherwise
end
switch get(get(handles.uipanel5,'SelectedObject'),'Tag')
    case 'rbVPR'
        v2 = get(handles.poVPR,'Value');
    case 'rbCl'
        v2 = 'Cl';
    otherwise
end
cl1t = [];
cl2t = [];
%todo ====================================
t1 = get(handles.edit7, 'String');%priznaki
t2 = get(handles.edit3, 'String');%classes
if isempty(t2)
    set(handles.edit3, 'String', '1');
    t2 = '1';
end
if isempty(t1)
    for i = 1 : pr
        n(i) = i;
    end
    set(handles.edit7, 'String', num2str(n));
    t1 = n;
else
    t1 = str2num(t1);
end
t2 = str2num(t2);
if get(handles.checkbox6, 'Value') == 1
    cl1 = getcl(t2);
    cl2 = getcli(t2 + 1, getcllen());
    %t1
    %t2
    for i = 1:length(t1)
        cl1tt(:, i) = cl1(:, t1(i));
        cl2tt(:, i) = cl2(:, t1(i));
    end
else
    cl1tt = getcl(t2);
    cl2tt = getcli(t2 + 1, getcllen());
end
%todo ====================================
switch v1
    case 1% PP
        out = '';
%         cl1 = getcl(len - 1);
%         cl2 = getcl(len);
        %                 cl1(1, :)
        %                 cl2(1, :)
        switch v2
            case 1%msr
                [res, outf] = Am(cl1tt, cl2tt, t1);% todo col
            case 2%msa
            case 3%ns
        end
        if(len == 2)
            out = strtrim(outf);
        else
            addres(res);
            outf = strtrim(outf);
            stemp = strcat('Сравнение классов ', num2str(len-1), ' c ');
            stemp = strcat(stemp, ' ', num2str(len));
            out = strvcat(out, stemp, outf);
            for i = len-1: -1 :2
                cl1 = getcl(i-1);
                cl2 = getcli(i, len);
                %                     i
                %                     cl1(1, :)
                %                     cl2(1, :)
                %                     cl2(101, :)
                switch v2
                    case 1%msr
                        [res, outf] = Am(cl1, cl2, pr);
                    case 2%msa
                    case 3%ns
                end
                addres(res);
                outf = strtrim(outf);
                s = strcat(' ', num2str(i));
                for j = i:len-1
                    s = strcat(s, ',', num2str(j+1));
                end
                stemp = strvcat(' ', strcat('Сравнение классов ', num2str(i-1), ' c ', ' ', s));
                out = strvcat(out, stemp, outf);
                %                         cl1 = getcl(2);
                %                         cl2 = getcl(3);
                %                         %cl2 = getcli(2, 3);
                %                     [res, outf] = Am(cl1, cl2, pr);
                %                     out = strtrim(outf);
            end
            format shortG;
            res1 = getres(1);
            len = length(res1(1, : , :));
            lenresult = getreslen();
            outStr = '';
            w{4,1,len} = [];
            k1 = 0; k2 = 0; k3 = 0;
            pr = getpr();
            for j = 1:pr
                for k = 1:lenresult
                    res = getres(k);
                    k1 = k1 + [res{1, 1, j}];
                    k2 = k2 + [res{2, 1, j}];
                    k3 = k3 + [res{3, 1, j}];
                end
                k4 = length([res{4,1,j}]);
                w(1,1,j) = {k1/2};
                w(2,1,j) = {k2/2};
                w(3,1,j) = {k3/2};
                w(4,1,j) = {k4};
                k1 = 0; k2 = 0; k3 = 0;
            end
            w = AsortPP(w, 1, pr);
            k4 = 2;
            idStart = pr+1;
            for j = pr+1:len
                for k = 1:lenresult
                    res = getres(k);
                    k1 = k1 + [res{1, 1, j}];
                    k2 = k2 + [res{2, 1, j}];
                    k3 = k3 + [res{3, 1, j}];
                end
                if (k4 < length([res{4,1,j}]))
                    w = AsortPP(w, idStart, j - 1);
                    idStart = j;
                end
                k4 = length([res{4,1,j}]);
                w(1,1,j) = {k1/2};
                w(2,1,j) = {k2/2};
                w(3,1,j) = {k3/2};
                w(4,1,j) = {k4};
                %outStr = strvcat(outStr, sprintf('%d:\t%4.2f\t%4.2f\t%4.2f\t%d',j, k1/lenresult, k2/lenresult, k3/lenresult, k4));
                k1 = 0; k2 = 0; k3 = 0;
            end
            
            for id = 1:len
                outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%d',id, [w{1, 1, id}], [w{2, 1, id}], [w{3, 1, id}], [w{4, 1, id}]));
            end
            
            %outStr = strvcat(outStr,
            %sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
            out = strvcat(out, 'Результирующая выборка ', outStr);
        end
    case 2% CP
        out = '';
        cl1 = getcl(len - 1);
        cl2 = getcl(len);
        %                 cl1(1, :)
        %                 cl2(1, :)
        [row, col] = size(cl1tt);
        [outf] = SokraPer(cl1tt, cl2tt, col, v2, t1);% todo col
%         switch v2
%             case 1%msr
%                 [outf] = SokraPer(cl1, cl2, pr, v2);
%             case 2%msa
%                 [outf] = SokraPer(cl1, cl2, pr, 2);
%             case 3%ns
%         end
        if(len == 2)
            out = strtrim(outf);
        end
    case 3% MK
        out = '';
        %                 cl1(1, :)
        %                 cl2(1, :)
        [row, col] = size(cl1tt);
        switch v2
            case 1%msr
                outf = MK(cl1tt, cl2tt, col, v2, t1);% todo col
            case 2%msa
            case 3%ns
        end
        if(len == 2)
            out = strtrim(outf);
        end
    case 4
        out = '';
        switch v2
            case 1% MSR
            case 2% MSA
            case 3% NS
        end
        
        % only MSR
        [row, col] = size(cl1tt);
        [maxP1, ac, outf1] = Am(cl1tt, cl2tt, t1);% todo col
        [maxP2, outf2] = SokraPer(cl1tt, cl2tt, col, v2, t1);% todo col
        [maxP3, outf3] = MK(cl1tt, cl2tt, col, v2, t1);% todo col
        out = strvcat(outf1,outf2,outf3);
        out = strtrim(out);
        maxP1, maxP2, maxP3
%         out
        plotAllPerms(col);
        plotAllP(maxP1, maxP2, maxP3);
        if(len == 2)
            % todo multi classes
        end
    otherwise% Читаем введенные данные и на их основании выводим результат
        t1 = get(handles.edit7, 'String');%priznaki
        t2 = get(handles.edit3, 'String');%classes
        if isempty(t2)
            set(handles.edit3, 'String', '1');
            t2 = '1';
        end
        if isempty(t1)
            for i = 1 : pr
                n(i) = i;
            end
            set(handles.edit7, 'String', num2str(n));
            t1 = n;
        else
            t1 = str2num(t1);
        end
        t2 = str2num(t2);
        cl1 = getcl(t2);
        cl2 = getcli(t2 + 1, getcllen());
        %t1
        %t2
        for i = 1:length(t1)
            cl1t(:, i) = cl1(:, t1(i));
            cl2t(:, i) = cl2(:, t1(i));
        end
        switch v2
            case 1% MSR
                [res1, a] = rule_lab2_1(cl1t, cl2t, length(t1));%todo add pr
                res2 = Amain(cl1t, cl2t, length(t1));
                warning('off', 'MATLAB:printf:BadEscapeSequenceInFormat');
                out = sprintf('Метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nМодифицированного метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nРешающие правила:\r\nc = %f\r\na1 = %f\r\na2 = %f\r\na3 = %f\r\na4 = %f\r\na5 = %f\r\na6 = %f', res1(1), res1(2), res1(3),res2(1),res2(2),res2(3),a(7),a(1),a(2),a(3),a(4),a(5),a(6));
                out % for Ivan
            case 2% MSA
                warning('off', 'all');
%                 MSA(cl1t, cl2t, length(t1));
                [res1, a, c1max] = MSA(cl1t, cl2t, length(t1), 1);
                %[res2, outf, c2, c2max] = MSAnew(cl1t, cl2t, length(t1), 2);
                out = sprintf('Метод стохастической апроксимации:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f\r\nЦикл обучения: %d\r\n', res1(1), res1(2), res1(3),a(1),a(2),a(3),a(4),a(5),a(6),c1max(1),c1max(2),c1max(3),c1max(4),c1max(5),c1max(6),res1(4));
                %Метод стохастической апроксимации с коэффициентами из
                %метода статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f
                %,res2(1),res2(2),res2(3),c2(1),c2(2),c2(3),c2(4),c2(5),c2(6),c2max(1),c2max(2),c2max(3),c2max(4),c2max(5),c2max(6));
                out % for Ivan
            case 3% MSA + MSR
                [res1, a, c1max] = MSA(cl1t, cl2t, length(t1), 2);
                %[res2, outf, c2, c2max] = MSAnew(cl1t, cl2t, length(t1), 2);
                out = sprintf('Метод стохастической апроксимации с коэффициентами из метода статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f\r\nЦикл обучения: %d\r\n', res1(1), res1(2), res1(3),a(1),a(2),a(3),a(4),a(5),a(6),c1max(1),c1max(2),c1max(3),c1max(4),c1max(5),c1max(6),res1(4));
                %Метод стохастической апроксимации с коэффициентами из метода статистических решений:\r\nВероятность  =
                %%f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f
                %,res2(1),res2(2),res2(3),c2(1),c2(2),c2(3),c2(4),c2(5),c2(
                %6),c2max(1),c2max(2),c2max(3),c2max(4),c2max(5),c2max(6));
            case 4% NS
        end
        %res = Amain(cl1t, cl2t, length(t1));
        %out = sprintf('Вероятность  =  %f\r\nОшибка 1 рода  =  %f\r\nОшибка 2 рода  =  %f\r\n', res(1), res(2), res(3));
end

% case 1% PP
%     out = '';
%     cl1 = getcl(len - 1);
%     cl2 = getcl(len);
%     %                 cl1(1, :)
%     %                 cl2(1, :)
%     [res, outf] = Am(cl1, cl2, pr);
%     if(len == 2)
%         out = strtrim(outf);
%     else
%         addres(res);
%         outf = strtrim(outf);
%         stemp = strcat('Сравнение классов ', num2str(len-1), ' c ');
%         stemp = strcat(stemp, ' ', num2str(len));
%         out = strvcat(out, stemp, outf);
%         for i = len-1: -1 :2
%             cl1 = getcl(i-1);
%             cl2 = getcli(i, len);
%             %                     i
%             %                     cl1(1, :)
%             %                     cl2(1, :)
%             %                     cl2(101, :)
%             [res, outf] = Am(cl1, cl2, pr);
%             addres(res);
%             outf = strtrim(outf);
%             s = strcat(' ', num2str(i));
%             for j = i:len-1
%                 s = strcat(s, ',', num2str(j+1));
%             end
%             stemp = strvcat(' ', strcat('Сравнение классов ', num2str(i-1), ' c ', ' ', s));
%             out = strvcat(out, stemp, outf);
%             %                         cl1 = getcl(2);
%             %                         cl2 = getcl(3);
%             %                         %cl2 = getcli(2, 3);
%             %                     [res, outf] = Am(cl1, cl2, pr);
%             %                     out = strtrim(outf);
%         end
%         format shortG;
%         res1 = getres(1);
%         len = length(res1(1, : , :));
%         lenresult = getreslen();
%         outStr = '';
%         w{4,1,len} = [];
%         k1 = 0; k2 = 0; k3 = 0;
%         pr = getpr();
%         for j = 1:pr
%             for k = 1:lenresult
%                 res = getres(k);
%                 k1 = k1 + [res{1, 1, j}];
%                 k2 = k2 + [res{2, 1, j}];
%                 k3 = k3 + [res{3, 1, j}];
%             end
%             k4 = length([res{4,1,j}]);
%             w(1,1,j) = {k1/2};
%             w(2,1,j) = {k2/2};
%             w(3,1,j) = {k3/2};
%             w(4,1,j) = {k4};
%             k1 = 0; k2 = 0; k3 = 0;
%         end
%         w = AsortPP(w, 1, pr);
%         k4 = 2;
%         idStart = pr+1;
%         for j = pr+1:len
%             for k = 1:lenresult
%                 res = getres(k);
%                 k1 = k1 + [res{1, 1, j}];
%                 k2 = k2 + [res{2, 1, j}];
%                 k3 = k3 + [res{3, 1, j}];
%             end
%             if (k4 < length([res{4,1,j}]))
%                 w = AsortPP(w, idStart, j - 1);
%                 idStart = j;
%             end
%             k4 = length([res{4,1,j}]);
%             w(1,1,j) = {k1/2};
%             w(2,1,j) = {k2/2};
%             w(3,1,j) = {k3/2};
%             w(4,1,j) = {k4};
%             %outStr = strvcat(outStr, sprintf('%d:\t%4.2f\t%4.2f\t%4.2f\t%d',j, k1/lenresult, k2/lenresult, k3/lenresult, k4));
%             k1 = 0; k2 = 0; k3 = 0;
%         end
%         
%         for id = 1:len
%             outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%d',id, [w{1, 1, id}], [w{2, 1, id}], [w{3, 1, id}], [w{4, 1, id}]));
%         end
%         
%         %outStr = strvcat(outStr,
%         %sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
%         out = strvcat(out, 'Результирующая выборка ', outStr);
%     end
%     
%     t1 = get(handles.edit7, 'String');%priznaki
%     t2 = get(handles.edit3, 'String');%classes
%     if isempty(t2)
%         set(handles.edit3, 'String', '1');
%         t2 = '1';
%     end
%     t2 = str2num(t2);
%     cl1 = getcl(t2);
%     cl2 = getcli(t2 + 1, getcllen());
%     t1 = str2num(t1);
%     for i = 1:length(t1)
%         cl1t(:, i) = cl1(:, t1(i));
%         cl2t(:, i) = cl2(:, t1(i));
%     end
%     res = NS(cl1t, cl2t, length(t1));
%     
%     out = sprintf('Вероятность  =  %f\r\nОшибка 1 рода  =  %f\r\nОшибка 2 рода  =  %f\r\n', res(1), res(2), res(3));
% end
%     otherwise % Cl
%         aCmain(pr);


%writefile(handles.cbSource, handles.cbMocov, handles.cbKr, handles.edit5, out, handles.cbSave);
%disp(res);
set(handles.edit5, 'String', out);
%set(findobj('text3','text3'),'String','MyString')


function [out] = writefile(cb1, cb2, cb3, edit, o, cb4)
global mo cov det Acell;
out = strvcat(o, '');
if (get(cb1,'Value') == get(cb1,'Max'))
	out = strvcat(out, 'Class1:', sprintf([repmat('%.4f\t', 1, size(getcl(1), 2)) '\n'], getcl(1)'));
    out = strvcat(out, 'Class2:', sprintf([repmat('%.4f\t', 1, size(getcl(2), 2)) '\n'], getcl(2)'));
end

if (get(cb2,'Value') == get(cb2,'Max'))
%     moTemp = mo;
%     covTemp = cov;
%     moTemp(:, 3) = moTemp(:, 2);
%     moTemp(:, 2) = moTemp(:, 1);
%     for i = 1:length(moTemp)
%         moTemp(i, 1) = i;
%     end
%     covTemp(:, 3) = covTemp(:, 2);
%     covTemp(:, 2) = covTemp(:, 1);
%     for i = 1:length(covTemp)
%         covTemp(i, 1) = i;
%     end
	out = strvcat(out, 'Mo:', sprintf([repmat('%.4f\t', 1, size(mo, 2)) '\n'], mo'));
    out = strvcat(out, 'Cov:', sprintf([repmat('%.4f\t', 1, size(cov, 2)) '\n'], cov'));
    %out = strvcat(out, 'Det:', sprintf([repmat('%.4f\t', 1, size(det, 2))
    %'\n'], det'));
end

if (get(cb3,'Value') == get(cb3,'Max'))
	out = strvcat(out, 'Kr:', sprintf([repmat('%f\t%f\t%f\t', 1, size(Acell, 2)) '\n'], Acell));
end
% currString = get(edit,'String');
% currString{end+1}=out;
% set(edit,'String',currString);
set(edit, 'String', out);

if (get(cb3,'Value') == get(cb3,'Max'))
	out = strvcat(out, 'Kr:', sprintf([repmat('%f\t%f\t%f\t', 1, size(Acell, 2)) '\n'], Acell));
end

if (get(cb4,'Value') == get(cb4,'Max'))
	fileID = fopen('mout.txt','w+');
%fprintf(fileID,'%s',out);
fwrite(fileID,out)
fclose(fileID);
end

function [cl] = getcli(istart, iend)
cl = getcl(istart);
lens = length(cl);
for i = istart+1:iend
    clt = getcl(i);
    for j = 1:length(clt)
        for p = 1:getpr()
            cl(lens+j, p) = clt(j, p);
        end
    end
end

% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function text3_Callback(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text3 as text
%        str2double(get(hObject,'String')) returns contents of text3 as a double

% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in poVPR.
function poVPR_Callback(hObject, eventdata, handles)
% hObject    handle to poVPR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns poVPR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poVPR

handles = guidata(hObject);  % Update!
v2 = get(handles.poVPR, 'Value');
% Если выбранный метод не равен МСР, то не нужно задавать значеия
if(v2 == 2 || v2 == 3)
    set(handles.pushbutton5, 'Enable', 'on');
else
    set(handles.pushbutton5, 'Enable', 'off');
end

% --- Executes during object creation, after setting all properties.
function poVPR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poVPR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbSource.
function cbSource_Callback(hObject, eventdata, handles)
% hObject    handle to cbSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbSource

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles = guidata(hObject);  % Update!
switch get(get(handles.uipanel5,'SelectedObject'),'Tag')
    case 'rbVPR'
        v2 = get(handles.poVPR,'Value');
    otherwise
        v2 = [];
end
uiwait(untitled(v2));


% --------------------------------------------------------------------
function Data_Callback(hObject, eventdata, handles)
% hObject    handle to Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Data_Create_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
global resumeFlag;
resumeFlag = false;
uiwait(dataCreate());
if not(resumeFlag)
    return;
end
cl = getcl(1);
setpr(length(cl(1,:)));
str = strcat('Количество признаков: ', num2str(length(cl(1,:))));
for i = 1:getcllen()
    str = strvcat(str, strcat(num2str(i), ' класс = ', ' ', num2str(length(getcl(i))), ' элементов'));
end
set(handles.edit6, 'String', str);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter err1:','Enter err2:','Enter C1:','Enter C2:'};
dlg_title = 'Input';
num_lines = 1;
def = {'','','1','1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
is_validChar = cellfun(@(x) ( isempty(x)), ...
    answer, 'UniformOutput', true);
if any(is_validChar)
    warndlg('Некорректные данные', 'Предупреждение!');
    return;
end
a = cell2mat(answer);
a = str2num(a);
is_validNum = arrayfun(@(x) ( x < 0 ), ...
    a, 'UniformOutput', true);
if any(is_validNum)
    warndlg('Некорректные данные', 'Предупреждение!');
    return;
end
q1 = a(2)/100;
q2 = a(1)/100;
r = a(3)*q1*1/2 + a(4)*q2*1/2;
message = ['Средний риск = ' num2str(r)];
msgbox(message);

% --------------------------------------------------------------------
function plotAllPerms(len)
x = [];
len = len + 1;
% len = 14;%12 14 18
for i = 1 : len
    x(i) = i-1;
end
% pp(1:tl) = 0;
%(n+1)*n/2;
% temp = tl;
% for n = 1:tl
%     mk(n) = 10;
%     sp(n) = temp;
%     temp = temp - 1;
% end
% % pp(1) = length(nchoosek(f, 1));
% for i = 1:tl
% %     pp(i) = pp(i-1) + length(nchoosek(f, i));
%     [e, ert] = size(nchoosek(f, i));
%     pp(i) = e;
% end
m(1) = 0;
for i = 2:len
    m(i) = 6*i;
end
pp = zeros(1,len);
sp = zeros(1,len);
mk = zeros(1,len);
[row, ert] = size(nchoosek(x, 1));
pp(2) = row;
sp(2) = 1;
global MKconfigS;
mk(2) = MKconfigS(1);
for i = 3:len
    [row, ert] = size(nchoosek(x, i));
    pp(i) = pp(i-1) + row;
    sp(i) = sp(i-1) + i;
    mk(i) = mk(i-1) + MKconfigS(i-1);%floor(row*0.1) + 1
end
%length(nchoosek(f, 3))
% nchoosek(f, 3)
% m
% mk
% sp
% pp
mk = m;
figure('Position',[300 100 800 800])
hold on;
plot(x, pp, 'r-','LineWidth',1.5);
plot(x, sp, 'b--','LineWidth',1.5);%,'LineWidth',3
plot(x, mk, ':m','LineWidth',1.5);
grid on;
xlabel('Количество признаков');
ylabel('Объем вычислений');
% axis auto
% set(gca, 'XTick',-1:1:tl);
% plot(t1, 1, 'r+');
% hold on;
% plot(class2(:, 1), class2(:, 2), 'ro');
legend('Полный перебор','Сокращенный перебор','Монте-Карло');

function plotAllP(maxP1, maxP2, maxP3)
figure(42);
bar([maxP1;maxP2;maxP3]');
map = [ 0.5,    0,      0;
        0,      0.3,    0.5
        0,      0.5,    0];
colormap(map)
grid on;
ylim([0 100]);
xlabel('Количество признаков');
ylabel('Вероятность правильного распознавания');
legend('Полный перебор','Сокращенный перебор','Монте-Карло');


% --------------------------------------------------------------------
function SaveNowClasees_Callback(hObject, eventdata, handles)
% hObject    handle to SaveNowClasees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = 'classes.mat';
if getcllen() < 0
    disp('Классы не загруженны');
    return;
end
class1 = getcl(1);
class2 = getcl(2);
q = 1;
while (exist(file, 'file')) == 2
    f = file(length(file)-4:length(file)-4);
    if f == num2str(q-1)
        file = [file(1:length(file)-5) num2str(q) file(length(file)-3:length(file))];
    else
        file = [file(1:length(file)-4) num2str(q) file(length(file)-3:length(file))];
    end
    q = q + 1;
end
save (file, 'class1', 'class2');
