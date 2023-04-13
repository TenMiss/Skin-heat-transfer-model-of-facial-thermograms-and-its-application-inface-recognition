function [theta,sig]=side2rotate(left,right)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This program is used to detect the totation angle of the detected object.
%  
%             The available detected angle scope is -45<=theta<=45
%
%  Functions:
%     (1) Get the sample data mx( i ), y( i ) from inputs 'left' and 'right'
%     (2) Obtain the angle 'theta' from sample data via look-up table
%
%  input:    arguments "left" and "right" are the left and right column (or row) 
%
%            of position.
%
%  output:  The angle of the detected face represented by parameters "left" and 
%           "right"
%
%           'theta' is defined as the angle between the approximated line and y axis
%
%           If the detected face turns to right (from the viewer) theta is negtive, 
%           otherwise,theta is positive
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig=0;
[xr,xc]=size(left);
[yr,yc]=size(right);
if xr~=yr & xc~=yc
    error('The size of input is not same in side2rotate file')
    theta=0;
    sig=1;
    return
end
if xr<=6 & xc<=6
    sig=1;
    theta=0;
    error('The number of sample data is not enough in side2rotate file')
    return
end
if xr==1
    n=xc;
else
    n=xr;
end
mx=0.5*(right+left);
y=1:n;
y=(y-ceil(n(end)/2))';
theta=bestnhline(mx,y);