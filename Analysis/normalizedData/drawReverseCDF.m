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
% accumHist = repmat(zeros,[40,10,n]); rowSum = repmat(zeros,[60,10,n]);columnSum = repmat(zeros,[80,10,n]); 
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if (~isa(I,'double'))
        I=double(I);
    end
    [p,q,r]=size(I);
    figure
    for j=1:10
        a=I(:,:,j);
        num = find(a(:)>0.01);
        b=a(num);
        %% The following concerns Histogram  %
        bins=min(b):0.08:max(b);
        counts=histc(b,bins);
        reverseBins=bins(length(bins):-1:1)-273;
        reverseCounts=counts(length(counts):-1:1);
        reverseCDF=cumsum(reverseCounts);
        reverseCDF=reverseCDF';
        NormalizeRCDF = reverseCDF/length(b);
        plot(reverseBins,NormalizeRCDF,'r')
        hold on
    end
    hold off
end
disp('finished')
