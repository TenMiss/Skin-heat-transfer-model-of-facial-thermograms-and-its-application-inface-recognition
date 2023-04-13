clear all
%%%%%%%%%%%%%% Recognition and decision making %%%%%%%%%%%%%%%%%%
%
%%%%% Define parameters:
ni=10;
c=40;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
disp('Start to extract eigen features')
load('E:\template.mat') %,'I1)
[u,v,w]=size(I);
Z=reshape(I,u*v,w);

[EF,U]=eigen_train(Z);
EF0=EF;
save('C:\Temp\U_feature.mat','U');
save('C:\Temp\eigen_feature.mat','EF');
[FF,E]=fisher_train(EF,c,ni);
save('C:\Temp\E_feature.mat','E');
[width,w1,w2]=RBF_train(FF,c,ni);
save('C:\Temp\width_feature.mat','width');
save('C:\Temp\w1_feature.mat','w1');
save('C:\Temp\w2_feature.mat','w2');
time=toc
%%%%%%%%%%  Testing

%[name,score]=recognition('D:\Q.bmp',c,ni) %,'I1)
