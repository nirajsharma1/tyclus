function varargout = coi_gui(varargin)
% COI_GUI MATLAB code for coi_gui.fig
%      COI_GUI, by itself, creates a new COI_GUI or raises the existing
%      singleton*.
%
%      H = COI_GUI returns the handle to a new COI_GUI or the handle to
%      the existing singleton*.
%
%      COI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COI_GUI.M with the given input arguments.
%
%      COI_GUI('Property','Value',...) creates a new COI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coi_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coi_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coi_gui

% Last Modified by GUIDE v2.5 15-Jul-2016 15:38:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coi_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @coi_gui_OutputFcn, ...
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


% --- Executes just before coi_gui is made visible.
function coi_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coi_gui (see VARARGIN)

% Choose default command line output for coi_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

EEG = evalin('base', 'EEG');

% UIWAIT makes coi_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coi_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ch1_Callback(hObject, eventdata, handles)
% hObject    handle to ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1 as text
%        str2double(get(hObject,'String')) returns contents of ch1 as a double


% --- Executes during object creation, after setting all properties.
function ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in finish.
function finish_Callback(hObject, eventdata, handles)
% hObject    handle to finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
chan1 = get(handles.ch1, 'String');
chan2 = get(handles.ch2, 'String');
chan3 = get(handles.ch3, 'String');
chan4 = get(handles.ch4, 'String');
chan5 = get(handles.ch5, 'String');
chan6 = get(handles.ch6, 'String');
chan7 = get(handles.ch7, 'String');
chan8 = get(handles.ch8, 'String');
chan9 = get(handles.ch9, 'String');
chan10 = get(handles.ch10, 'String');
chan11 = get(handles.ch11, 'String');
chan12 = get(handles.ch12, 'String');
chan13 = get(handles.ch13, 'String');
chan14 = get(handles.ch14, 'String');
spikelabel = get(handles.mdesc, 'String');
chann_label = {chan1 chan2 chan3 chan4 chan5 chan6 chan7 chan8 chan9 chan10 chan11 chan12 chan13 chan14};
set(handles.result, 'String', chann_label);
set(handles.marker, 'String', spikelabel);
% save('chann_label');
EEG = evalin('base', 'EEG');
% f_spikerealignment(chann_label, spikelabel)
f_spikerealignment(chann_label, spikelabel, EEG);



function ch2_Callback(hObject, eventdata, handles)
% hObject    handle to ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2 as text
%        str2double(get(hObject,'String')) returns contents of ch2 as a double


% --- Executes during object creation, after setting all properties.
function ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3_Callback(hObject, eventdata, handles)
% hObject    handle to ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3 as text
%        str2double(get(hObject,'String')) returns contents of ch3 as a double


% --- Executes during object creation, after setting all properties.
function ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch4_Callback(hObject, eventdata, handles)
% hObject    handle to ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4 as text
%        str2double(get(hObject,'String')) returns contents of ch4 as a double


% --- Executes during object creation, after setting all properties.
function ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch5_Callback(hObject, eventdata, handles)
% hObject    handle to ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch5 as text
%        str2double(get(hObject,'String')) returns contents of ch5 as a double


% --- Executes during object creation, after setting all properties.
function ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch6_Callback(hObject, eventdata, handles)
% hObject    handle to ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch6 as text
%        str2double(get(hObject,'String')) returns contents of ch6 as a double


% --- Executes during object creation, after setting all properties.
function ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch7_Callback(hObject, eventdata, handles)
% hObject    handle to ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch7 as text
%        str2double(get(hObject,'String')) returns contents of ch7 as a double


% --- Executes during object creation, after setting all properties.
function ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch8_Callback(hObject, eventdata, handles)
% hObject    handle to ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch8 as text
%        str2double(get(hObject,'String')) returns contents of ch8 as a double


% --- Executes during object creation, after setting all properties.
function ch8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch9_Callback(hObject, eventdata, handles)
% hObject    handle to ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch9 as text
%        str2double(get(hObject,'String')) returns contents of ch9 as a double


% --- Executes during object creation, after setting all properties.
function ch9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch10_Callback(hObject, eventdata, handles)
% hObject    handle to ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch10 as text
%        str2double(get(hObject,'String')) returns contents of ch10 as a double


% --- Executes during object creation, after setting all properties.
function ch10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch11_Callback(hObject, eventdata, handles)
% hObject    handle to ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch11 as text
%        str2double(get(hObject,'String')) returns contents of ch11 as a double


% --- Executes during object creation, after setting all properties.
function ch11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch12_Callback(hObject, eventdata, handles)
% hObject    handle to ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch12 as text
%        str2double(get(hObject,'String')) returns contents of ch12 as a double


% --- Executes during object creation, after setting all properties.
function ch12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch13_Callback(hObject, eventdata, handles)
% hObject    handle to ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch13 as text
%        str2double(get(hObject,'String')) returns contents of ch13 as a double


% --- Executes during object creation, after setting all properties.
function ch13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch14_Callback(hObject, eventdata, handles)
% hObject    handle to ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch14 as text
%        str2double(get(hObject,'String')) returns contents of ch14 as a double


% --- Executes during object creation, after setting all properties.
function ch14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mdesc_Callback(hObject, eventdata, handles)
% hObject    handle to mdesc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mdesc as text
%        str2double(get(hObject,'String')) returns contents of mdesc as a double


% --- Executes during object creation, after setting all properties.
function mdesc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mdesc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
