clear
data=load('D:\MATLAB6p5\Project\Data\rawData\shiqian07.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I07=I;
[p,q,r]=size(I);

data=load('D:\MATLAB6p5\Project\Data\rawData\shiqian10.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I10=I;

data=load('D:\MATLAB6p5\Project\Data\rawData\shiqian13.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I13=I;

for i=1:r
    a07=I07(:,:,i);
    a10=I10(:,:,i);
    a13=I13(:,:,i);
    a07min=min(min(a07));
    a07max=max(max(a07));
    a10min=min(min(a10));
    a10max=max(max(a10));
    a13min=min(min(a13));
    a13max=max(max(a13));
    value(i,:)=[a07min a07max a10min a10max a13min a13max];
end
for i=1:6
    figure,plot(value(:,i))
end

%imshow(mat2gray(I))