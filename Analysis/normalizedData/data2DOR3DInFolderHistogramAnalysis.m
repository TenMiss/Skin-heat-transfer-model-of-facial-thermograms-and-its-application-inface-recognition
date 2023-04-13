clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
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
accumHist = repmat(zeros,[40,10,n]); rowSum = repmat(zeros,[60,10,n]);columnSum = repmat(zeros,[80,10,n]); 
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if (~isa(I,'double'))
        I=double(I);
    end
    [p,q,r]=size(I);
    for j=1:10
        a=I(:,:,j);
        num = find(a(:)>=2);
        objectArea=length(num);
        BW=im2bw(a,0.2);
        %objectArea = bwarea(BW);
        BWE=bwperim(BW);
        num=find(BWE==1);
        objectPerimeter=length(num);
        roundCoef=4*pi*objectArea/objectPerimeter^2;
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         aa=a;
%         num =find(a(:)<0);
%         aa(num)= 25;
%         %figure,imshow(mat2gray(aa),'true');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        num = find(a(:)>=306);
        bb=a(num);
        num =find(a(:)<306);
        a(num)=0;
        tFeatures(:,j) = [max(bb);mean(bb);std(bb)];
        sFeatures(:,j) = [objectArea;objectPerimeter;roundCoef];
        rSum(:,j) = sum(a,1)';
        cSum(:,j) = sum(a,2);
        %% The following concerns Histogram  %
        bins=min(bb):0.04:max(bb);
        counts=histc(bb,bins);
        %figure,hist(b)
        x(1)=counts(end);
        num=length(counts);
        for k = 2:num
            x(k)=x(k-1)+counts(num-k+1);
        end    
        pixSum (:,j)= x(1:40)';
    end
    accumHist(:,:,i) = pixSum;
    rowSum(:,:,i) = rSum; 
    columnSum(:,:,i) = cSum;
    shapeFeatures(:,:,i) = sFeatures;
    thermalFeatures(:,:,i) = tFeatures;
end
disp('extracted features')
