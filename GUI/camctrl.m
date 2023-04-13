function varargout = camctrl(varargin)
%
% Intergration of Camera Control and our developed face recognition system
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Created by Wu Shiqian, I2R, 13- July-2004
% Last Modified by Wu Shiqian 5-Nov-2004
%
% Copyright by Institute for Infocomm Research, Singapore, 2004
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camctrl_OpeningFcn, ...
                   'gui_OutputFcn',  @camctrl_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% camctrl_OpeningFcn
% ---------------------------------------------------------------------------------------->>>>>>>>>>
% --- Executes just before camctrl is made visible.
function camctrl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camctrl (see VARARGIN)

% Choose default command line output for camctrl
handles.output = hObject;
map=colormap(gray);
handles.map=map;
handles.CamCtrl_connected = 0; % No camera is currently connected
handles.imageData = [];
handles.segmentedData = [];
%data = load('D:\MATLAB6p5\Project\Data\dataBase.mat');
data = load('D:\Database\rawData\Alvin.mat');
DB_Name = fieldnames(data);
DB=getfield(data,DB_Name{1});
fields=fieldnames(DB);
% if (length(fields) == 2) &(strcmp(fields{1},'Name')) & (strcmp(fields{2},'Templates'))
%     handles.DB=DB;
% end
handles.DB=DB;
%data=load('D:\MATLAB6p5\Project\Data\features.mat');
data = load('D:\Database\rawData\Alvin.mat');
fld = fieldnames(data);
features=getfield(data,fld{1});
handles.features=features;
%data=load('D:\MATLAB6p5\Project\Data\bioFeatures.mat');
data = load('D:\Database\rawData\Alvin.mat');
fld = fieldnames(data);
bioFeatures=getfield(data,fld{1});
handles.bioFeatures=bioFeatures;
% Update handles structure
guidata(hObject, handles);

image_frame = handles.imageFrame;
set(handles.camctrl,'doublebuffer','on');
set(image_frame,'drawmode','fast');
nameList={DB.Name};
set(handles.nameList,'string',nameList);
set(handles.registeredNo,'string',length(DB));
set(handles.acquireMode,'value',2);
set(handles.imageType,'value',4);
%setappdata(handles.camctrl,'sig',1);
% UIWAIT makes camctrl wait for user response (see UIRESUME)
% uiwait(handles.CamCtrl);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END camctrl_OpeningFcn
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% camctrl_OutoutFcn
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function varargout = camctrl_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END camctrl_OutputFcn
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% nuc_callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function nuc_Callback(hObject, eventdata, handles)
if ~handles.CamCtrl_connected
    msgbox('Must be connected first!','Error:');
    return;
end
invoke(handles.CamCtrl_activeX_h,'DoCameraAction',8);   
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END nuc_callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% autoFocus_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function autoFocus_Callback(hObject, eventdata, handles)
if ~handles.CamCtrl_connected
    msgbox('Must be connected first!','Error:');
    return;
end
invoke(handles.CamCtrl_activeX_h,'DoCameraAction',12);    
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END autoFocus_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% exit_camctrl_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function exit_camctrl_Callback(hObject, eventdata, handles)
% Disconnect & close Active-X, then close figure
disconnect_Callback(hObject, eventdata, handles);
closereq;
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END exit_camctrl_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% disconnect_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function disconnect_Callback(hObject, eventdata, handles)
% This function will disconnect from any connected camera,
% and then close the Active-X container figure
fig = handles.camctrl;
handles = guidata(fig);
if (handles.CamCtrl_connected == 1)
    result = invoke(handles.CamCtrl_activeX_h,'Disconnect');
end
if isfield(handles,'CamCtrl_figure_h');
    delete(handles.CamCtrl_figure_h);
    handles = rmfield(handles,'CamCtrl_figure_h');
    guidata(fig, handles);
end
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END disconnect_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% connect_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function connect_Callback(hObject, eventdata, handles)
% This function will create a new figure as a container
% for the CamCtrl Active-X, which is initialized

% Is the Camera Control figure already open?
if isfield(handles,'CamCtrl_figure_h');
    figure(handles.CamCtrl_figure_h');
    return;
end

% Open a figure for the Active-X Control
cc_fig = figure('Position',[90,90,188,252],'MenuBar','none','name', ...
                'Active-X Camera Control','tag','CamCtrl_ActiveX', ...
                'CloseRequestFcn','camctrl(''disconnect_Callback'',gcbo,[],guidata(gcbo))');

set(cc_fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
figure(cc_fig);

% Launch the Active-X control!
CamCtrl = actxcontrol('CAMCTRL.LVcamctrl.1', [0 0 186 252], cc_fig, ...
    {'CameraEvent' 'CamCtrl_CameraEvent'; 'CamCmdReply' 'CamCtrl_CamCmdReply'});

new_handles             = guihandles(cc_fig);
new_handles.camctrl     = handles.camctrl;
new_handles.CamCtrl_figure_h   = cc_fig;
guidata(cc_fig, handles);

% Update guidata with handles to control & new figure...
handles.CamCtrl_activeX_h = CamCtrl;
handles.CamCtrl_figure_h = cc_fig;
guidata(hObject, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END connect_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% acquire_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function acquire_Callback(hObject, eventdata, handles)
% This function will acuire image data from a connected camera
if (handles.CamCtrl_connected == 0)
    msgbox('Must connect first!','Error:');
    return;
end
%invoke(handles.CamCtrl_activeX_h,'DoCameraAction',8); 
setappdata(handles.camctrl,'sig',1);
% Acquire mode can be 'snapshot','live', or 'burst record'
acquireMode = get(handles.acquireMode,'value');
imageType   = get(handles.imageType,'value')-1;
switch(acquireMode)
    case 1
        % Snapshot
        set(handles.acquire,'Style','pushbutton');
        % Get single image
        img = invoke(handles.CamCtrl_activeX_h,'GetImage',imageType);    
        
        if img == -1
            disp('Error: Could not display image.');
            return;
        end
        handles = guidata(hObject);
        handles.imageData(:,:,str2num(get(handles.currentImage,'string'))) = img';
        guidata(hObject, handles);
        display_currentImage(hObject, eventdata, handles);
    case 2
        % Live image
        set(handles.acquire,'Style','togglebutton');
        setappdata(handles.camctrl,'sig',1);
        % Continue as long as button is pressed
        while (get(hObject, 'value')) & (getappdata(handles.camctrl,'sig'));
            img = invoke(handles.CamCtrl_activeX_h,'GetImage',imageType);    
            if img == -1
                disp('Error: Could not display image.');
                return;
            end
            handles = guidata(hObject);
            handles.imageData(:,:,str2num(get(handles.currentImage,'string'))) = img';
            guidata(hObject, handles);
            display_currentImage(hObject, eventdata, handles);
            pause(0.005);
        end
    case 3
        % Burst Record
        set(handles.acquire,'Style','pushbutton');
        prompt={'Enter number of frames to record:'};
        def={'20'};
        dlgTitle='Input for burst recording';
        lineNo=1;
        answer=inputdlg(prompt,dlgTitle,lineNo,def);
        
        if isempty(answer)
            return;
        end
        
        numToRecord = str2num(answer{1});
        
        % Get image size from camera
        size_x = invoke(handles.CamCtrl_activeX_h,'GetCameraProperty',66);
        size_y = invoke(handles.CamCtrl_activeX_h,'GetCameraProperty',67);  
        
        % Do burst recording
        handles = guidata(hObject);
        handles.imageData = reshape(invoke(handles.CamCtrl_activeX_h,'MLGetImages',imageType, size_x, size_y, numToRecord), ...
                                    size_x, size_y, numToRecord);    
 
        if handles.imageData == -1
            disp('Error: Could not acquire image.');
            return;
        end
        guidata(hObject, handles);
        
        % Update imageData info
        set(handles.numOfImages,'string',num2str(numToRecord));
        set(handles.currentImage,'string',num2str(numToRecord));
        display_currentImage(hObject, eventdata, handles);       
end
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END acquire_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% display_currentImage
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function display_currentImage(hObject, eventdata, handles)
% Image data is stored in handles.imageData
axes(handles.imageFrame);
fig = handles.camctrl;
%figure(handles.camctrl);
imagesc(squeeze(handles.imageData(:,:,str2num(get(handles.currentImage,'string')))));
colormap(handles.map);
axis image;
drawnow;
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END display_currentImage
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% acquireMode_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function acquireMode_Callback(hObject, eventdata, handles)
% The UIControl 'Acquire' will change style depending on AcquireMode

switch(get(hObject,'value'))
    case 1
        set(handles.acquire,'Style','pushbutton');
    case 2
        set(handles.acquire,'Style','togglebutton');
    case 3
        set(handles.acquire,'Style','pushbutton');
end
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END acquireMOde_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% currentImage_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function currentImage_Callback(hObject, eventdata, handles)
% User enters an image (frame) number

% Hints: get(hObject,'String') returns contents of currentImage as text
%        str2double(get(hObject,'String')) returns contents of currentImage as a double
currentMax   = str2num(get(handles.numOfImages,'string'));
currentImage = str2num(get(handles.currentImage,'string'));
if isempty(currentImage) | currentImage > currentMax | currentImage < 1
    set(handles.currentImage,'string','1');
end

display_currentImage(hObject, eventdata, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END currentImage_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% addImage_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function addImage_Callback(hObject, eventdata, handles)
% Will increase maximum number of images (frames) by one

currentMax = str2num(get(handles.numOfImages,'string'));
currentSize = size(handles.imageData(:,:,currentMax));
currentMax = currentMax + 1;
handles.imageData(:,:,currentMax) = zeros(currentSize);  % Empty matrix by default
guidata(hObject, handles);
set(handles.numOfImages,'string',num2str(currentMax));
set(handles.currentImage,'string',num2str(currentMax));

display_currentImage(hObject, eventdata, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END currentImage_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% deleteImage_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function deleteImage_Callback(hObject, eventdata, handles)
% Delete the currently selected image (frame)
currentMax = str2num(get(handles.numOfImages,'string'));
currentImage = str2num(get(handles.currentImage,'string'));

if currentMax > 1
    currentMax = currentMax - 1;
    handles.imageData(:,:,currentImage) = [];
else
    handles.imageData = [];
end
guidata(hObject, handles);

if currentImage > currentMax, currentImage = currentMax; end;
set(handles.numOfImages,'string',num2str(currentMax));
set(handles.currentImage,'string',num2str(currentImage));

display_currentImage(hObject, eventdata, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END deleteImage_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% imageDown_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function imageDown_Callback(hObject, eventdata, handles)
% Decrease currently selected image (frame)

currentImage = str2num(get(handles.currentImage,'string'));
if currentImage > 1
    currentImage = currentImage - 1;
end
set(handles.currentImage,'string',num2str(currentImage));

display_currentImage(hObject, eventdata, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END imageDown_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% imageUp_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function imageUp_Callback(hObject, eventdata, handles)
% Increase currently selected image (frame)

currentMax   = str2num(get(handles.numOfImages,'string'));
currentImage = str2num(get(handles.currentImage,'string'));

if currentImage < currentMax
    currentImage = currentImage + 1;
end

set(handles.currentImage,'string',num2str(currentImage));

display_currentImage(hObject, eventdata, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END imageUp_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% buildMovie_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function buildMovie_Callback(hObject, eventdata, handles)
% Create a movie from image data

currentMax   = str2num(get(handles.numOfImages,'string'));
currentImage = str2num(get(handles.currentImage,'string'));

if currentMax < 2
    msgbox('You must have at least two images to build a movie.','Error:');
    return;
end

for i = 1:currentMax
    set(handles.currentImage,'string',num2str(i));
    display_currentImage(hObject, eventdata, guidata(hObject));
    M(i) = getframe;
end

% Store the movie for later playback
handles = guidata(hObject);
handles.movie = M;
guidata(hObject, handles);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END buildMovie_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------->>>>>>>>>>
% playMovie_Callback
% ---------------------------------------------------------------------------------------->>>>>>>>>>
function playMovie_Callback(hObject, eventdata, handles)
% Play a pre-recorded movie

if ~isfield(handles,'movie')
    msgbox('You must build the movie before playing it.','Error:');
    return;
end

image_frame = handles.imageFrame;
axes(image_frame);
movie(image_frame, handles.movie,0);
% <<<<<<<<<<----------------------------------------------------------------------------------------
% END playMovie_Callback
% <<<<<<<<<<----------------------------------------------------------------------------------------

% --- Executes on button press in clearImages.
function clearImages_Callback(hObject, eventdata, handles)

handles.imageData = [];
guidata(hObject, handles);
set(handles.numOfImages,'string','1');
set(handles.currentImage,'string','1');


% --- Executes on button press in saveRawData.
function saveRawData_Callback(hObject, eventdata, handles)
I=handles.imageData;
[p,q,r]=size(I);
I(:,:,end)=[];
handles.imageData=I;
guidata(hObject, handles);
Current_Name=get(handles.addName,'String')
if isempty(Current_Name)
    msgbox('Cannot save.Please specify your name','No name is provided');
    return;
end
%Current_Name = [lower(Current_Name),'.mat']
dir_path = 'D:\MATLAB6p5\Project\Data\rawData';
dir_struct = dir(dir_path);
Name_List = {dir_struct.name}'
for i = 3:length(Name_List)
    if strcmp(lower(Name_List{i}),[lower(Current_Name),'.mat'])
        sig=1
        num=i;
        break
    else
        sig=0;
    end
end
if sig == 1
    msgbox('The name existed','warning');
    return;
else
    path=['D:\MATLAB6p5\Project\Data\rawData\', get(handles.addName,'String'), '.mat'];
    save (path,'I');
end

% --- Executes on button press in Recognition.
function Recognition_Callback(hObject, eventdata, handles)
setappdata(handles.camctrl,'sig',0);
if ~handles.CamCtrl_connected
    msgbox('Must be connected first!','Error:');
    return;
end
invoke(handles.CamCtrl_activeX_h,'DoCameraAction',8); 
pause(5);
imageType = get(handles.imageType,'value')-1;
nameList = get(handles.nameList,'String');
set(handles.displayResult,'string',[]);
initial_img1=zeros(240,320);
initial_img2=zeros(80,60);
axes(handles.imageFrame);
imagesc(initial_img1);
axes(handles.segmentedImage);
imagesc(initial_img2)%,colormap(gray),axis image;
axes(handles.retrieveImage);
imagesc(initial_img2)%,colormap(jet),axis image;
DB=handles.DB;
features=handles.features;
U=features(1).values;
E=features(2).values;
w=features(3).values;
w1=features(4).values;
w2=features(5).values;
%%%%%
bioFeatures=handles.bioFeatures;
UU=bioFeatures(1).values;
EE=bioFeatures(2).values;
ww=bioFeatures(3).values;
ww1=bioFeatures(4).values;
ww2=bioFeatures(5).values;
%%%%%
[p,q,r]=size(DB(1).Templates);
ni=r;
thresh=0.45;bigthresh = 0.6;
signature = 1;
badImages=0;badSegmentation = 0;
occlusions=0; notface =0;
count=0; maxNum=100;
topScore=0;
bestImage=[];
strong=0;middle=0;weak=0;
middleResults=[];
weakResults=[];
identification = 0;
while signature 
    I = invoke(handles.CamCtrl_activeX_h,'GetImage',imageType);  
    if I == -1
        msgbox('Error: Could not display image.');
        return;
    end
    keypress = get(handles.camctrl,'CurrentCharacter');
    if keypress == '0'
        set(handles.camctrl,'CurrentCharacter',' ');
        delete(hObject);
    end   
    I0=I';
    axes(handles.imageFrame);
    imagesc(I0),colormap(handles.map),axis image,drawnow;   
    [I,flag]=faceDetection(I0);
    if flag(1)==1
        occlusions = occlusions+1;
        if occlusions >= 10
            signature=0;
            msgbox('Your face cannot completely detected!','Occlusion occurs!');
            return
        end
        continue
    end
    if flag(2)==1
        badImages = badImages+1;
        if badImages >= 10
            signature=0;
            msgbox('Bad images are detected!','Bad images occurs!');
            return
        end
        continue
    end
    [sFeatures,tFeatures]=imageFeatures(I);
    objectFeatures=[sFeatures(3) tFeatures(3)]
    if sFeatures(1)< 3400
        badSegmentation = badSegmentation+1;
        if badSegmentation >=10
            msgbox('The face is not well segmented!','Segmentation error!');
            return
        end
        continue
    end
%     if (tFeatures(1)< 308) || (tFeatures(1)> 311) ...
%             ||(tFeatures(2)< 306.0) || (tFeatures(2)> 309)...
%             ||(tFeatures(3)< 0.35)|| (tFeatures(3)>1.0)...
%             ||(sFeatures(3)<0.73)||(sFeatures(2)>250)
%         notface = notface+1;
%         if notface >= 15
%             %signature=0;
%             msgbox('This is not a face!','Nonface detected!');
%             return
%         end
%         continue    
%     end
    bioI=bloodFlow(I);
    axes(handles.segmentedImage);
    imagesc(I),colormap(gray),axis image;
    [nameIndex11,nameIndex12,s11,s12,ratio1,flag1]=faceRecognition(I,U,E,w,w1,w2,thresh);
    [nameIndex21,nameIndex22,s21,s22,ratio2,flag2]=faceRecognition(bioI,UU,EE,ww,ww1,ww2,thresh);
    %%%
    pathname='D:\Data\rawImages';
    dir_struct = dir(pathname);
    n=length(dir_struct)-1;
    if log10(n)<1 
        filename=['t','00' int2str(n), '.mat'];
    elseif log10(n)>=1 & log10(n)<2
        filename=['t','0' int2str(n), '.mat']; 
    else
        filename=['t',int2str(n), '.mat']; 
    end
    File = fullfile(pathname,filename); 
    save(File,'I0');
    %%%%
    if s11>=bigthresh && abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
            abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
            abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
            abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
        nameIndex = nameIndex11;
        s1=s11;s2=s12;
        identification = 1;
        strong=1;
        known=1
        break
    end
    if s21>=bigthresh && abs(sFeatures(3)>=min(DB(nameIndex21).shapeFeatures(3,:)))&&...
            abs(sFeatures(3)<=max(DB(nameIndex21).shapeFeatures(3,:)))&&...
            abs(tFeatures(3)<=max(DB(nameIndex21).thermalFeatures(3,:)))&&...
            abs(tFeatures(3)>=min(DB(nameIndex21).thermalFeatures(3,:)))
        nameIndex = nameIndex21;
        s1=s21;s2=s22;
        identification = 1;
        strong=1;
        known=2
        break
    end
    if flag1 == 1 && flag2 == 1 && nameIndex11==nameIndex21
        if abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
            identification = 1;
            nameIndex = nameIndex11;
            s1=s11;s2=s12;
            strong=1;
            known=3
            break
        else
            nameIndex = nameIndex11;
            s1=s11;s2=s12;
            identification = 1;
        end
    elseif flag1 == 1 && flag2 == 1 && nameIndex11~=nameIndex21
        if abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
            identification = 1;
            nameIndex = nameIndex11;
            s1=s11;s2=s12;
            middle=1;
            
            if isempty(middleResults)
                middleResults =[middleResults;[nameIndex s1 1]];
            else
                namefind=find(middleResults(:,1)==nameIndex);
                if isempty(namefind)
                    middleResults =[middleResults;[nameIndex s1 1]];
                else
                    middleResults(namefind,2)= max(middleResults(namefind,2),s1);
                    middleResults(namefind,3)= middleResults(namefind,3)+1;
                end
            end
            known=4
        elseif abs(sFeatures(3)>=min(DB(nameIndex21).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex21).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex21).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex21).thermalFeatures(3,:)))
            identification = 1;
            nameIndex = nameIndex21;
            s1=s21;s2=s22;
            weak=1;
            if isempty(weakResults)
                weakResults =[weakResults;[nameIndex s1 1]];
            else
                namefind=find(weakResults(:,1)==nameIndex);
                if isempty(namefind)
                    weakResults =[weakResults;[nameIndex s1 1]];
                else
                    weakResults(namefind,2)= max(weakResults(namefind,2),s1);
                    weakResults(namefind,3)= weakResults(namefind,3)+1;
                end
            end
            known=5                        
        else
            unknown=2;
            nameIndex = nameIndex11;
            s1=s11;s2=s12;  
            identification = 0;                      
        end
    elseif flag1 == 1 || flag2 == 1 
        if nameIndex11==nameIndex21 && abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
            identification = 1;
            nameIndex = nameIndex21;
            s1=s11;s2=s12;
            middle=1;
            if isempty(middleResults)
                middleResults =[middleResults;[nameIndex s1 1]];
            else
                namefind=find(middleResults(:,1)==nameIndex);
                if isempty(namefind)
                    middleResults =[middleResults;[nameIndex s1 1]];
                else
                    middleResults(namefind,2)= max(middleResults(namefind,2),s1);
                    middleResults(namefind,3)= middleResults(namefind,3)+1;
                end
            end
            known=6
        else
            if s11>s21
                s1=s11;s2=s12;
                nameIndex1 = nameIndex11;nameIndex2 = nameIndex12;
            else
                s1=s21;s2=s22;
                nameIndex1 = nameIndex21;nameIndex2 = nameIndex22;
            end
            if abs(sFeatures(3)>=min(DB(nameIndex1).shapeFeatures(3,:)))&&...
                    abs(sFeatures(3)<=max(DB(nameIndex1).shapeFeatures(3,:)))&&...
                    abs(tFeatures(3)<=max(DB(nameIndex1).thermalFeatures(3,:)))&&...
                    abs(tFeatures(3)>=min(DB(nameIndex1).thermalFeatures(3,:)))
                identification = 1;
                nameIndex = nameIndex1;
                weak=1;
                if isempty(weakResults)
                    weakResults =[weakResults;[nameIndex s1 1]];
                else
                    namefind=find(weakResults(:,1)==nameIndex);
                    if isempty(namefind)
                        weakResults =[weakResults;[nameIndex s1 1]];
                    else
                        weakResults(namefind,2)= max(weakResults(namefind,2),s1);
                        weakResults(namefind,3)= weakResults(namefind,3)+1;
                    end
                end
                known=7
               
            else
                unknown=3;
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
                identification = 0;
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
            end             
        end
    else
        if s11>s21
            s1=s11;s2=s12;
            nameIndex = nameIndex11;%nameIndex2 = nameIndex12;
        else
            s1=s21;s2=s22;
            nameIndex = nameIndex21;%nameIndex2 = nameIndex22;
        end
        unknown=4;
        nameIndex = nameIndex11;
        s1=s11;s2=s12;
        identification = 0;
    end
    %set(handles.personNum,'string',nameList{nameIndex});
    %set(handles.score1Value,'string',num2str(s1));
    %set(handles.score2Value,'string',num2str(s2));   
    count=count+1;  
    badImages=0;
    badSegmentation = 0;
    occlusions=0;
    notface =0;
    if s1>topScore
        bestImage = I;
        topScore=s1;
    end
    if count > maxNum
        break
    end
end
TestmiddleResults=middleResults
TestweakResults=weakResults
if  strong==1
    set(handles.displayResult,'string',['welcome ' nameList{nameIndex} '!']);
    set(handles.score1Value,'string',num2str(s1));
    set(handles.score2Value,'string',num2str(s2));
    axes(handles.retrieveImage);
    imagesc(DB(nameIndex).Templates(:,:,1)),colormap(gray),axis image;
elseif middle==1 && size(middleResults,1)==1
    nameIndex = middleResults(1);
    s1= middleResults(2);
    set(handles.displayResult,'string',['You may be ' nameList{nameIndex}]);
    set(handles.score1Value,'string',num2str(s1));
    set(handles.score2Value,'string',num2str(s2));
elseif middle==1 && size(middleResults,1)>1
    [v1,scorePosition]=max(middleResults(:,2));
    [v1,numberPosition]=max(middleResults(:,3));
    nameIndex = middleResults(numberPosition,1);
    s1= middleResults(numberPosition,2);
    set(handles.displayResult,'string',['Are you  ' nameList{nameIndex} '?']);
    set(handles.score1Value,'string',num2str(s1));
    set(handles.score2Value,'string',num2str(s2));
elseif weak ==1 && size(weakResults,1)==1
    nameIndex = weakResults(1);
    s1= weakResults(2);
    set(handles.displayResult,'string',['Are you ' nameList{nameIndex} '?']);
    set(handles.score1Value,'string',num2str(s1));
    set(handles.score2Value,'string',num2str(s2));
elseif weak ==1 && size(weakResults,1)>1
    [v1,numberPosition]=max(weakResults(:,3));
    nameIndex = weakResults(numberPosition,1);
    s1= weakResults(numberPosition,2);
    set(handles.displayResult,'string',['Are you  ' nameList{nameIndex} '?']);
    set(handles.score1Value,'string',num2str(s1));
    set(handles.score2Value,'string',num2str(s2));
else
    set(handles.displayResult,'string','You are not identified');
end
%guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function addName_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function addName_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of addName as text
%        str2double(get(hObject,'String')) returns contents of addName as a double

%nameList=get(handles.nameList,'string');
%nameList(end+1)={get(handles.addName,'string')};
%set(handles.nameList,'string',nameList);

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%delete(hObject);
closereq

% --- Executes on button press in trainDB.
function trainDB_Callback(hObject, eventdata, handles)
% hObject    handle to trainDB (see GCBO)
msgbox('The training starts,please wait!','Training processing');
DB=handles.DB;
data={DB.Templates};
%pose_data=[data];
[p,q,r]=size(data{1});
%tempData=zeros(p*q,r*length(data));
tempData=repmat(zeros,p*q,r*length(data));
bioData=repmat(zeros,p*q,r*length(data));
for i=1:length(data)
    a=data{i};
    aa=bloodFlow(a);
    tempData(:,r*(i-1)+1:r*i)=reshape(a,p*q,r);
    bioData(:,r*(i-1)+1:r*i)=reshape(aa,p*q,r);
end
[eigenFeatures,U]=eigen_train(tempData);
[FF,E]=fisher_train(eigenFeatures,length(data),r);
[width,w1,w2]=RBF_train(FF,length(data),r);
features=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{U,E,width,w1,w2});
handles.features=features;
%handles.eigenFeatures=eigenFeatures;
save ('D:\MATLAB6p5\Project\Data\features.mat','features');
%save ('D:\MATLAB6p5\Project\Data\pose_templates.mat','pose_data');
[eigenFeatures,U]=eigen_train(bioData);
[FF,E]=fisher_train(eigenFeatures,length(data),r);
[width,w1,w2]=RBF_train(FF,length(data),r);
features=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{U,E,width,w1,w2});
% handles.bioFeatures=features;
% handles.bioEigenFeatures=eigenFeatures;
guidata(hObject, handles);
save ('D:\MATLAB6p5\Project\Data\bioFeatures.mat','features');
%save ('D:\MATLAB6p5\Project\Data\bioEigenData.mat','eigenFeatures');
msgbox('Training has been finished!','Message:');
% --- Executes on button press in Segmentation.
function Segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.imageData;
[p,q,r]=size(I);
if r>10
    I=I(:,:,1:10);
end
[SI,flag]=segmentTemplates(I);
if size(SI,3) < 10
    msgbox('Some images cannot be segmented!','Error:');
else
    handles.segmentedData=SI;
    guidata(hObject, handles);
    axes(handles.segmentedImage)
    for i=1:10
        %h=imagesc(I(:,:,1),'EraseMode','none');
        %set(hObject,'CData',(I(:,:,i)'));
        %imagesc(SI(:,:,i));colormap(handles.map);
        imshow(mat2gray(SI(:,:,i)))
        axis image;
        drawnow 
        pause(1.5)
    end
end
msgbox('Finish collecting templates. Please save templates!','Message:');
% --- Executes on button press in saveDatabase.
function saveDatabase_Callback(hObject, eventdata, handles)
newData = handles.segmentedData;
[SF,thermF,AH,RM,CM]=imageFeatures(newData);
DB = handles.DB;
if ~isequal(size(DB(1).Templates),size(newData))
    msgbox('The smaple No. is incorrect','Error!');
    return;
end
Current_Name=get(handles.addName,'String');
if isempty(Current_Name)
    msgbox('Please specify the registered name','No name is provided');
    return;
end
Name_List = {DB.Name};
% Determine if the current name matches an existing name in DB
for i = 1:length(Name_List)
    if strcmp(lower(Name_List{i}),lower(Current_Name))
        sig=1;
        num=i;
        break
    else
        sig=0;
    end
end
if sig == 1
    msgbox('The name existed','warning');
    return;
else
    DB(end+1).Name = Current_Name; 
    DB(end).Templates = newData;
    DB(end).shapeFeatures = SF;
    DB(end).thermalFeatures = thermF;
    DB(end).accumulatedHist = AH;
    DB(end).xProjections = RM;
    DB(end).yProjections = CM;
    handles.DB = DB;
    guidata(hObject,handles);
    save ('D:\MATLAB6p5\Project\Data\dataBase.mat','DB');
    set(handles.nameList,'string',{DB.Name});
    set(handles.registeredNo,'string',length(DB));
    path=['D:\MATLAB6p5\Project\Data\Normalized data\', get(handles.addName,'String'), '.mat'];
    save (path,'newData');
    msgbox('You need train the database again','Reminder');
end

% --- Executes during object creation, after setting all properties.
function nameList_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in nameList.
function nameList_Callback(hObject, eventdata, handles)

% Hints: contents = get(hObject,'String') returns nameList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nameList

if strcmp(get(handles.camctrl,'SelectionType'),'open') 
    Answer=questdlg('Do you want to delete the name and its data?', ...
        'Change templates', ...
        'Yes','No','No');	
    switch Answer
        case 'Yes'
            DB = handles.DB;
            index = get(handles.nameList,'Value')
            DB(index)=[];
            set(handles.nameList,'Value',[])
            handles.DB = DB;
            guidata(hObject,handles);
            save ('D:\MATLAB6p5\Project\Data\dataBase.mat','DB');
            set(handles.nameList,'string',{DB.Name});
            set(handles.registeredNo,'string',length(DB));
            return		
        case 'No'
            return 
    end			
end  


% --- Executes during object creation, after setting all properties.
function displayResult_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function displayResult_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of displayResult as text
%        str2double(get(hObject,'String')) returns contents of displayResult as a double


% --- Executes when user attempts to close camctrl.
function camctrl_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to camctrl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%delete(hObject);


