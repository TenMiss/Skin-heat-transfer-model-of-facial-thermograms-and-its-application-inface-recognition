function [name,score1,score2,score1/score2,sig]=faceRecognition_new(I,c,ni,U,E,w,w1,w2,threshold)
%                              This is face recognition program
% Inputs:
%        I--input p * q * r image matrix
%        c--No of registered persons
%        ni--No of templates for each person
%        U, E, w, w1, w2-- trained eigen, fisher, width,and w1, w2 parameters
%        threshold is a 2-element vector,the first one is used for absolute
%                  similarity comparison, while the second is used for relative comparison
% Outputs:
%        name--the name corresponding to max similarity value
%        score1, score2--the max and 2nd max similarity values
%        sig -- indicates whether the person is identified
% Last update: 15 August 2003
% $Revision: 2.3 $  $Date: 11 Oct 2004 9:45:15 $
%
[p,q,r]=size(I);
for i=1:r 
    A0=I(:,:,i);
    A=A0(:);
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
    a0=radbas(zs0);
    a0=w2*a0;
    [value0,refer]=max(a0);
    a0(refer)=0;
    [value01,refer01]=max(a0);
    AC=A0(:);
    AL=[zeros(p,1) A0];
    AL(:,end)=[];
    AL1=AL(:);
    AL=[zeros(p,1) AL];
    AL(:,end)=[];
    AL2=AL(:);
    AR=[A0 zeros(p,1)];
    AR(:,1)=[];
    AR1=AR(:);
    AR=[AR zeros(p,1)];
    AR(:,1)=[];
    AR2=AR(:);
    ARL=[AC,AL1,AL2,AR1,AR2];
    TFF=E'*U'*ARL;
    zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
    a0=radbas(zs0);
    a0=w2*a0;
    [value,n]=max(a0(refer,:));
    A=ARL(:,n);
    A0=reshape(A,p,q);
    AC=A0(:);
    AUP=[zeros(1,q);A0];
    AUP(end,:)=[];
    AUP1=AUP(:);
    AUP=[zeros(1,q);AUP];
    AUP(end,:)=[];
    AUP2=AUP(:);
    AUP=[zeros(1,q);AUP];
    AUP(end,:)=[];
    AUP3=AUP(:);
    ADOWN = [A0;A0(end,:)];
    ADOWN(1,:)=[];
    ADOWN1 =ADOWN(:);
    ADOWN = [ADOWN;A0(end,:)];
    ADOWN(1,:)=[];
    ADOWN2 =ADOWN(:);
    ADOWN = [ADOWN;A0(end,:)];
    ADOWN(1,:)=[];
    ADOWN3 =ADOWN(:);
    AUD=[AC,AUP1,AUP2,AUP3,ADOWN1,ADOWN2,ADOWN3];
    %EF=U'*AUD;
    TFF=E'*U'*EF;
    zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
    a0=radbas(zs0);
    a0=w2*a0;
    [score1,num1]=max(a0(refer,:));
    [score2,num2]=max(a0(refer01,:));
    name=num1;
%     a=max(a0,[],2);
%     [score1,num1]=max(a);
%     a(num1)=-10;
%     [score2,num2]=max(a);
%     name=num1;
%     if score1 >= threshold1 | (score1-score2)/score1 >= threshold2
%         sig=1;
%         break
%     else
%         sig=0;
%     end  
    results(i,:)=[name,refer,score1,value0,score2,value01];
end
