function [up2,sg]=detect_up2(left0,right0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This program is used to detect the up position up1 which is caused by niose
%        
%  
%    input:  left0 and right0 are two vectors which configure the face contour
%           
%
%    output: up2: the upper part which is background without head.
%          
%           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sg=0;
up2=0;
n=right0-left0;
a=n(2)-n(1);
if a<=0
    for i=3:length(left0)
        delt=n(i)-n(i-1);
        if delt>0
            up2=i-1;         
            break
        end
    end
end 
if length(left0)-up2<=15
    sg=1;   
    errordlg('Something wrong or the face image is too small','Detect_up1 error')    
end
