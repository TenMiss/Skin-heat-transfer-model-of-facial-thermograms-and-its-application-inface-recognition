function [left,right,A]=bw2sides(B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is used to extract the left and right sides of a 
%
%          contour from an binary image A without noise
%
%  input:  'B' is a binary IR image without noise          
%       
%
%  output: 'left' and 'right' are two vectors which configure the body contour
%
%          'A' is a binary image containing the centralized face    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
left=[];
right=[];
ally=[];
[height,width]=size(B);
for i=1:height
    rowi=B(i,:);
    if any(rowi~=0)
        ally=[ally;i];
        [r,c]=find(rowi~=0);
        left=[left;c(1)];
        right=[right;c(end)];  
    end                       
end
A=zeros(length(left),max(right));
for j=1:length(left)
    A(j,left(j):right(j))=1.0;
end   
A(:,1:min(left))=[];
%figure,imshow(A,'truesize');
left=left-min(left)+1;
right=right-min(left)+1;