clear all
%%% Obtain the time-lapse data from folder office_1_shiqian 
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
A=zeros(80,60,110);
for i=1:110
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if (~isa(I,'double'))
        I=double(I);
    end
    A(:,:,i)=faceDetection(I);   
end
B=A(:,:,3:15);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data11.mat','B');
B=A(:,:,68:77);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data12.mat','B');
B=A(:,:,85:90);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data13.mat','B');
B=A(:,:,101:110);
save('F:\My Papers\SMC_2005\shiqian_time_lapse_data14.mat','B');
disp('Finished')