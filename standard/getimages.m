data=load('D:\MATLAB6p5\work\data_raw.mat');
fld=fieldnames(data);
I00=getfield(data,fld{1});
figure,imagesc(I00)

data=load('D:\MATLAB6p5\work\data_absolute.mat');
fld=fieldnames(data);
I10=getfield(data,fld{1});
figure,imagesc(I10)

data=load('D:\MATLAB6p5\work\data_object.mat');
fld=fieldnames(data);
I20=getfield(data,fld{1});
figure,imagesc(I20)

data=load('D:\MATLAB6p5\work\data_temperature.mat');
fld=fieldnames(data);
I30=getfield(data,fld{1});
figure,imagesc(I30)
%figure,imshow(I)
%min_value=min(min(I))
%max_value=max(max(I))

%II=I/max_value;
%figure,imshow(I)