function varargout = VPCP(varargin)

 global ml0;
 global ml1;
 global ml2;
 global ml3;
 global ml4;
 global ml5;
 global ml6;
 global ml7;
% VPCP MATLAB code for VPCP.fig
%      VPCP, by itself, creates a new VPCP or raises the existing
%      singleton*.
%
%      H = VPCP returns the handle to a new VPCP or the handle to
%      the existing singleton*.
%
%      VPCP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VPCP.M with the given input arguments.
%
%      VPCP('Property','Value',...) creates a new VPCP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VPCP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VPCP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VPCP

% Last Modified by GUIDE v2.5 30-May-2023 19:55:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VPCP_OpeningFcn, ...
                   'gui_OutputFcn',  @VPCP_OutputFcn, ...
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


% --- Executes just before VPCP is made visible.
function VPCP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VPCP (see VARARGIN)

% Choose default command line output for VPCP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VPCP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VPCP_OutputFcn(hObject, eventdata, handles) 
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
 global ml0;
 global ml1;
 global ml2;
 global ml3;
 global ml4;
 global ml5;
 global ml6;
 global ml7;
 
 
  ml0=get(handles.m0,'string');
  ml0=str2num(ml0);
  ml1=get(handles.m1,'string');
  ml1=str2num(ml1);
  ml2=get(handles.m2,'string');
  ml2=str2num(ml2);
  ml3=get(handles.m3,'string');
  ml3=str2num(ml3);
  ml4=get(handles.m4,'string');
  ml4=str2num(ml4);
  ml5=get(handles.m5,'string');
  ml5=str2num(ml5);
  ml6=get(handles.m6,'string');
  ml6=str2num(ml6);
  ml7=get(handles.m7,'string');
  ml7=str2num(ml7);
  n0=ml0;
  n1=ml1;
  n2=ml2;
  n3=ml3;
  n4=ml4;
  n5=ml5;
  n6=ml6;
  n7=ml7;
  syms x;
  D=@(x)(n0+n1*(1-exp(-x/0.001))+n2*(1-exp(-x/0.01))+n3*(1-exp(-x/0.1))+n4*(1-exp(-x/1))+n5*(1-exp(-x/10))+n6*(1-exp(-x/100))+n7*(1-exp(-x/1000))); 
if get(handles.radiobutton1,'value')
    bkm=1;
else 
     bkm=2;
end
if  get(handles.radiobutton3,'value')
    ct=1;
else
    ct=2;
end
if (ct==1)
    t=get(handles.tm,'string');
    disp(t);
end

if (ct==2)
    t1=get(handles.t1,'string');
    t1=str2double(t1);
    disp(t1);
    t2=get(handles.t2,'string');
    t2=str2double(t2);
    disp(t2);
    dt=get(handles.dt,'string');
    dt=str2double(dt);
    disp(dt);
end
    
if(bkm==1 && ct==1)
    y=FT(t);
    msgbox('Calculation completed','Reminder Information');
end

if (bkm==2 && ct==1)
    y=FT(t);
    msgbox('Calculation completed','Reminder Information');
end

if(bkm==1 && ct==2)
   t=t1:dt:t2;
   creep=D(t);
   plot(handles.axes1,t,creep);
   ylabel(handles.axes1,'creep compliance（1/MPa）');
   title(handles.axes1,'creep compliance');
    for i=t1:dt:t2
       intel(i)=int(D,x,i,i+dt);
    end

    vpa(intel);
    
    y(t1)=t1/intel(t1);
    sum=0;
    for i=t1+1:dt:t2
        sum=0;
        for j=t1:dt:i-1
           sum=sum+y(j)*intel(i-j+t1);
        end
        y(i)=(i-sum)/intel(t1);
    end
  plot(handles.axes2,t,y);
  xlabel(handles.axes2,'t/s');
  ylabel(handles.axes2,'Relaxation modulus/MPa');
  title(handles.axes2,'Relaxation modulus');
  msgbox('Calculation completed','Reminder Information');
end

if(bkm==2 && ct==2)
   t=t1:dt:t2;
   creep=D(t);
   plot(handles.axes1,t,creep);
 ylabel(handles.axes1,'creep compliance（1/MPa）');
   title(handles.axes1,'creep compliance');
  y=FT(t);
%   figure(1)
%   plot(t,creep);
%     xlabel('t/s');
%    ylabel('creep compliance（1/MPa）');
%    title('creep compliance');
%   figure(2)
%   plot(t,y);
%   xlabel('t/s');
%   ylabel('Relaxation modulus（MPa）');
%   title('Relaxation modulus');
  plot(handles.axes2,t,y);
  xlabel(handles.axes2,'t/s');
  ylabel(handles.axes2,'Relaxation modulus（MPa）');
  title(handles.axes2,'Relaxation modulus');
  msgbox('Calculation completed','Reminder Information');
end
  
 [filename,pathname] = uiputfile({'*.xls','excel(*.xls)'}, 'Save Data','Untitled');
if filename==0
    return
end
  number=length(t);

  xlswrite([pathname filename],t','sheet1','A'); 
  xlswrite([pathname filename],y','sheet1','B'); 
  xlswrite([pathname filename],creep','sheet1','C'); 



function y=FT(t)
 global ml0;
 global ml1;
 global ml2;
 global ml3;
 global ml4;
 global ml5;
 global ml6;
 global ml7;
  M=15;
  at=2*M./(5.*t);               %r
  m1=0.001;
  m2=0.01;
  m3=0.1;
  m4=1;
  m5=10;
  m6=100;
  m7=1000;
  n0=ml0;
  n1=ml1;
  n2=ml2;
  n3=ml3;
  n4=ml4;
  n5=ml5;
  n6=ml6;
  n7=ml7;
  s=at;
  J=(n0+n1+n2+n3+n4+n5+n6+n7)./s-n1.*(1./(s+1./m1))-n2.*(1./(s+1./m2))...
      -n3.*(1./(s+1./m3))-n4.*(1./(s+1./m4))-n5.*(1./(s+1./m5))...
      -n6.*(1./(s+1./m6))-n7.*(1./(s+1./m7));
  F=1./(s.*s.*J);
  y=exp(at.*t)/2.*F;
  m=M-1;
  Y=0;
  for k=1:1:m
      zta=k*pi/M;
      F1=at.*zta.*(cot(zta)+1i);  
      s=F1;
      J=(n0+n1+n2+n3+n4+n5+n6+n7)./s-n1.*(1./(s+1./m1))...
          -n2.*(1./(s+1./m2))-n3.*(1./(s+1./m3))-n4.*(1./(s+1./m4))...
          -n5.*(1./(s+1./m5))-n6.*(1./(s+1./m6))-n7.*(1./(s+1./m7));
      F=1./(s.*s.*J);
      Y=Y+exp(t.*F1).*F*(1+1i*(zta+(zta*cot(zta)-1)*cot(zta)));
  end
  y=y+real(Y);
  y=at/M.*y;
  
 
  
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
set(handles.m0,'string','');
set(handles.m1,'string',' ');
set(handles.m2,'string',' ');
set(handles.m3,'string',' ');
set(handles.m4,'string',' ');
set(handles.m5,'string',' ');
set(handles.m6,'string',' ');
set(handles.m7,'string',' ');

set(handles.t1,'string',' ');
set(handles.t2,'string',' ');
set(handles.dt,'string',' ');
set(handles.tm,'string',' ');


% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 


function tm_Callback(hObject, eventdata, handles)
% hObject    handle to tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tm as text
%        str2double(get(hObject,'String')) returns contents of tm as a double


% --- Executes during object creation, after setting all properties.
function tm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1_Callback(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1 as text
%        str2double(get(hObject,'String')) returns contents of t1 as a double


% --- Executes during object creation, after setting all properties.
function t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_Callback(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2 as text
%        str2double(get(hObject,'String')) returns contents of t2 as a double


% --- Executes during object creation, after setting all properties.
function t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m4_Callback(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m2 as text
%        str2double(get(hObject,'String')) returns contents of m2 as a double


% --- Executes during object creation, after setting all properties.
function m4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m0_Callback(hObject, eventdata, handles)
% hObject    handle to m0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m0 as text
%        str2double(get(hObject,'String')) returns contents of m0 as a double


% --- Executes during object creation, after setting all properties.
function m0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m1_Callback(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m1 as text
%        str2double(get(hObject,'String')) returns contents of m1 as a double


% --- Executes during object creation, after setting all properties.
function m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m2_Callback(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m2 as text
%        str2double(get(hObject,'String')) returns contents of m2 as a double


% --- Executes during object creation, after setting all properties.
function m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m5_Callback(hObject, eventdata, handles)
% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m4 as text
%        str2double(get(hObject,'String')) returns contents of m4 as a double


% --- Executes during object creation, after setting all properties.
function m5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m6_Callback(hObject, eventdata, handles)
% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m5 as text
%        str2double(get(hObject,'String')) returns contents of m5 as a double


% --- Executes during object creation, after setting all properties.
function m6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m7_Callback(hObject, eventdata, handles)
% hObject    handle to m6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m6 as text
%        str2double(get(hObject,'String')) returns contents of m6 as a double


% --- Executes during object creation, after setting all properties.
function m7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function m3_Callback(hObject, eventdata, handles)
% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m3 as text
%        str2double(get(hObject,'String')) returns contents of m3 as a double


% --- Executes during object creation, after setting all properties.
function m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
clear all;
