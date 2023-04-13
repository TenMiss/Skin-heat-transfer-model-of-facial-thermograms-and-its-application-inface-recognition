clear all
%close all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);    
end
data=load(File);
fld=fieldnames(data);
I=getfield(data,fld{1});
[p,q,r]= size(I);
if (~isa(I,'double'))
    I=double(I);
end

%value=repmat(zeros,20,4);
for i=13:13
    a=I(:,:,i)-273.15;
    [p,q]=size(a);
    b=[];
    for j=1:p
        for k=1:q
            if a(j,k)>0
                b=[b a(j,k)];
            else
                a(j,k)=25;                
            end
        end
    end
    figure,imshow(mat2gray(a));
    [y1,x1]=find(a==min(min(a)));
    mini=min(min(a));
    maxi=max(max(a));
    [y2,x2]=find(a==max(max(a)));
    meanv=mean(b);
    variance=std(b);
    value(i,:)=[mini,maxi,meanv,variance];
    bins=min(b):0.1:max(b);
    counts=histc(b,bins);
    %figure,hist(b)
    x(1)=counts(end);
    num=length(counts);
    for j=2:num
        x(j)=x(j-1)+counts(num-j+1);
    end   
end
AA=zeros(1,p*q);
n=find(a(:)>34.18);
AA(n)=a(n);
A=reshape(AA,p,q);
figure,imshow(mat2gray(A));
% figure,plot(value(:,1))
% figure,plot(value(:,2))
% figure,plot(value(:,3))
% figure,plot(value(:,4))
% mini_value=min(value)
% maxi_value=max(value)
% delt_value = maxi_value - mini_value