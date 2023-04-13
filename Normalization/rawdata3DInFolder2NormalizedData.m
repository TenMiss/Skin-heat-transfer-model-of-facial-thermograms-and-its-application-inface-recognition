clear all
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
[p,q,r]= size(I);
% if (~isa(I,'double'))
%     I=double(I);
% end
F=repmat(zeros,[80,60,r]);
for i=1:r
    a=I(:,:,i);
    b=faceDetection(a);
    %[b,signature]=segmentTemplates(a);
    F(:,:,i)=b;
    %figure,imshow(b);
end
pathname=['D:\MATLAB6p5\Project\Data\Normalized data\' filename];
        
save(pathname,'F')