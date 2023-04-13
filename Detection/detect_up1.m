function [up1,num,sg]=detect_up1(left0,right0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This program is used to detect the up position up1 which means the 
%        width of boundary ring
%        
%  
%    input:  left0 and right0 are two vectors which configure the face contour
%           
%
%    output up1: the upper part which is the width of boundary ring.
%
%           num: the whole part (upper and lower) which is the width of boundary 
%                ring.           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% %% Again determine the upper part of head up1
sg=0;
up1=0;
num0=find((right0-left0)>0);
if length(num0)<=20
    sg=1;
    up1=0;
    num=0;
    errordlg('Something wrong or the face image is too small','Detect_up1 error')    
else
    num=find((right0-left0)<=0);
    [p,q]=size(num);
    if length(num)==1 & num(1)==1
        up1=1;
    elseif length(num)>1 & num(1)==1
        for i=2:p
            delt=num(i)-num(i-1);
            if delt>1
                up1=i-1;         
                break
            else
                if i==p
                    up1=p;                
                end
            end
        end       
    end
end

