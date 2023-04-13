%clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file')
if isequal([filename,pathname],[0,0])
    return
end
dir_struct = dir(pathname);
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
a=[dir_struct.isdir];
a(1:2)=[];             %%% Delete the dot dir
sorted_names(1:2)=[]; 
[n,m]=size(sorted_names);
%vvalue=repmat(zeros,n,2);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    a=getfield(data,fld{1});
    if (~isa(a,'double'))
        a=double(a);
    end
    [p,q,r]=size(a);
    for j=1:r
        figure,imshow(mat2gray(a(:,:,j)));
        %imshow(mat2gray(a(:,:,j)));
    end
    keyboard
end
