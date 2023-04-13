clear all
load('D:\MATLAB6p5\Project\Data\features.mat');
U=features(1).values;
E=features(2).values;
w=features(3).values;
w1=features(4).values;
w2=features(5).values;
%load('D:\MATLAB6p5\Project\Data\testData\results\results.mat');
data=load('D:\MATLAB6p5\Project\Data\testData.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
[p,q,r]=size(I);
for i=2:r
    A0=I(:,:,i);
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
% load('D:\MATLAB6p5\Project\Data\bioFeatures.mat');
% U=features(1).values;
% E=features(2).values;
% w=features(3).values;
% w1=features(4).values;
% w2=features(5).values;
% for i=2:length(dir_struct)
%     A0=fullfile(pathname,sorted_names{i});
%     A=A0(:);
%     [u,v]=size(A);
%     TFF=E'*U'*A;
%     zs0=dist(w1,TFF)./(w'*ones(1,v));
%     a0=radbas(zs0);
%     a0=w2*a0;
%     [value,n]=max(a0);
%     a0(n)=0;
%     [value1,n1]=max(a0);
%     results2(i,:)=[n,value,value1,value/value1];
% end
% results=[results2 results1];
disp('finished')
