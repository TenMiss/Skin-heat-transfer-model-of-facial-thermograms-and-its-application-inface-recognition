clear all

data=load('J:\A40\dataBase\PanFeng.mat');
%data=load('F:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
[height,width,r]=size(I);
min_area=4000;max_area=10000;
par_noise=10;
edge=3;delt=1.5;
signature=[0,0];
background = 0.00001;
%background = 290;
F=repmat(zeros,[200 150 r]);
for i=1:1
    % Face detection and normalization    
    A=I(:,:,i);
    maxtempo1=max(max(A));
    mintempo1=min(min(A));
    %A=imresize(A,0.5);
    [height,width]=size(A);
    %figure,imshow(mat2gray(A),'truesize');
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    B=delete_bw_noise(B0,[min_area max_area]);
    %figure,imshow(B,'truesize')
    if all(B==0)
        signature(1)=1;
        break
    end
    [up0,num0]=detect_up0(B);
    unit=min(10,up0);
    if unit>=3
        SE=strel('disk',unit);
        B=imclose(B,SE);
    end
    B = imfill(B,'holes');
    AA=A.*B+background;
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature(1)=1;
        msgbox('There may be two objects in the bw2contour file')
        break
    end
    if up <= edge+1
        msgbox('The upper part of face is cut off')
        signature(1)=1;    
        break
    end  
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    %figure,imshow(CB,'truesize');
    [left,right,sig]=deshoulder(left,right);
    minleft=min(left);
    maxright=max(right);
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        signature(1)=1;
        break
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature(1)=1;
        break
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=60
        alfa=0;        
        AA(1:up-1,:)=[];
        AA(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        [countangle,sig]=iterative_rotate(CB,alfa,10); 
        alfa=sum(countangle);
        A([1:up-2,down+1:end],:)=[];
        A(:,[1:minleft-3 maxright+3:end])=[];
        A=rotate_pad(A,[alfa,background]);
        figure,imshow(mat2gray(A),'truesize');
        [left,right,AA]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    AA=normalize(AA,[200,150],background);
    n=find(AA(:)<1);
    num=find(AA(:)>1);
    Y=AA(num);
    maxtemps1=max(max(Y));
    mintemps1=min(min(Y));
    AA(n)=297;
    IT1=AA;
    figure,imshow(mat2gray(AA));
    [x1,y1]=find(AA==max(max(AA)));
end

%data=load('J:\A40\dataBase\PanFeng.mat');
data=load('J:\A40\testData\level5outside\test566.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
[height,width,r]=size(I);
min_area=4000;max_area=10000;
par_noise=10;
edge=3;delt=1.5;
signature=[0,0];
background = 0.00001;
%background = 290;
F=repmat(zeros,[200 150 r]);
for i=1:1
    % Face detection and normalization    
    A=I(:,:,i);
    maxtempo2=max(max(A));
    mintempo2=min(min(A));
    %A=imresize(A,0.5);
    [height,width]=size(A);
    %figure,imshow(mat2gray(A),'truesize');
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    B=delete_bw_noise(B0,[min_area max_area]);
    %figure,imshow(B,'truesize')
    if all(B==0)
        signature(1)=1;
        break
    end
    [up0,num0]=detect_up0(B);
    unit=min(10,up0);
    if unit>=3
        SE=strel('disk',unit);
        B=imclose(B,SE);
    end
    B = imfill(B,'holes');
    AA=A.*B+background;
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature(1)=1;
        msgbox('There may be two objects in the bw2contour file')
        break
    end
    if up <= edge+1
        msgbox('The upper part of face is cut off')
        signature(1)=1;    
        break
    end  
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    %figure,imshow(CB,'truesize');
    [left,right,sig]=deshoulder(left,right);
    minleft=min(left);
    maxright=max(right);
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        signature(1)=1;
        break
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature(1)=1;
        break
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=60
        alfa=0;        
        AA(1:up-1,:)=[];
        AA(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        [countangle,sig]=iterative_rotate(CB,alfa,10); 
        alfa=sum(countangle);
        A([1:up-2,down+1:end],:)=[];
        A(:,[1:minleft-3 maxright+3:end])=[];
        A=rotate_pad(A,[alfa,background]);
        figure,imshow(mat2gray(A),'truesize');
        [left,right,AA]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    IT2=normalize(AA,[200,150],background);
    num=find(IT2(:)>1);
    Y=IT2(num);
    maxtemps2=max(max(Y));
    mintemps2=min(min(Y));
    n=find(IT2(:)<1);
    IT2(n)=297;
    figure,imshow(mat2gray(IT2));
    [x2,y2]=find(IT2==max(max(IT2)));    
end

a=IT1;
num = find(a(:)>297);
b=a(num);
objectArea=length(num);
BW=ir2bw(a,297.1);
%figure,imshow(BW);
%objectArea = bwarea(BW);
BWE=bwperim(BW);
num=find(BWE==1);
objectPerimeter=length(num);
roundCoef=4*pi*objectArea/objectPerimeter^2;
tFeatures1=[mintempo1 maxtempo1 mintemps1 maxtemps1]-273.15
sFeatures1 = [objectArea;objectPerimeter;roundCoef];
%% The following concerns Histogram  %
bins=min(b):0.01:max(b);
invbins1=bins(length(bins):-1:1)-273;
counts=histc(b,bins);
invcounts=counts(length(counts):-1:1);
% x(1)=counts(end);
% num=length(counts);
% for k = 2:num
%     x(k)=x(k-1)+counts(num-k+1);
% end    
cumulativeNum1=cumsum(invcounts);
figure,plot(invbins1,cumulativeNum1,'b')
hold on

a=IT2;
num = find(a(:)>297);
b=a(num);
objectArea=length(num);
BW=ir2bw(a,297.1);
%figure,imshow(BW);
%objectArea = bwarea(BW);
BWE=bwperim(BW);
num=find(BWE==1);
objectPerimeter=length(num);
roundCoef=4*pi*objectArea/objectPerimeter^2;
tFeatures2=[mintempo2 maxtempo2 mintemps2 maxtemps2]-273.15
sFeatures2 = [objectArea;objectPerimeter;roundCoef];
%% The following concerns Histogram  %
bins=min(b):0.01:max(b);
invbins2=bins(length(bins):-1:1)-273;
counts=histc(b,bins);
invcounts=counts(length(counts):-1:1);
% x(1)=counts(end);
% num=length(counts);
% for k = 2:num
%     x(k)=x(k-1)+counts(num-k+1);
% end    
cumulativeNum2=cumsum(invcounts);
plot(invbins2,cumulativeNum2,'r')
hold off

n=min(length(cumulativeNum2),length(cumulativeNum1));
cum1=cumulativeNum1(1:n);
cum2=cumulativeNum2(1:n);
invbins1=invbins1(1:n);
invbins2=invbins2(1:n);
figure,plot(cum1-cum2);
pcum=cum(1:30);
cum(1:30)=0;
nneg=find(cum<0);
npos=find(cum>0);
negminmax=minmax(nneg');
posminmax=minmax(npos');
posminmax=posminmax(2:-1:1);
pos=find(abs(negminmax-posminmax)<3);

position=negminmax(pos);
%keytemp=(invbins1(position)+invbins2(position))/2;
