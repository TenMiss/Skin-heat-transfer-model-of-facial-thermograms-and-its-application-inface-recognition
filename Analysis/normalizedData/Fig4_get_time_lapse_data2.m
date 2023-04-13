clear all
%%% Obtain the time-lapse data from folder "E:\A40\testData\office" 
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
end
dir_struct = dir(pathname);
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
a=[dir_struct.isdir];
a(1:2)=[];            
sorted_names(1:2)=[]; 
[n,m]=size(sorted_names);
A=zeros(80,60,n);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if (~isa(I,'double'))
        I=double(I);
    end
    A(:,:,i)=faceDetection(I);   
end
B=A(:,:,6:15);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data21.mat','B');
B=A(:,:,25:33);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data22.mat','B');
