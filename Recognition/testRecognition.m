clear all
load('D:\MATLAB6p5\Project\Data\features.mat');
U=features(1).values;
E=features(2).values;
w=features(3).values;
w1=features(4).values;
w2=features(5).values;
pathname='D:\MATLAB6p5\Project\Data\testData\rawImages';
dir_struct = dir(pathname);
[sorted_names,sorted_index]=sortrows({dir_struct.name}');

for i=3:length(dir_struct)
    file=fullfile(pathname,sorted_names{i});
    data=load(file);
    fld=fieldnames(data);
    A0=getfield(data,fld{1});
    A0=double(A0);
    A0=faceDetection(A0);
    A=A0(:);
    [u,v]=size(A);
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,v));
    a0=radbas(zs0);
    a0=w2*a0;
    [value,n]=max(a0);
    a0(n)=0;
    [value1,n1]=max(a0);
%     [nameIndex,s1,s2,flag]=faceRecognition(A0,r/ni,...
%         ni,U,E,w,w1,w2,[threshold1, threshold2]);
    results1(i,:)=[n,value,value1,value/value1];
    %keyboard
end
load('D:\MATLAB6p5\Project\Data\bioFeatures.mat');
U=features(1).values;
E=features(2).values;
w=features(3).values;
w1=features(4).values;
w2=features(5).values;
for i=3:length(dir_struct)
    file=fullfile(pathname,sorted_names{i});
    data=load(file);
    fld=fieldnames(data);
    A0=getfield(data,fld{1});
    A0=double(A0);
    A0=faceDetection(A0);
    A0=bloodFlow(A0);
    A=A0(:);
    [u,v]=size(A);
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,v));
    a0=radbas(zs0);
    a0=w2*a0
    [value,n]=max(a0);
    a0(n)=0;
    [value1,n1]=max(a0);
    results2(i,:)=[n,value,value1,value/value1];
    %keyboard
end
results=[results2 results1];
disp('finished')
