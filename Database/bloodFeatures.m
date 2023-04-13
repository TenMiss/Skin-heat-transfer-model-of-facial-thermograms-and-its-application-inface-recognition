function bFeatures=bloodFeatures(I)
%
%% This program is used to extract blood features from normalized images
%
%% Input: I may be 2D or 3D normalized data.
%% %
%% Created by Wu Shiqian, I2R, 2-Nov-2004
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p,q,n]=size(I);
BF=bloodFlow(I);
for j=1:n
    a=BF(:,:,j);
    num = find(a(:)>0);
    b=a(num);
    bFeatures(:,j) = [min(b);max(b);mean(b);std(b)];
end