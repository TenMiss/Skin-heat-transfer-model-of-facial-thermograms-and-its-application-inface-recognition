function [U,E,wid,w1,w2]=increment_train(c,ni)
load('c:\cap_tomodify\Matlab\template.mat')
load('C:\cap_tomodify\Matlab\DataBase\P_feature.mat','P');
load('C:\cap_tomodify\Matlab\DataBase\U_feature.mat','U');
[r,s,t]=size(I);
I1=zeros(r*s,t);
for i=1:t
    a=I(:,:,i);
    a=reshape(a,r*s,1);
    I1(:,i)=a;
end    
P=U'*I1;  %P is a (n-1)*n matrix
save('C:\cap_tomodify\Matlab\DataBase\P_feature.mat','P');
[ZZ,E]=fisher_train(P,c,ni);
[wid,w1,w2]=RBF_train(ZZ,c,ni);
save('C:\cap_tomodify\Matlab\DataBase\E_feature.mat','E');
save('C:\cap_tomodify\Matlab\DataBase\wid_feature.mat','wid');
save('C:\cap_tomodify\Matlab\DataBase\w1_feature.mat','w1');
save('C:\cap_tomodify\Matlab\DataBase\w2_feature.mat','w2');