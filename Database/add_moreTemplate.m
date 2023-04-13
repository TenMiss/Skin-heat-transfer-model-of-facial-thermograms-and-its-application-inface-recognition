clear
load('D:\MATLAB6p5\Project\Data\dataBase.mat');
load('D:\MATLAB6p5\Project\Data\testData.mat');%,'T');
data=load('D:\MATLAB6p5\Project\Data\Normalized data\TongLing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});

T(:,:,271:280)=I(:,:,11:20);
%T=cat(3,T,I(:,:,11:20));
%DB(end+1).Name='TongLing';
DB(end).Name='TongLing';
DB(end).Templates =I(:,:,1:10);

save ('D:\MATLAB6p5\Project\Data\dataBase.mat','DB');
save ('D:\MATLAB6p5\Project\Data\testData.mat','T');
