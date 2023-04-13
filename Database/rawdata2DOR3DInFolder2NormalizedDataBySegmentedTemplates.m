clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
end
dir_struct = dir(pathname);
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
a=[dir_struct.isdir];
a(1:2)=[];             %%% Delete the dot dir
sorted_names(1:2)=[]
[n,m]=size(sorted_names);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    [p,q,r]=size(I);
    if (~isa(I,'double'))
        I=double(I);
    end
    F=repmat(zeros,[80,60,r]);
    for j =1:20
        a=I(:,:,j);
        b=segmentTemplates(a);
        F(:,:,j)=b;
        %figure,imshow(b);
    end
    %newpathname=['P:\Project\A40\NormalizedDatabaseNoBackground\' sorted_names{i}];
    newpathname=['D:\MATLAB6p5\Project\Data\Normalized data\' sorted_names{i}]
    save(newpathname,'F');
end
disp('finish')