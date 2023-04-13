function [name,score1,score2,sig]=re_faceRecognition(A,c,ni,U,E,w,w1,w2,delt,P)
% This is the revision of function recognition_complex
% Inputs:
%        I--input p * q image matrix
%        c--No of registered persons
%        ni--No of templates for each person
%        U, E, w, w1, w2-- trained eigen, fisher, width,and w1, w2 parameters
%        delt is a 2-element vector,the first one is used for absolute
%                  similarity comparison, while the second is used for relative comparison
%        P--eigen features matrix (c*ni-1 * c*ni matrix)
% Outputs:
%        name--the name corresponding to max similarity value
%        score1, score2--the max and 2nd max similarity values
%        sig -- indicates whether the person is identified
% Last update: 15 August 2003
% $Revision: 2.3 $  $Date: 26 July 2004 15:45:15 $
%
if nargin ~= 10
    errordlg('The input is incorrect','re_faceRecognition file')
end
if length(delt)~= 2
    errordlg('The input threshold is 2-element vector','re_faceRecognition file')
end
tform = maketform('affine',[-1 0 0; 0 1 0; 0 0 1]);
A1 = imtransform(A,tform);
AA=A1(:);
A=A(:);
EF=U'*A;
BL=0.8:0.1:1.3;
A=[A*BL AA*BL];
[u,v]=size(A);
TEF=U'*A;
TFF=E'*TEF;
zs0=dist(w1,TFF)./(w'*ones(1,v));
a0=radbas(zs0);
a0=w2*a0;
a=max(a0,[],2);
[score1,num1]=max(a);
a(num1)=-10;
[score2,num2]=max(a);
a(num2)=-10;
[score3,num3]=max(a);
a(num3)=-10;
[score4,num4]=max(a);
a(num4)=-10;
[score5,num5]=max(a);
a(num5)=-10;
[score6,num6]=max(a);
a(num6)=-10;
[score7,num7]=max(a);
a(num7)=-10;
[score8,num8]=max(a);
a(num8)=-10;
[score9,num9]=max(a);
a(num9)=-10;
[score10,num10]=max(a);
num=[num1,num2,num3,num4,num5,num6,num7,num8,num9,num10];
part_EF=P(:,[(num1-1)*ni+1:num1*ni,(num2-1)*ni+1:num2*ni,...
        (num3-1)*ni+1:num3*ni,(num4-1)*ni+1:num4*ni,...
        (num5-1)*ni+1:num5*ni,(num6-1)*ni+1:num6*ni,...
        (num7-1)*ni+1:num7*ni,(num8-1)*ni+1:num8*ni,...
        (num9-1)*ni+1:num9*ni,(num10-1)*ni+1:num10*ni]);
[part_FF,PE]=fisher_train(part_EF,10,ni);
[wwidth,ww1,ww2]=RBF_train(part_FF,10,ni);
newFF=PE'*TEF;
zs=dist(ww1,newFF)./(wwidth'*ones(1,v));
a0=radbas(zs);
a0=ww2*a0;
a=max(a0,[],2);
[score1,n1]=max(a);
num1=num(n1);
a(n1)=-10;
[score2,n2]=max(a);
name=num(n1);
if score1 >= delt(1) | (score1-score2)/score1 >= delt(2)
    sig=1;
else
    sig=0;
end