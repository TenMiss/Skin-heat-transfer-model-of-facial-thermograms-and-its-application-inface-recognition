clear all
close all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);    
end
[path,name,ext,ver] = fileparts(filename);
data=load(File);
fld=fieldnames(data);
I=getfield(data,fld{1});
[p,q,r]= size(I);
for i=1:r
    a=I(:,:,i);
    if ~isa(a,'double')
        a=double(a);
    end
    n=find(a(:)<1);
    a(n)=297;
    a=mat2gray(a); 
    figure,imshow(a)
end
