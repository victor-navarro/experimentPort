function varargout = mpigeon(varargin)
% MPIGEON M-file for mpigeon.fig
%      MPIGEON, by itself, creates a new MPIGEON or raises the existing
%      singleton*.
%
%      H = MPIGEON returns the handle to a new MPIGEON or the handle to
%      the existing singleton*.
%
%      MPIGEON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MPIGEON.M with the given input arguments.
%
%      MPIGEON('Property','Value',...) creates a new MPIGEON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mpigeon_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mpigeon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help mpigeon

% Last Modified by GUIDE v2.5 21-Dec-2004 13:07:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mpigeon_OpeningFcn, ...
                   'gui_OutputFcn',  @mpigeon_OutputFcn, ...
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


% --- Executes just before mpigeon is made visible.
function mpigeon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mpigeon (see VARARGIN)

global gmPigeonConfigured
gmPigeonConfigured=false;
% Choose default command line output for mpigeon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mpigeon wait for user response (see UIRESUME)
% uiwait(handles.figure1);
pict=imread('pict.tif');
image(0,0,pict);

if isempty(varargin)
    set(handles.text2,'String','mPigeon was not called by an experiment.');
else
    %message=['Experiment: ' varargin];
    set(handles.text2,'String',['Experiment: ' char(varargin)]);
end

% --- Outputs from this function are returned to the command line.
function varargout = mpigeon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in initbutton.
function initbutton_Callback(hObject, eventdata, handles)
% hObject    handle to initbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gmPigeonConfigured
global gIOState
global gmpigeonPort
%gmpigeonPort=2;%if modem is installed port 2 would be BELKIN
%comm('open',gmpigeonPort,'9600,n,8,1')
IOPort('CloseAll');
relayHardCode
set(handles.checkbutton,'Enable', 'on');
set(handles.okbutton,'Enable', 'on');
gmPigeonConfigured=true;
gIOState=0;

% --- Executes on button press in checkbutton.
function checkbutton_Callback(hObject, eventdata, handles)
% hObject    handle to checkbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gmpigeonPort
global gmPigeonConfigured;
if gmPigeonConfigured==true
    %comm('write',gmpigeonPort,'0');
    blackbox('light');
    blackbox('feeder');
    %comm('write',gmpigeonPort,'3');% lamp and feeder
    WaitSecs(0.5);    % wait 0.5 sec  
    %comm('write',gmpigeonPort,'2');% lamp only
        %WaitSecs(0.8);    % wait 0.8 sec
    blackbox('feeder');
    %comm('write',gmpigeonPort,'3');% lamp and feeder
    WaitSecs(0.5);    % wait 0.5 sec
    blackbox('dark');
    %comm('write',gmpigeonPort,'0');
end

% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

