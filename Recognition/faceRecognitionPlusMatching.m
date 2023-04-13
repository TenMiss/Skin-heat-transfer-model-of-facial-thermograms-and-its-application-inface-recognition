function [name,n,score1,score2,ratio,sig]=faceRecognitionPlusMatching(I,U,E,w,w1,w2,threshold)
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
% $Revision: 2.3 $  $Date: 5 Nov 2004 9:45:15 $
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
    if value0>=threshold
        name=refer; n=refer01;score1=value0;score2=value01; ratio=score1/score2;sig=1;
        break
    end
    AC=A0(:);
    ADOWN=[zeros(2,q);A0];
    ADOWN(end-1:end,:)=[];
    ADOWN2=ADOWN(:);
    ADOWN=[zeros(2,q);ADOWN];
    ADOWN(end-1:end,:)=[];
    ADOWN4=ADOWN(:);
    ADOWN=[zeros(2,q);ADOWN];
    ADOWN(end-1:end,:)=[];
    ADOWN6=ADOWN(:);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    AUP = [A0;A0(end-1:end,:)];
    AUP(1:2,:)=[];
    AUP2 =AUP(:);
    AUP = [AUP;A0(end-1:end,:)];
    AUP(1:2,:)=[];
    AUP4 =AUP(:);
    AUP = [AUP;A0(end-1:end,:)];
    AUP(1:2,:)=[];
    AUP6 =AUP(:);
    AUD=[AUP6,AUP4,AUP2,AC,ADOWN2,ADOWN4,ADOWN6];
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
    a0=radbas(zs0);
    a0=w2*a0;
    a=max(a0,[],2);
    [value0,refer]=max(a);
    a(refer)=0;
    [value01,refer01]=max(a);
    a=max(a0,[],1);
    [value,numIm]=max(a);
    
    AC=AUD(numIm);
    A0=reshape(AC,p,q);
    AR=[zeros(p,1) A0];
    AR(:,end)=[];
    AR1=AR(:);
    AR=[zeros(p,1) AR];
    AR(:,end)=[];
    AR2=AR(:);
    
    AL=[A0 zeros(p,1)];
    AL(:,1)=[];
    AL1=AL(:);
    AL=[AL zeros(p,1)];
    AL(:,1)=[];
    AL2=AL(:);
    ARL=[AL2,AL1,AC,AR1,AR2];
    TFF=E'*U'*ARL;
    zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
    a0=radbas(zs0);
    a0=w2*a0;
%     [score1,num1]=max(a0(refer,:));
%     [score2,num2]=max(a0(refer01,:));
%     name=num1;
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
%    results(i,:)=[name,refer,score1,value0,score2,value01];
end
