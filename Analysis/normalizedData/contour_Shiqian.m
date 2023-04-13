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
I=(IX.*IX + IY.*IY).^0.5;
%data=load('F:\A40\dataBase\PanFeng.mat');
data=load('J:\A40\testData\officeNoAircon_shiqian\t002.mat');
fld=fieldnames(data);
II=getfield(data,fld{1});
if (~isa(II,'double'))
    II=double(II);
end
II=bigFaceDetection(II);
[IX,IY]=gradient(II);
II=(IX.*IX + IY.*IY).^0.5;
figure
subplot(2,2,1),imshow(mat2gray(I))
subplot(2,2,2),imshow(mat2gray(II))
C1=repmat(zeros,240,320);
C2=repmat(zeros,240,320);
maxoff=max(max(I));
maxout=max(max(II));
step=0.08;
for i=2:10%length(bins)
    n=find(I(:)>=maxoff-step*i);
    C1(n)=1;
    n=find(II(:)>maxout-step*i);
    C2(n)=1;
    subplot(2,2,3),imshow(C1)
    subplot(2,2,4),imshow(C2)
    pause(1.5)
    
end
%     n=find(a(:)>bins(i);
%     C2(n)=1;
%     figure,imshow(C1)

   