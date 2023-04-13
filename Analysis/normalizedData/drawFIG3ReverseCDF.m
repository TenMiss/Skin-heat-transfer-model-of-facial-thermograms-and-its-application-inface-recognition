clear all
data = load('E:\A40\NormalizedDatabaseNoBackground\ShiQian.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1:20);
[p,q,r]=size(I);
BF_sq = ComplexBloodFlow(I);
for j=1:20
    a=I(:,:,j);
    aa=BF_sq(:,:,j);
    num = find(a(:)>0.01);
    b=a(num);
    bb=aa(num);
    %% The following concerns reverse CDF of temperature images  %
    bins=min(b):0.08:max(b);
    counts=histc(b,bins);
    shiqian_reverseBins{j}=bins(length(bins):-1:1)-273.15;
    reverseCounts=counts(length(counts):-1:1);
    reverseCDF=cumsum(reverseCounts);
    reverseCDF=reverseCDF';
    shiqian_NormalizeRCDF{j} = reverseCDF/length(b);
    %% The following concerns reverse CDF of blood perfusion images  %
    binwidth = (max(bb) - min(bb))/length(bins);
    xx = min(bb) + binwidth*(0:length(bins));
    xx(end)=[];
    xx(end)=max(bb);
    binsBF=xx;
    countsBF=histc(bb,binsBF);
    shiqian_reverseBinsBF{j}=binsBF(length(bins):-1:1);
    reverseCountsBF=countsBF(length(countsBF):-1:1);
    reverseCDF_BF=cumsum(reverseCountsBF);
    reverseCDF_BF=reverseCDF_BF';
    shiqian_NormalizeRCDF_BF{j} = reverseCDF_BF/length(bb);
end
data = load('F:\My Papers\SMC_2005\shiqian_time_lapse_data21.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
[p,q,r]=size(I);
BF_sq = ComplexBloodFlow(I);
for j=1:r
    a=I(:,:,j);
    aa=BF_sq(:,:,j);
    num = find(a(:)>0.01);
    b=a(num);
    bb=aa(num);
    %% The following concerns reverse CDF of temperature images  %
    bins=min(b):0.08:max(b);
    counts=histc(b,bins);
    shiqian21_reverseBins_day2{j}=bins(length(bins):-1:1)-273.15;
    reverseCounts=counts(length(counts):-1:1);
    reverseCDF=cumsum(reverseCounts);
    reverseCDF=reverseCDF';
    shiqian21_NormalizeRCDF_day2{j} = reverseCDF/length(b);
    %% The following concerns reverse CDF of blood perfusion images  %
    binwidth = (max(bb) - min(bb))/length(bins);
    xx = min(bb) + binwidth*(0:length(bins));
    xx(end)=[];
    xx(end)=max(bb);
    binsBF=xx;
    countsBF=histc(bb,binsBF);
    shiqian21_reverseBinsBF_day2{j}=binsBF(length(bins):-1:1);
    reverseCountsBF=countsBF(length(countsBF):-1:1);
    reverseCDF_BF=cumsum(reverseCountsBF);
    reverseCDF_BF=reverseCDF_BF';
    shiqian21_NormalizeRCDF_BF_day2{j} = reverseCDF_BF/length(bb);
end


data = load('E:\A40\NormalizedDatabaseNoBackground\EePing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1:10);
[p,q,r]=size(I);
BF_sq = ComplexBloodFlow(I);
for j=1:10
    a=I(:,:,j);
    aa=BF_sq(:,:,j);
    num = find(a(:)>0.01);
    b=a(num);
    bb=aa(num);
    %% The following concerns reverse CDF of temperature images  %
    bins=min(b):0.08:max(b);
    counts=histc(b,bins);
    EePing_reverseBins{j}=bins(length(bins):-1:1)-273.15;
    reverseCounts=counts(length(counts):-1:1);
    reverseCDF=cumsum(reverseCounts);
    reverseCDF=reverseCDF';
    EePing_NormalizeRCDF{j} = reverseCDF/length(b);
    %% The following concerns reverse CDF of blood perfusion images  %
    binwidth = (max(bb) - min(bb))/length(bins);
    xx = min(bb) + binwidth*(0:length(bins));
    xx(end)=[];
    xx(end)=max(bb);
    binsBF=xx;
    countsBF=histc(bb,binsBF);
    EePing_reverseBinsBF{j}=binsBF(length(bins):-1:1);
    reverseCountsBF=countsBF(length(countsBF):-1:1);
    reverseCDF_BF=cumsum(reverseCountsBF);
    reverseCDF_BF=reverseCDF_BF';
    EePing_NormalizeRCDF_BF{j} = reverseCDF_BF/length(bb);
end

data = load('E:\A40\NormalizedDatabaseNoBackground\Venessa.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1:10);
[p,q,r]=size(I);
BF_sq = ComplexBloodFlow(I);
for j=1:10
    a=I(:,:,j);
    aa=BF_sq(:,:,j);
    num = find(a(:)>0.01);
    b=a(num);
    bb=aa(num);
    %% The following concerns reverse CDF of temperature images  %
    bins=min(b):0.08:max(b);
    counts=histc(b,bins);
    Venessa_reverseBins{j}=bins(length(bins):-1:1)-273.15;
    reverseCounts=counts(length(counts):-1:1);
    reverseCDF=cumsum(reverseCounts);
    reverseCDF=reverseCDF';
    Venessa_NormalizeRCDF{j} = reverseCDF/length(b);
    %% The following concerns reverse CDF of blood perfusion images  %
    binwidth = (max(bb) - min(bb))/length(bins);
    xx = min(bb) + binwidth*(0:length(bins));
    xx(end)=[];
    xx(end)=max(bb);
    binsBF=xx;
    countsBF=histc(bb,binsBF);
    Venessa_reverseBinsBF{j}=binsBF(length(bins):-1:1);
    reverseCountsBF=countsBF(length(countsBF):-1:1);
    reverseCDF_BF=cumsum(reverseCountsBF);
    reverseCDF_BF=reverseCDF_BF';
    Venessa_NormalizeRCDF_BF{j} = reverseCDF_BF/length(bb);
end
%%% Draw temperature figure
figure,hold on
for i=1:10
    plot(shiqian_reverseBins{i},shiqian_NormalizeRCDF{i},'b*')
   
end
for i=11:20
    plot(shiqian_reverseBins{i},shiqian_NormalizeRCDF{i},'r+')
 
end
for i=1:4
    plot(shiqian21_reverseBins_day2{i},shiqian21_NormalizeRCDF_day2{i},'r+')
 
end

for i=1:10
    plot(EePing_reverseBins{i},EePing_NormalizeRCDF{i},'k*')
   
end
for i=1:10
    plot(Venessa_reverseBins{i},Venessa_NormalizeRCDF{i},'m*')
   
end
hold off
%title('Rule generation');
%xlabel('Temperature \^o ');
xlabel('Temperature   (\it^{o}C)')
ylabel('Normalized reverse cumulative histograms');
%%% Draw blood perfusion figure
figure,hold on
for i=1:10
    plot(shiqian_reverseBinsBF{i},shiqian_NormalizeRCDF_BF{i},'b*')
   
end
for i=11:20
    plot(shiqian_reverseBinsBF{i},shiqian_NormalizeRCDF_BF{i},'r*')
 
end
for i=1:4
    plot(shiqian21_reverseBinsBF_day2{i},shiqian21_NormalizeRCDF_BF_day2{i},'r*')
 
end
for i=1:10
    plot(EePing_reverseBinsBF{i},EePing_NormalizeRCDF_BF{i},'k*')
   
end
for i=1:10
    plot(Venessa_reverseBinsBF{i},Venessa_NormalizeRCDF_BF{i},'m*')
   
end
hold off
%xlabel('Blood perfusion gm\^(-2)s\^(-1)');
xlabel('Blood perfusion   (\itgm^{-2}s^{-1})')
ylabel('Normalized reverse cumulative histograms');

disp('finished')
