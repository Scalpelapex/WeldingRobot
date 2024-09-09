function varargout = para_judge(varargin)
% PARA_JUDGE MATLAB code for para_judge.fig
%      PARA_JUDGE, by itself, creates a new PARA_JUDGE or raises the existing
%      singleton*.
%
%      H = PARA_JUDGE returns the handle to a new PARA_JUDGE or the handle to
%      the existing singleton*.
%
%      PARA_JUDGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARA_JUDGE.M with the given input arguments.
%
%      PARA_JUDGE('Property','Value',...) creates a new PARA_JUDGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before para_judge_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to para_judge_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help para_judge

% Last Modified by GUIDE v2.5 05-Jun-2022 22:54:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @para_judge_OpeningFcn, ...
                   'gui_OutputFcn',  @para_judge_OutputFcn, ...
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


% --- Executes just before para_judge is made visible.
function para_judge_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to para_judge (see VARARGIN)

% Choose default command line output for para_judge
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes para_judge wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load('newData.mat');
set(handles.uitable1,'Data',newData);
im0 = imread('33.jpg');
axes(handles.axes1);
imshow(im0);


% --- Outputs from this function are returned to the command line.
function varargout = para_judge_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'第n段末端角度','速度值'};
title = '请输入数据';
lines = [1.0,1.0];
def = {'0','0'};
tab = inputdlg(prompt,title,lines,def);
newrow1 = tab{1};
newrow2 = str2num(tab{2});
newArray = {newrow1,newrow2};
oldData = get(handles.uitable1,'Data');
newData = [oldData;newArray];
set(handles.uitable1,'Data',newData);

save('newData.mat','newData');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hangIndex = handles.hangIndex;  %获取选择以后传入的 行索引
newData = get(handles.uitable1,'Data');  %获取表格数据矩阵
newData(hangIndex,:) = [];   %删除选中的某行数据
set(handles.uitable1,'Data',newData);  %显示到表格中
save('newData.mat','newData');  %删除以后，保存一次数据


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
newData = get(hObject,'Data'); %获取数据矩阵
hang = eventdata.Indices;  %获取行索引
hangIndex = hang(1);  %行索引赋值
handles.hangIndex = hangIndex;  %把行索引添加到结构体
guidata(hObject, handles);  %更新结构体


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)