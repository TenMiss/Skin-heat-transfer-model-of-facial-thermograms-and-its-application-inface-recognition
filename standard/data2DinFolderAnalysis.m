clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file')
if isequal([filename,pathname],[0,0])
    return
end
dir_struct = dir(pathname);
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
a=[dir_struct.isdir];
a(1:2)=[];             %%% Delete the dot dir
sorted_names(1:2)=[]; 
[n,m]=size(sorted_names);
%vvalue=repmat(zeros,n,2);
for i=56:56
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    a=getfield(data,fld{1});
    if (~isa(a,'double'))
        a=double(a);
    end
    a=a-273.15;
    [p,q]=size(a);
    b=[];
    for j=1:80
        for k=1:60
            if a(j,k)>0
                b=[b a(j,k)];
            else
                a(j,k)=32;                
            end
        end
    end
    figure,imshow(mat2gray(a),'true');
    [y1,x1]=find(a==min(min(a)));
    mini=min(min(a));
    maxi=max(max(a));
    [y2,x2]=find(a==max(max(a)));
    meanv=mean(b);
    variance=std(b);
    vvalue(i,:)=[mini,maxi,meanv,variance];
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
% figure,plot(vvalue(:,1))
% figure,plot(vvalue(:,2))
% figure,plot(vvalue(:,3))
% figure,plot(vvalue(:,4))
% 
% mini_value=min(vvalue)
% maxi_value=max(vvalue)
% delt_value = maxi_value - mini_value
