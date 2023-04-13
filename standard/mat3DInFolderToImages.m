clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file')
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);    
end
[path,name,ext,ver] = fileparts(filename)
data=load(File);
fld=fieldnames(data);
I=getfield(data,fld{1});
[p,q,r]= size(I);
for i=1:12
    a=I(:,:,i);
    if ~isa(a,'double')
        a=double(a);
    end
    a=mat2gray(a);   
    if log10(i)<1 
        savename=['E:\A40\images\',name,'_000' int2str(i), '.bmp'];
    elseif log10(i)>=1 & log10(i)<2
        savename=['E:\A40\images\',name '_00' int2str(i), '.bmp']; 
    elseif log10(i)>=2 & log10(i)<3
        savename=['E:\A40\images\',name '_0' int2str(i), '.bmp']; 
    else
        savename=['E:\A40\images\',name '_' int2str(i), '.bmp']; 
    end
    %figure,imshow(a)
    %keyboard
    imwrite(a,savename);
end
