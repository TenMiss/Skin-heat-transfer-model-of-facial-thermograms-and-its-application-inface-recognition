function [up0,num0]=detect_up0(B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This program is used to detect the up position up0 which means that
%        
%         only the background without body contains from top to up0
%  
%    input  B:   binary image B without noise
%           
%
%    output up0: the up part which is background without head.
%
%           num0: the whole part which is background
%           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initially determine the upper position of head up0
[height,width]=size(B);
num0=[];
up0=0;
for i=1:height
    rowi=B(i,:);      
    if all(rowi==0)
        num0=[num0 i];          
    end
end

%% num0--the row number which only contains the background without body
[pp,qq]=size(num0);
if length(num0)==1 & num0(1)==1
    up0=1;
elseif length(num0)>1 & num0(1)==1
    for i=2:qq
        delt=num0(i)-num0(i-1);
        if delt>1
            up0=i-1;         
            break
        elseif i==qq
            up0=qq;
        end
    end
end

