[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);    
end
data=load(File);
fld=fieldnames(data);
I=getfield(data,fld{1});