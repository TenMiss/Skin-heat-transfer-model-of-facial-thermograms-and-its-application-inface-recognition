
c=42;
ni=10;
P=FF;
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