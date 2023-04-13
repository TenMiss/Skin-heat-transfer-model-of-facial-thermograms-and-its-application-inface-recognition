function [NG, sig]= remove_glasses(data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This program is used to 
%                            (1) detect glasses 
%                            (2) remove glasses
%
%  input:      'data'  is a normalized intensity image
%              
%  output:   'NG' is a normalized intensity image without glasses        
%
%            'sig" is a signature to show whether there are glasses
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classin = class(data);
switch classin
case 'uint8'
    A=double(data)/255;
case 'single'
    A=double(data);
case 'double'
    A=data;
otherwise
    messageId = 'Images:Remove_glasses:invalid Image Class';
    message2 = ['The input image must be uint8, single, double.'];
    error(messageId,'%s', message2);             
end
bbg=5/255;
B0=ir2bw(A,bbg);
B01=~B0;              %%%%%%%%%%%%% set eye 1
SE = strel('disk',3);
B01=imerode(B01,SE);
B01=imdilate(B01,SE);
B0=~B01;            %%%%%%%%%%%%% set eye 0
[p,q]=size(B0);
B0=[zeros(p,1), B0,zeros(p,1)];
B0=[zeros(1,q+2); B0;zeros(1,q+2)];
B=bwfill(B0,[1,1],3);     %%%%%%%%%%%%% background is set to 1
B(:,[1:1 end:end])=[];
B([1:1 end:end],:)=[];
B1=~B;            %%%%%%%%%% eye is set to 1
%% further remove noise
[L,num]=bwlabel(B1,8);
CT=[];
for i=1:num
    [r,c]=find(L==i);
    [area,cc]=size(r);
    if area<20
        for j=1:area;
            B1(r(j),c(j))=0.0;
        end
    else
        cr=ceil(0.5*(min(r)+max(r)));
        cc=ceil(0.5*(min(c)+max(c)));
        lr=max(r)-min(r);
        lc=max(c)-min(c);
        CT=[CT;[cr,cc,lr,lc]];
    end
end
[r,c]=size(CT);
if isempty(CT)
    sig=0;
    NG=A;
else
    sig=1;
    data=load('C:\cap_tomodify\Matlab\DataBase\Left_eye.mat');
    fld=fieldnames(data);
    T=getfield(data,fld{1});
    BB=zeros(80,60);
    for j=1:r
        BB(CT(j,1)-ceil(CT(j,3)/2):CT(j,1)+ceil(CT(j,3)/2),...
            CT(j,2)-ceil(CT(j,4)/2):CT(j,2)+ceil(CT(j,4)/2))=...
            T(16-ceil(CT(j,3)/2):16+ceil(CT(j,3)/2),16-ceil(CT(j,4)/2):16+ceil(CT(j,4)/2));
    end    
    G=BB.*double(B1);
    NG=G+A;
end
%figure;imshow(NG)