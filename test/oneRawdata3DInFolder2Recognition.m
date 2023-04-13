clear all
load('J:\Matlab_Programs\Project\Data\dataBase.mat');
%load('F:\Matlab_Programs\Project\Data\dataBase.mat');
data={DB.Templates};
[p,q,r]=size(data{1});
%tempData=zeros(p*q,r*length(data));
tempData=repmat(zeros,p*q,r*length(data));
bioData=repmat(zeros,p*q,r*length(data));
for i=1:length(data)
    a=data{i};
    aa=bloodFlow(a);
    tempData(:,r*(i-1)+1:r*i)=reshape(a,p*q,r);
    bioData(:,r*(i-1)+1:r*i)=reshape(aa,p*q,r);
end
[eigenFeatures,U]=eigen_train(tempData);
[FF,E]=fisher_train(eigenFeatures,length(data),r);
[width,w1,w2]=RBF_train(FF,length(data),r);
[eigenFeatures,bioU]=eigen_train(bioData);
[FF,bioE]=fisher_train(eigenFeatures,length(data),r);
[biowidth,biow1,biow2]=RBF_train(FF,length(data),r);

threshold = 0.15;
results=[];
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
if (~isa(I,'double'))
    I=double(I);
end
if p==240 && q==320
    I=faceDetection(I);
elseif p~=80 && q~=60
    msgbox('The data size is incorrect!','Error:');
    return
end
[p,q,r]=size(I);
bioI=bloodFlow(I);
[name11,n12,score11,score12,ratio1,sig1]=faceRecognition(I,U,E,width,w1,w2,threshold);
[name21,n22,score21,score22,ratio2,sig2]=faceRecognition(bioI,bioU,bioE,biowidth,biow1,biow2,threshold);
sampleSeries=1:r;
results=[results;[sampleSeries',name11,name21,score11,score21]]
disp('finished testing')
