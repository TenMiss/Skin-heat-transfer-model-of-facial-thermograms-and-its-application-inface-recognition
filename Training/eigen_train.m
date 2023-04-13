function [P,U]=eigen_train(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%          This program is used for eigenfeature extraction
%
%  Input:  I may be 2D dimension or 3D dimension.  
%          
%  Output: P is the transformed matrix whose zise is (n-1)*n
%          U is the eigen transformation whose zise is m2*(n-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p,q,r]=size(I);
if r >= 2
    I=reshape(I,p*q,r);
    n=r;
else
    n=q;
end
F = I - mean(I,2) * ones(1,n);
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