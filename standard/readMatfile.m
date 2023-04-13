clear
data=load('D:\MATLAB6p5\Project\Data\rawData\shiqian10.mat');
fld=fieldnames(data);
A=getfield(data,fld{1});
[p,q,r]=size(A)
%I=zeros(q,p,r);
for i=1:r
    I(:,:,i)=A(:,:,i)';
    figure,imagesc(I(:,:,i));
end
save('D:\MATLAB6p5\Project\Data\rawData\shiqian10.mat','I')