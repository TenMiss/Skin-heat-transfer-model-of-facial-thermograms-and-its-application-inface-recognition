function [left,right,up,down,sg,num]=bw2contour(B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This program is used to extract the left and right sides of a 
%
%          contour from an denoised binary image B 
%
%  input:      'B'  is a binary image without noise
%
%              
%  output: 'left' and right are two vectors which configure the body contour
%
%          'up' is the number between the top edge of the image B and the 
%               detected head
%
%          'sg" is a signature to show whether the image needs processing
%               (as more than one objects occur)
%
%          'num' indicates the number of objects
%               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sg=0;
[L,num]=bwlabel(B,8);
if num>=2
    %disp('There may be two objects','bw2contour file error')
    sg=1;
    left=0; right=0; up=0; down=0;
    return
else
    [row,column]=find(L==1);
    up=min(row);
    down=max(row);
    left=[];right=[];
    for i=up:down
        position = find(row==i);
        columni=column(position);
        left=[left;min(columni)];
        right=[right;max(columni)];    
    end        
end
