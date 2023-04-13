clear all

data=load('J:\A40\dataBase\PanFeng.mat');
%data=load('F:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
I=I(:,:,1);
mintempo1=min(min(I));
maxtempo1=max(max(I));
A=bigFaceDetection(I);
n=find(A(:)<1);
num=find(A(:)>1);
Y=A(num);
maxtemps1=max(Y);
mintemps1=min(Y);
A(n)=297;
%figure,imshow(mat2gray(A));

%data=load('J:\A40\dataBase\PanFeng.mat');
data=load('J:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
mintempo2=min(min(I));
maxtempo2=max(max(I));
AA=bigFaceDetection(I);
n=find(AA(:)<1);
num=find(AA(:)>1);
YY=AA(num);
maxtemps2=max(YY);
mintemps2=min(YY);
AA(n)=297;
%figure,imshow(mat2gray(AA));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% analysis
FArea=length(Y);
BW=ir2bw(A,297.1);
%figure,imshow(BW);
%objectArea = bwarea(BW);
BWE=bwperim(BW);
num=find(BWE==1);
FPerimeter=length(num);
FroundCoef=4*pi*FArea/FPerimeter^2;
tFeatures1=[mintempo1 maxtempo1 mintemps1 maxtemps1]-273.15
sFeatures1 = [FArea;FPerimeter;FroundCoef];
FArea=length(YY);
BW=ir2bw(AA,297.1);
BWE=bwperim(BW);
num=find(BWE==1);
FPerimeter=length(num);
FroundCoef=4*pi*FArea/FPerimeter^2;
tFeatures2=[mintempo2 maxtempo2 mintemps2 maxtemps2]-273.15
sFeatures2 = [FArea;FPerimeter;FroundCoef];

%% The following concerns Histogram  %
inteval=0.08;
bins=min(Y):inteval:max(Y);
invbins1=bins(length(bins):-1:1)-273;
counts1=histc(Y,bins);
invcounts1=counts1(length(counts1):-1:1);
x(1)=counts1(end);
num=length(counts1);
for k = 2:num
    x(k)=x(k-1)+counts1(num-k+1);
end    
figure,plot(invbins1,x,'b')
hold on

bins=min(YY):inteval:max(YY);
invbins2=bins(length(bins):-1:1)-273;
counts2=histc(YY,bins);
invcounts2=counts2(length(counts2):-1:1);
cumulativeNum2=cumsum(invcounts2);
plot(invbins2,cumulativeNum2,'r')
hold off
figure,bar(invbins1,invcounts1);
figure,bar(invbins2,invcounts2);
diff1=diff(x)/inteval;
diff2=diff(cumulativeNum2)/inteval;
figure,plot(diff1,'b'),hold on,plot(diff2,'r'),hold off

