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
F=repmat(zeros,[80 60 10*n]);
bioF=repmat(zeros,[80 60 10*n]);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    I=I(:,:,1:10);
    if (~isa(I,'double'))
        I=double(I);
    end
    bioI=bloodFlow(I);
    F(:,:,(i-1)*10+1:i*10)=I;
    bioF(:,:,(i-1)*10+1:i*10)=bioI;
end
F=reshape(F,4800,10*n);
[eigenFeatures,U]=eigen_train(F);
[FF,E]=fisher_train(eigenFeatures,n,10);
[width,w1,w2]=RBF_train(FF,n,10);
features=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{U,E,width,w1,w2});
%save ('P:\Project\A40\features\features.mat','features');
save ('D:\MATLAB6p5\Project\Data\features.mat','features');

F=reshape(bioF,4800,10*n);
[eigenFeatures,U]=eigen_train(F);
[FF,E]=fisher_train(eigenFeatures,n,10);
[width,w1,w2]=RBF_train(FF,n,10);
bioFeatures=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{U,E,width,w1,w2});

%save ('P:\Project\A40\features\bioFeatures.mat','bioFeatures');
save ('D:\MATLAB6p5\Project\Data\bioFeatures.mat','bioFeatures');

disp('finished training')
