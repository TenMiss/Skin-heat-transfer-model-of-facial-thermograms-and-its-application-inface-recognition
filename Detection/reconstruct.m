function [left,right]=reconstruct(left0,right0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              
%                  This program is used to reconstruct the contour 
%
%  Parameters:
%
%  input:  'left0' and 'right0' are two column (or row)vectors which define the face contour
%
%  output: 'left' and 'right' are the reconstructed face contour which are the same
%
%            size of 'left0' and 'right0'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p1,q1]=size(left0);
[p2,q2]=size(right0);
if p1~=p2 & q2~=q2
    error('The size of input is not same in the reconstruct file')
    left=left0;
    right=right0;
    return
end
if p1==1
    p0=q1;
else
    p0=p1;
end
flg=1;
while flg==1
    tic
    left01=left0;
    for i=2:p0-1
        if (left0(i-1)-left0(i))*(left0(i)-left0(i+1))<0
            left0(i)=round((left0(i-1)+left0(i+1))/2);
        end                 
    end
    delt=left01-left0;
    time=toc;
    if all(delt==0)|time>10
        flg=0;
    else
        flg=1;
    end      
end
if time>10
    errordlg('It is overtime to reconstruct left0 in bw2contour')
    return
end
flg=1;
while flg==1
    tic
    left01=left0;
    for i=2:p0-1
        if (right0(i-1)-right0(i))*(right0(i)-right0(i+1))<0   
            right0(i)=round((right0(i-1)+right0(i+1))/2);
        end                           
    end
    delt=left01-left0;
    if all(delt==0)|time>10
        flg=0;
    else
        flg=1;
    end      
end
if time>10
    errordlg('It is overtime to reconstruct right0 in bw2contour')
    return
end
left=left0;
right=right0;
