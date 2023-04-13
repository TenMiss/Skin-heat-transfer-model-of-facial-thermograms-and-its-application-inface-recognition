function [leftstart,rightstart,sp,siga]=bw2start_points(B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to find the start points for searching the contour 
%
%  Parameters:
%
%  input:  B is a binary image without noise
%          
%  output: the left start point'leftstart',right start point 'rightstart'
%
%          and the row number 'sp' where the start points are
%
%  Note: one constraint: if the face image is too small, cannot find the face
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
siga=0;
[p0,q0]=size(B);
s0=round(p0/2);
leftstart=[];
rightstart=[];
for j=s0:p0   
    startrow=B(j,:);
    [L1,num1]=bwlabel(startrow,8);
    if num1==2
        no1=find(L1==1);
        no2=find(L1==2);
        initial_leftstart=no1(end);
        initial_rightstart=no2(1);
        if (initial_rightstart-initial_leftstart)>20
            sp=j;
            leftstart=initial_leftstart;
            rightstart=initial_rightstart;
            break
        end
    end
end
if isempty(leftstart) & isempty(rightstart)
    for j=1:s0-1   
        startrow=B(s0-j,:);
        [L1,num1]=bwlabel(startrow,8);
        if num1==2
            no1=find(L1==1);
            no2=find(L1==2);
            initial_leftstart=no1(end);
            initial_rightstart=no2(1);
            if (initial_rightstart-initial_leftstart)>20
                sp=s0-j;
                leftstart=initial_leftstart;
                rightstart=initial_rightstart; 
                break
            end
        end
    end       
end
if isempty(leftstart) & isempty(rightstart)
    siga=1;   
    leftstart=0;
    rightstart=0;
    sp=0;
    %errordlg('Cannot find the start points','bw2start_points file error')  
end
