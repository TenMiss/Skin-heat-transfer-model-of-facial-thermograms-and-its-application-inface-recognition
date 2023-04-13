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
        b=a(num);
        %% The following concerns Histogram  %
        bins=min(b):0.08:max(b);
        invbins=bins(length(bins):-1:1)-273;
        counts=histc(b,bins);
        invcounts=counts(length(counts):-1:1);
        %figure,hist(b)
        x(1)=counts(end);
        num=length(counts);
        for k = 2:num
            x(k)=x(k-1)+counts(num-k+1);
        end    
        %pixSum (:,j)= x(1:40)';
        figure,bar(invbins,invcounts)
       keyboard
    end
    %accumHist(:,:,i) = pixSum;
end
disp('extracted features')
