clear all
data=load('J:\A40\dataBase\ShiQian.mat');
%data=load('F:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1);
I=bigFaceDetection(I);
[IX,IY]=gradient(I);
IX=abs(IX);
IY=abs(IY);
n=find(IX(:)>1);
IX(n)=1;
n=find(IY(:)>1);
IY(n)=1;
I=(IX.*IX + IY.*IY).^0.5;
n=find(I(:)>1);
I(n)=1;
%data=load('F:\A40\dataBase\PanFeng.mat');
data=load('J:\A40\testData\officeNoAircon_shiqian\t002.mat');
fld=fieldnames(data);
II=getfield(data,fld{1});
if (~isa(II,'double'))
    II=double(II);
end
II=bigFaceDetection(II);
[IXX,IYY]=gradient(II);
IXX=abs(IXX);
IYY=abs(IYY);
n=find(IXX(:)>1);
IXX(n)=1;
n=find(IYY(:)>1);
IYY(n)=1;
II=(IXX.*IXX + IYY.*IYY).^0.5;
n=find(II(:)>1);
II(n)=1;
figure
% subplot(2,2,1),imshow(I)
% subplot(2,2,2),imshow(II)
C1=repmat(zeros,160,120);
C2=repmat(zeros,160,120);
C3=repmat(zeros,160,120);
C4=repmat(zeros,160,120);
C5=repmat(zeros,160,120);
C6=repmat(zeros,160,120);
maxoff=max(max(I));
maxout=max(max(II));
step=0.01;
for i=40:90%length(bins)
    n=find(I(:)>=maxoff-step*i);
    C1(n)=1;
    n=find(II(:)>maxout-step*i);
    C2(n)=1;
    n=find(IX(:)>maxout-step*i);
    C3(n)=1;
    n=find(IY(:)>maxout-step*i);
    C4(n)=1;
    n=find(IXX(:)>maxout-step*i);
    C5(n)=1;
    n=find(IYY(:)>maxout-step*i);
    C6(n)=1;
    subplot(3,2,1),imshow(C1)
    subplot(3,2,2),imshow(C2)
    subplot(3,2,3),imshow(C3)
    subplot(3,2,4),imshow(C5)
    subplot(3,2,5),imshow(C4)
    subplot(3,2,6),imshow(C6)
    pause(0.5)
    
end
   