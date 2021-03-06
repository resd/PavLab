function varargout = untitled(varargin)
% UNTITLED M-file for untitled.fig
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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

function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
initialize_gui(hObject, handles, false);

function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function Imax_Callback(hObject, eventdata, handles)
volt = str2double(get(hObject, 'String'));
if isnan(volt)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.metricdata.volt = volt;
guidata(hObject,handles)

function Imax_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Calculate_Callback(hObject, eventdata, handles)

c = [];
if(get(handles.checkbox1, 'Value') == 0)
    c(1) = str2num(get(handles.c1, 'String'));
    c(2) = str2num(get(handles.c2, 'String'));
    c(3) = str2num(get(handles.c3, 'String'));
    c(4) = str2num(get(handles.c4, 'String'));
    c(5) = str2num(get(handles.c5, 'String'));
    c(6) = str2num(get(handles.c6, 'String'));
end
Imax = str2num(get(handles.Imax, 'String'));
cb = get(handles.checkbox1, 'Value');
setMSAdata(c, Imax, cb);
% todo �������� �������� ���� �����.

function initialize_gui(fig_handle, handles, isreset)

if isfield(handles, 'metricdata')
    return;
end
Imaxt = getMSAdata('Imax');
c = getMSAdata('c');
if(c ~= -1)
    if(not(isempty(c)))
        set(handles.c1, 'String', c(1));
        set(handles.c2, 'String', c(2));
        set(handles.c3, 'String', c(3));
        set(handles.c4, 'String', c(4));
        set(handles.c5, 'String', c(5));
        set(handles.c6, 'String', c(6));
    end
end
if (Imaxt ~= -1)
    if(not(isempty(Imaxt)))
        set(handles.Imax, 'String', Imaxt);
    end
end
cbt = getMSAdata('cb');
if (cbt ~= -1)
    if(not(isempty(cbt)))
        set(handles.checkbox1, 'Value', cbt);
        if(get(handles.checkbox1, 'Value') == 1)
            set(handles.c1, 'Enable', 'off');
            set(handles.c2, 'Enable', 'off');
            set(handles.c3, 'Enable', 'off');
            set(handles.c4, 'Enable', 'off');
            set(handles.c5, 'Enable', 'off');
            set(handles.c6, 'Enable', 'off');
        else
            set(handles.c1, 'Enable', 'on');
            set(handles.c2, 'Enable', 'on');
            set(handles.c3, 'Enable', 'on');
            set(handles.c4, 'Enable', 'on');
            set(handles.c5, 'Enable', 'on');
            set(handles.c6, 'Enable', 'on');
        end
    end
end

% handles.metricdata.rezist = 0;
% handles.metricdata.Imax  = 0;
% 
% set(handles.rezist, 'String', handles.metricdata.rezist);
% set(handles.Imax,  'String', handles.metricdata.Imax);
% set(handles.tok, 'String', 0);

% Update handles structure
guidata(handles.figure1, handles);



function c1_Callback(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1 as text
%        str2double(get(hObject,'String')) returns contents of c1 as a double


% --- Executes during object creation, after setting all properties.
function c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2_Callback(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2 as text
%        str2double(get(hObject,'String')) returns contents of c2 as a double


% --- Executes during object creation, after setting all properties.
function c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c3_Callback(hObject, eventdata, handles)
% hObject    handle to c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c3 as text
%        str2double(get(hObject,'String')) returns contents of c3 as a double


% --- Executes during object creation, after setting all properties.
function c3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c4_Callback(hObject, eventdata, handles)
% hObject    handle to c4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c4 as text
%        str2double(get(hObject,'String')) returns contents of c4 as a double


% --- Executes during object creation, after setting all properties.
function c4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c5_Callback(hObject, eventdata, handles)
% hObject    handle to c5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c5 as text
%        str2double(get(hObject,'String')) returns contents of c5 as a double


% --- Executes during object creation, after setting all properties.
function c5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c6_Callback(hObject, eventdata, handles)
% hObject    handle to c6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c6 as text
%        str2double(get(hObject,'String')) returns contents of c6 as a double


% --- Executes during object creation, after setting all properties.
function c6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if(get(handles.checkbox1, 'Value') == 1)
    set(handles.c1, 'Enable', 'off');
    set(handles.c2, 'Enable', 'off');
    set(handles.c3, 'Enable', 'off');
    set(handles.c4, 'Enable', 'off');
    set(handles.c5, 'Enable', 'off');
    set(handles.c6, 'Enable', 'off');
else
    set(handles.c1, 'Enable', 'on');
    set(handles.c2, 'Enable', 'on');
    set(handles.c3, 'Enable', 'on');
    set(handles.c4, 'Enable', 'on');
    set(handles.c5, 'Enable', 'on');
    set(handles.c6, 'Enable', 'on');
end