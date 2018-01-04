function varargout = gameForm(varargin)
% GAMEFORM MATLAB code for gameForm.fig
%      GAMEFORM, by itself, creates a new GAMEFORM or raises the existing
%      singleton*.
%
%      H = GAMEFORM returns the handle to a new GAMEFORM or the handle to
%      the existing singleton*.
%
%      GAMEFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAMEFORM.M with the given input arguments.
%
%      GAMEFORM('Property','Value',...) creates a new GAMEFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gameForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gameForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gameForm

% Last Modified by GUIDE v2.5 01-Dec-2016 15:23:01

% Begin initialization code - DO NOT EDIT



gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gameForm_OpeningFcn, ...
                   'gui_OutputFcn',  @gameForm_OutputFcn, ...
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
end


% --- Executes just before gameForm is made visible.
function gameForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gameForm (see VARARGIN)

% Choose default command line output for gameForm
handles.output = hObject;


global nodes;
global curr;

curr = 1;
nodes = nodeLoader('nodeStuff.txt');
% Update handles structure
guidata(hObject, handles);

setDisplay(nodes(curr).des, hObject);

% UIWAIT makes gameForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = gameForm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end



function inp_Callback(hObject, eventdata, handles)
% hObject    handle to inp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inp as text
%        str2double(get(hObject,'String')) returns contents of inp as a double

inp = get(hObject, 'String');
global curr;
global nodes;
out = wordProc(inp, nodes(curr).words);

warning = 'Professor Smith''s words echoed... There''s a time and place for everything, but not now.';

if strcmp(class(out), 'logical')
    uiwait(msgbox(warning, 'Uh-oh!'));
elseif strcmp(class(out), 'double')
    if isempty(out)
       uiwait(msgbox('Sorry, I don''t know what that means. Be more specific, rephrase your sentence, check for spelling errors, or do something else.', 'Uh-oh!'));
    else
        curr = nodes(curr).cons(out);
        if isRandNode(curr)
            curr = getRandNode(curr);
        end
        if curr >= 50 & curr <= 60
            curr = radioBox(curr);
        elseif curr == 61
            curr = sliderBox();
        elseif curr == 62
            curr = imageBox();
        elseif curr == 100
            close all;
        end
        setDisplay(nodes(curr).des, hObject);
    end
end

end



function out = isRandNode(ind)
    out = any([3 69] == ind);
end
function setDisplay(str, obj)

    fig = ancestor(obj, 'figure');
    data = guidata(fig);
    data.displayText.String = str;

end
% --- Executes during object creation, after setting all properties.
function inp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
