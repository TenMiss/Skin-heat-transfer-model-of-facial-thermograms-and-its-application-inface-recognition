function [P,U,E,wid,w1,w2]=total_train(varargin)
load('c:\cap_tomodify\Matlab\template.mat')
tic
c=varargin{1};
ni=varargin{2};
[r,s,n]=size(I);
I=reshape(I,r*s,n);
ZT = I';
average_z=mean(ZT)'; 
F = I - average_z * ones(1,n);
cov = F'*F;
[FV1,D1] = eig(cov); % FV - eigen vectors
D2 = sum(D1);
D = D2.*D2;
for i=1:(n-1)  
   [max_value,column]=max(D);
   FV(:,i)=FV1(:,column);
   D(:,column)=0;
end
U0 = F*FV; % U is a m2 * (n-1) matrix.
for i=1:(n-1)
   U1(i)=sum(U0(:,i).*U0(:,i));
   U2(i)=sqrt(U1(i));
   U(:,i)=U0(:,i)./U2(i);
end
P=U'*I;  %P is a (n-1)*n matrix
save('C:\cap_tomodify\Matlab\DataBase\U_feature.mat','U');
save('C:\cap_tomodify\Matlab\DataBase\P_feature.mat','P');
[ZZ,E]=fisher_train(P,c,ni);
[wid,w1,w2]=RBF_train(ZZ,c,ni);
save('C:\cap_tomodify\Matlab\DataBase\E_feature.mat','E');
save('C:\cap_tomodify\Matlab\DataBase\wid_feature.mat','wid');
save('C:\cap_tomodify\Matlab\DataBase\w1_feature.mat','w1');
save('C:\cap_tomodify\Matlab\DataBase\w2_feature.mat','w2');
time=toc