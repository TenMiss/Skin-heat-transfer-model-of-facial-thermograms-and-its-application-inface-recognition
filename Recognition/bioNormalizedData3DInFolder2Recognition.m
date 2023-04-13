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
sorted_names(1:2)=[]; 
[n,m]=size(sorted_names);
threshold = 0.6;
F=repmat(zeros,[80 60 10*n]);
T=repmat(zeros,[80 60 10*n]);
bioF=repmat(zeros,[80 60 10*n]);
bioT=repmat(zeros,[80 60 10*n]);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    I=I(:,:,1:20);
    if (~isa(I,'double'))
        I=double(I);
    end
    bioI=bloodFlow(I);
    F(:,:,(i-1)*10+1:i*10)=I(:,:,1:10);
    T(:,:,(i-1)*10+1:i*10)=I(:,:,11:20);
    bioF(:,:,(i-1)*10+1:i*10)=bioI(:,:,1:10);
    bioT(:,:,(i-1)*10+1:i*10)=bioI(:,:,11:20);
end
F=reshape(F,4800,10*n);
[eigenFeatures,U]=eigen_train(F);
[FF,E]=fisher_train(eigenFeatures,n,10);
[w,w1,w2]=RBF_train(FF,n,10);
for i=1:10*n
    A0=T(:,:,i);
    [name,n,score1,score2,ratio,sig]=faceRecognition(A0,U,E,w,w1,w2,threshold)
    results1(i,:)=[name,n,score1,score2,ratio];
    %keyboard
end

F=reshape(bioF,4800,10*n);
[eigenFeatures,U]=eigen_train(F);
[FF,E]=fisher_train(eigenFeatures,n,10);
[w,w1,w2]=RBF_train(FF,n,10);
for i=1:10*n
    A0=bioT(:,:,i);
    [name,n,score1,score2,ratio,sig]=faceRecognition(A0,U,E,w,w1,w2,threshold)
    results2(i,:)=[name,n,score1,score2,ratio];
end
results = [results1 results2]
disp('finished testing')
