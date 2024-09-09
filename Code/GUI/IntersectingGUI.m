function varargout = IntersectingGUI(varargin)
% INTERSECTINGGUI MATLAB code for IntersectingGUI.fig
%      INTERSECTINGGUI, by itself, creates a new INTERSECTINGGUI or raises the existing
%      singleton*.
%
%      H = INTERSECTINGGUI returns the handle to a new INTERSECTINGGUI or the handle to
%      the existing singleton*.
%
%      INTERSECTINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERSECTINGGUI.M with the given input arguments.
%
%      INTERSECTINGGUI('Property','Value',...) creates a new INTERSECTINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntersectingGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IntersectingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntersectingGUI

% Last Modified by GUIDE v2.5 05-Jun-2022 20:56:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntersectingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @IntersectingGUI_OutputFcn, ...
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


% --- Executes just before IntersectingGUI is made visible.
function IntersectingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntersectingGUI (see VARARGIN)

% Choose default command line output for IntersectingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IntersectingGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IntersectingGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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
para_judge

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

r1=str2num(get(handles.edit1,'string'))/1000;
r2=str2num(get(handles.edit2,'string'))/1000;
[xt,yt,zt]=intersecting_creat(r1,r2);
axes(handles.axes1);
cla reset;
plot3(xt,yt,zt,'o','Color','r','MarkerSize',6,'MarkerFaceColor','#D9FFFF');
hold on
[x1,y1,z1]=cylinder(r2);
[z2,y2,x2]=cylinder(r1);
z1 = 2.*z1-1;
x2 = 2.*x2-1;
mesh(x1,y1,z1);
hold on;
mesh(x2,y2,z2);
xlim([-1,1]);
ylim([-1,1]);
zlim([-1,1]);
view(60,20);

axes(handles.axes2);
cla reset;
plot3(xt,yt,zt,'o','Color','r','MarkerSize',6,'MarkerFaceColor','#D9FFFF');
hold on
[x1,y1,z1]=cylinder(r2);
[z2,y2,x2]=cylinder(r1);
z1 = 2.*z1-1;
x2 = 2.*x2-1;
mesh(x1,y1,z1);
hold on;
mesh(x2,y2,z2);
xlim([-1,1]);
ylim([-1,1]);
zlim([-1,1]);
view(90,0);


% axis([fanweil fanweir fanweiu fanweid]);
