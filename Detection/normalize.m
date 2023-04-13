function AA=normalize(A,dimension,par)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This program is used to normalize an image
%
%  input:  'A' is an image with size height-by-width.
%          'dimension' is a row vector which define the size of the normalized image
%          'par' is the value to be padded
%  output: 'AA' is the normalized image with size height_new-by-width_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   $Revision: 2.3 $  $Date: 28 July 2004 23:45:15 $
%
if nargin<=2
    par=273.15+30;
    disp('Here use default parameters in the normalize file')
end
[height,width]=size(A);
height_new=dimension(1);
width_new=dimension(2);
scale=width_new/width;
%A=imresize(A,scale,'bilinear');
A=imresize(A,scale);
[br,bc]=size(A);
if br<height_new
    A(br+1:height_new,:)=par;          
end
A(height_new+1:end,:)=[];
if abs(br-height_new)>=1 | abs(bc-width_new)>=1
    %A=imresize(A,[height_new width_new],'bilinear'); 
    A=imresize(A,[height_new width_new]);
end
AA=A;