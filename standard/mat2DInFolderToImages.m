clear
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file')
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);    
end
[path,name,ext,ver] = fileparts(filename)

dir_struct = dir(pathname)
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
sorted_names(1:2)=[]; 
n=length(sorted_names);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if ~isa(I,'double')
        I=double(I);
    end
    a=mat2gray(I);   
    if log10(i)<1 
        savename=['E:\A40\images\','000' int2str(i), '.bmp'];
    elseif log10(i)>=1 & log10(i)<2
        savename=['E:\A40\images\','00' int2str(i), '.bmp']; 
    elseif log10(i)>=2 & log10(i)<3
        savename=['E:\A40\images\','0' int2str(i), '.bmp']; 
    else
        savename=['E:\A40\images\',int2str(i), '.bmp']; 
    end
    imwrite(a,savename);
end
