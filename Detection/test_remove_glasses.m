clear all
%% Define parameters
threshold = 0.8;

A=imread('D:\FLIRA40\Images\sq_withGlasses_007.bmp');
figure;imshow(A)
data=load('D:\FLIRA40\Data\sq_withGlasses.mat');
fld=fieldnames(data);
A=getfield(data,fld{1});
A=A(:,:,7);

bbg=sum(sum(A(1:3,1:3)))/9;
B0=ir2bw(A,bbg+1.5);
% figure;imshow(B0)
B0 = bwareaopen(B0,100);
SE = strel('disk',20);
B01=imclose(B0,SE);
B01 = imfill(B01,'holes');
%% For B01, face =1, background = 0
figure;imshow(B01)
[B,L,N,A] = bwboundaries(B01,'noholes');

B02=~B01;
figure;imshow(B02)

SE = strel('disk',5);
B03=imclose(B0,SE);
figure;imshow(B03)

B04= B02+B03;
figure;imshow(B04)

B04=~B04;
figure,imshow(B04)
B05 = bwareaopen(B04,50);
figure,imshow(B05)
[BB,LL,NN,AA] = bwboundaries(B05,'noholes');
stats = regionprops(LL,'Area','Centroid');
centre=repmat(zeros(1),length(BB),2);
for k = 1:length(BB)
  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = BB{k};
  centre(k,:)=stats(k).Centroid;
  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;
  % compute the roundness metric
  metric (k) = 4*pi*area/perimeter^2;  
end
num=find(metric>=threshold);
if length(num)==1
    msgbox('You may wear eyeglasses,and have great pose variation')
elseif length(num)>1
    centre=centre(num,2);
    
    
            
    

%[B,L,N,A] = bwboundaries(B01,'noholes');
% [p,q]=size(B0);
% B0=[zeros(p,1), B0,zeros(p,1)];
% B0=[zeros(1,q+2); B0;zeros(1,q+2)];
% %figure;imshow(B0)
% B=bwfill(B0,[1,1],4);
% %figure;imshow(B)
% B(:,[1:1 end:end])=[];
% B([1:1 end:end],:)=[];
% %figure;imshow(B)
% B1=~B;
% figure;imshow(B1)
% %% Remove noise
% [L,num]=bwlabel(B1,8)
% CT=[];
% for i=1:num
%     [r,c]=find(L==i);
%     [area,cc]=size(r);
%     if area<30
%         for j=1:area;
%             B1(r(j),c(j))=0.0;
%         end
%     else
%         cr=ceil(0.5*(min(r)+max(r)));
%         cc=ceil(0.5*(min(c)+max(c)));
%         lr=max(r)-min(r);
%         lc=max(c)-min(c);
%         CT=[CT;[cr,cc,lr,lc]];
%     end
% end
% [r,c]=size(CT);
% if isempty(CT)
%     return
% elseif r~=2
%     errordlg('Sth wrong in glasses_removal');
%     return
% else
%     data=load('C:\MATLAB6p5\work\Left_eye.mat');
%     fld=fieldnames(data);
%     T=getfield(data,fld{1});
%     BB=zeros(80,60);
%     BB(CT(1,1)-ceil(CT(1,3)/2):CT(1,1)+ceil(CT(1,3)/2),...
%         CT(1,2)-ceil(CT(1,4)/2):CT(1,2)+ceil(CT(1,4)/2))=...
%         T(16-ceil(CT(1,3)/2):16+ceil(CT(1,3)/2),16-ceil(CT(1,4)/2):16+ceil(CT(1,4)/2));
%     data=load('C:\MATLAB6p5\work\Right_eye.mat');
%     fld=fieldnames(data);
%     T=getfield(data,fld{1});
%     BB(CT(2,1)-ceil(CT(2,3)/2):CT(2,1)+ceil(CT(2,3)/2),...
%         CT(2,2)-ceil(CT(2,4)/2):CT(2,2)+ceil(CT(2,4)/2))=...
%         T(16-ceil(CT(2,3)/2):16+ceil(CT(2,3)/2),16-ceil(CT(2,4)/2):16+ceil(CT(2,4)/2));    
% end
% %SE = strel('disk',2);
% %B2=imdilate(B1,SE);
% %figure;imshow(B2)
% G=BB.*B1;
% %figure;imshow(BB)
% %figure;imshow(G)
% NG=G+A;
% figure;imshow(NG)
