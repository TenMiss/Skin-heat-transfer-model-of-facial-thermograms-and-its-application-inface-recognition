clear all
data=load('J:\A40\dataBase\PanFeng.mat');
%data=load('F:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1);
%data=load('F:\A40\dataBase\PanFeng.mat');
data=load('J:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
II=getfield(data,fld{1});
if (~isa(II,'double'))
    II=double(II);
end
figure
subplot(2,2,1),imshow(mat2gray(I))
subplot(2,2,2),imshow(mat2gray(II))
C1=repmat(zeros,240,320);
C2=repmat(zeros,240,320);
maxoff=max(max(I));
maxout=max(max(II));

for i=2:10%length(bins)
    n=find(I(:)>=maxoff-0.02*i);
    C1(n)=1;
    n=find(II(:)>maxout-0.02*i);
    C2(n)=1;
    subplot(2,2,3),imshow(C1)
    subplot(2,2,4),imshow(C2)
    pause(1.5)
    
end
%     n=find(a(:)>bins(i);
%     C2(n)=1;
%     figure,imshow(C1)

   