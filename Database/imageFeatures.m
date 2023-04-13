function [sFeatures,tFeatures,accumHist,rowSum,columnSum]=imageFeatures(I)
%
%% This program is used to extract features of normalized images
%
%% Input: I may be 2D or 3D normalized data.
%% sFeatures are shape information = [area;perimeter;round; similarity]
%% tFeatures are thermal information = [max(Temp),mean(T),STD(T)]
%% %% rowSum, columnSum are matrice: projections on x, y 
%% accumHist is a matrix:   accumulation of pixels from highest temperature to lowest temperature
%
%% Created by Wu Shiqian, I2R, 2-Nov-2004
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p,q,n]=size(I);
%accumHist = repmat(zeros,[40,n]); rowSum = repmat(zeros,[q,n]);columnSum = repmat(zeros,[p,n]); 
for j=1:n
    a=I(:,:,j);
    num = find(a(:)>=2);
    objectArea=length(num);
    BW=im2bw(a,0.2);
    BWE=bwperim(BW);
    num=find(BWE==1);
    objectPerimeter=length(num);
    roundCoef=4*pi*objectArea/objectPerimeter^2;
    num = find(a(:)>=306);
    bb=a(num);
    num =find(a(:)<306);
    a(num)=0;
    tFeatures(:,j) = [max(bb);mean(bb);std(bb)];
    sFeatures(:,j) = [objectArea;objectPerimeter;roundCoef];
    rowSum(:,j) = sum(a,1)';
    columnSum(:,j) = sum(a,2);
    %% The following concerns Histogram  %
    bins=min(bb):0.02:max(bb);
    counts=histc(bb,bins);
    %figure,hist(b)
    x(1)=counts(end);
    num=length(counts);
    for k = 2:num
        x(k)=x(k-1)+counts(num-k+1);
    end    
    accumHist (:,j)= x(1:40)';
end