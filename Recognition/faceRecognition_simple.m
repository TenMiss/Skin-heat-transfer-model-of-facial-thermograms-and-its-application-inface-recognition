function [name,n,score1,score2,ratio,sig]=faceRecognition(I,U,E,w,w1,w2,threshold)
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
    [u,v]=size(A);
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,v));
    a0=radbas(zs0);
    a0=w2*a0;
    [score1,name]=max(a0);
    a0(name)=0;
    [score2,n]=max(a0);
    ratio=score1/score2;
    if score1 >= threshold
        sig=1;
    else
        sig=0;
    end  
end
