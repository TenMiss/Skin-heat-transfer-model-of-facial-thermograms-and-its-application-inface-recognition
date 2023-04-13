function [P,E]=fisher_train(X,c,ni)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          This program is used for fisher face extraction
%
%  Input:  X is a matrix (n-1)*n where n is the number of total template images 
%          
%          There are totally c persons, and each person has ni templates.
%
%  Output: P is the transformed matrix whose zise is (c-1)*n
%          E is the fisher transformation whose zise is (n-1)*(c-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin~=3
    errordlg('Please define 3 inputing parameters','Fisher_train file')
    return
end
[r, n]=size(X);
XT = X';
mx_tot = mean(XT)';
for i=1:c    %Find the mean image of each class
   Xi = X(:,ni*(i-1)+1:ni*i);
   XiT = Xi';
   MXi(:,i)= mean(XiT)'; 
end
FXB = MXi - mx_tot* ones(1,c);
SB =ni*FXB*FXB';
for i=1:c
   M(:,ni*(i-1)+1:ni*i)=MXi(:,i)*ones(1,ni);
end
SW = (X-M)*(X-M)';
ST=(X-mx_tot* ones(1,n))*(X-mx_tot* ones(1,n))';
[U,S,V]=svd(SW);
rk=rank(SW);
Q=U;
Q(:,1:rk)=[];
SBnew=Q*Q'*SB*(Q*Q')';
[E1,EV1,E2]=svd(SBnew);
sig2=isreal(E1); 
if(sig2==0) 
   E1=real(E1);
   EV1=real(EV1);
end 
EV = sum(EV1);
rk1=rank(EV1);
for i=1:rk1   
   [max_value,coln]=max(EV);
   E(:,i)=E1(:,coln);
   EV(:,coln)=0;
end
P= E'*X;     % P is a (c-1)*n matrix
