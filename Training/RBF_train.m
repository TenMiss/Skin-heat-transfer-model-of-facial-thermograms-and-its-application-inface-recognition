function [wid,w1,w2]=RBF_train(P,c,ni)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          This program is used for RBF neural classifier
%
%  Input:  P is a matrix whose size is (c-1)*n where n is the number of total
%          template images. 
%          
%          There are totally c persons, and each person has ni templates.
%
%  Output: wid  is the width which is a vector of size c
%          w1 is a matrix which represents the RBF centre whose zise is c*(c-1).
%             Each row of the w1 is a centre of an RBF node.
%          w2 is the weight matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin~=3
    errordlg('Please define 3 inputing parameters','RBF_train file')
    return
end
% Target matrix t 
t=zeros(c,ni*c);
for i=1:c
   t(i,ni*(i-1)+1:ni*i)=1;
end
[r,q]=size(P);
[s,q]=size(t); 
% finding the optimal center
for n=1:s   
   pp=P(:,ni*(n-1)+1:ni*n);
   pt=pp';
   w1(n,:)=sum(pt)/ni;
   CRBF=w1';
end
% Find the distances between clusters
[u,r]=size(w1);
for i=1:u
   d1=dist(w1,w1(i,:)');
   d1(i)=inf;
   [d3,ind]=min(d1);
   nearno(i)=ind;
   distance(i)=d3;
   d_bet(:,i)=d1;
end
wid=1.5*distance;
% determine the weights 
zs0=dist(w1,P)./(wid'*ones(1,q));
a=radbas(zs0);
w2=t/a;