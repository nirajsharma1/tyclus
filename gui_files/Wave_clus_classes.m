function varargout = Wave_clus_classes(varargin)
% WAVE_CLUS_CLASSES MATLAB code for Wave_clus_classes.fig
%      WAVE_CLUS_CLASSES, by itself, creates a new WAVE_CLUS_CLASSES or raises the existing
%      singleton*.
%
%      H = WAVE_CLUS_CLASSES returns the handle to a new WAVE_CLUS_CLASSES or the handle to
%      the existing singleton*.
%
%      WAVE_CLUS_CLASSES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVE_CLUS_CLASSES.M with the given input arguments.
%
%      WAVE_CLUS_CLASSES('Property','Value',...) creates a new WAVE_CLUS_CLASSES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Wave_clus_classes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Wave_clus_classes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Wave_clus_classes

% Last Modified by GUIDE v2.5 21-Jul-2016 16:04:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Wave_clus_classes_OpeningFcn, ...
                   'gui_OutputFcn',  @Wave_clus_classes_OutputFcn, ...
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


% --- Executes just before Wave_clus_classes is made visible.
function Wave_clus_classes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Wave_clus_classes (see VARARGIN)

% Choose default command line output for Wave_clus_classes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Wave_clus_classes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Wave_clus_classes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function class2_Callback(hObject, eventdata, handles)
% hObject    handle to class2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class2 as text
%        str2double(get(hObject,'String')) returns contents of class2 as a double


% --- Executes during object creation, after setting all properties.
function class2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class3_Callback(hObject, eventdata, handles)
% hObject    handle to class3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class3 as text
%        str2double(get(hObject,'String')) returns contents of class3 as a double


% --- Executes during object creation, after setting all properties.
function class3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class4_Callback(hObject, eventdata, handles)
% hObject    handle to class4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class4 as text
%        str2double(get(hObject,'String')) returns contents of class4 as a double


% --- Executes during object creation, after setting all properties.
function class4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class5_Callback(hObject, eventdata, handles)
% hObject    handle to class5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class5 as text
%        str2double(get(hObject,'String')) returns contents of class5 as a double


% --- Executes during object creation, after setting all properties.
function class5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class6_Callback(hObject, eventdata, handles)
% hObject    handle to class6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class6 as text
%        str2double(get(hObject,'String')) returns contents of class6 as a double


% --- Executes during object creation, after setting all properties.
function class6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class7_Callback(hObject, eventdata, handles)
% hObject    handle to class7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class7 as text
%        str2double(get(hObject,'String')) returns contents of class7 as a double


% --- Executes during object creation, after setting all properties.
function class7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class8_Callback(hObject, eventdata, handles)
% hObject    handle to class8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class8 as text
%        str2double(get(hObject,'String')) returns contents of class8 as a double


% --- Executes during object creation, after setting all properties.
function class8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class1_Callback(hObject, eventdata, handles)
% hObject    handle to class1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class1 as text
%        str2double(get(hObject,'String')) returns contents of class1 as a double


% --- Executes during object creation, after setting all properties.
function class1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class9_Callback(hObject, eventdata, handles)
% hObject    handle to class9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class9 as text
%        str2double(get(hObject,'String')) returns contents of class9 as a double


% --- Executes during object creation, after setting all properties.
function class9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function class10_Callback(hObject, eventdata, handles)
% hObject    handle to class10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class10 as text
%        str2double(get(hObject,'String')) returns contents of class10 as a double


% --- Executes during object creation, after setting all properties.
function class10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c1 = get(handles.class1, 'String');
c2 = get(handles.class2, 'String');
c3 = get(handles.class3, 'String');
c4 = get(handles.class4, 'String');
c5 = get(handles.class5, 'String');
c6 = get(handles.class6, 'String');
c7 = get(handles.class7, 'String');
c8 = get(handles.class8, 'String');
c9 = get(handles.class9, 'String');
c10 = get(handles.class10, 'String');
[EEG] = pop_loadbv;
EEG = eeg_checkset( EEG );
assignin('base', 'EEG',EEG);
classes = {c1 c2 c3 c4 c5 c6 c7 c8 c9 c10};
f_postWC_EEGexport(EEG, classes);