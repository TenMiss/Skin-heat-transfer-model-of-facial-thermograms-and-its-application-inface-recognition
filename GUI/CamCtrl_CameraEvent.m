function CamCtrl_CameraEvent(varargin)
% CAMCTRL_CAMERAEVENT
%   - Handle general events received from
%     the FLIR Active-X camera control
%
% see also CAMCTRL

% Created by Henrik Jönsson 4-Sep-2001
% Last Modified by Henrik Jönsson 11-Apr-2003

h = findobj('tag','camctrl');
handles = guidata(h);
% See Camera Control documentation for explanation of
%     the CameraEvent argument
switch double(varargin{3})
case 2
    set(handles.eventInfo,'string','Device is connected');
    set(handles.acquire,'enable','on');
    handles.CamCtrl_connected = 1;
    guidata(h,handles);
case 3
    set(handles.eventInfo,'string','Device is disconnected');
    handles.CamCtrl_connected = 0;
    guidata(h,handles);
case 4
    set(handles.eventInfo,'string','Device connection broken');
    handles.CamCtrl_connected = 0;
    guidata(h,handles);
case 5
    set(handles.eventInfo,'string','Device reconnected from broken connection');
    handles.CamCtrl_connected = 1;
    guidata(h,handles);
case 6
    set(handles.acquire,'enable','off');
    set(handles.eventInfo,'string','Device is in disconnecting phase');
    handles.CamCtrl_connected = 0;
    guidata(h,handles);
case 7
    set(handles.eventInfo,'string','Auto adjust event');
case 8
    set(handles.eventInfo,'string','Start of recalibration');
case 9
    set(handles.eventInfo,'string','End of recalibration');
case 10
%    set(handles.eventInfo,'string','LUT table updated'); % Ignore!
case 11
    set(handles.eventInfo,'string','Record conditions changed');
case 12
    set(handles.eventInfo,'string','Image captured');
end