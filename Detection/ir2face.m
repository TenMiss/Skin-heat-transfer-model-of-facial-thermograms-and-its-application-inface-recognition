function [left,right,AA]=lr2face(A,parameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This program is used to process the rotated image in order to localize the 
%           face image
%
%  The functions are to obtain the left and right vectors from the rotated 
%           intensity image and extract the face image         
%
%  input:  'A' is the rotated intensity image.
%          'parameters' is a 3-element row vector which contains
%
%           parameters=[bbg,min_area,max_area]
%
%  output:  two vectors--'left' and 'right' which are two column vectors and
%
%           intensity image AA containing the detected face
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    disp('Please specify the parameters')
    left=[];
    right=[];
    AA=[];
    return
else
    bbg=parameters(1);
    min_area=parameters(2);
    max_area=parameters(3);
end
B0=ir2bw(A,bbg);
B=delete_bw_noise(B0,[min_area max_area]);
[up0,num0]=detect_up0(B);
unit=min(10,up0);
if unit>=3
    SE=strel('disk',unit);
    B=imclose(B,SE);
end
B = imfill(B,'holes');
AA=A.*B+0.01;
[left,right,up,sig,num]=bw2contour(B);
[left,right,sig]=deshoulder(left,right);
minleft=min(left);
maxright=max(right);
AA(1:up-1,:)=[];
AA(:,[1:minleft-1 maxright+1:end])=[];