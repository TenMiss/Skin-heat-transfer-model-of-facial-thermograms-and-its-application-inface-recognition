function [left5,right5,sig]=deshoulder(left0,right0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%                    This program is to judge whether the shoulder occurs and delete the shoulder
%   
%                                             so that only the face contour is formed.
%
%   
%   inputs:    'left0' and 'right0' are two row vectors or two column vectors with the same size which form 
%   
%                           the original contour of head,neck and shoulder. 
%
%   output:   'left5' and 'right5' are two column vectors with the same size which
%
%                           form the head contour and
%
%                 'sig' indicates thether the face has significant rotation  
%
%                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p1,q1]=size(left0);
[p2,q2]=size(right0);
if p1~=p2 | q2~=q2
    disp('The size of input is not same','deshoulder file')
end
if p1==1
    p0=q1;
else
    p0=p1;
end
%%    p0 is the original number of samples.
minleft=min(left0);
num_left=find(left0==minleft);
nol=num_left(end);
maxright=max(right0);
num_right=find(right0==maxright);
nor=num_right(end);
left_position=[];
right_position=[];
lposition=[];
rposition=[];
leftsig=[];
rightsig=[];
lrn=[];
if nol>4*p0/5 | nor>4*p0/5
    %disp('Case1:The shoulder occur')  
    num=max(nol,nor);
    newleft=left0(1:num, :);
    newright=right0(1:num, :);
    for i=1:num-1
        ldelt=newleft(num-i)-newleft(num-i+1);
        if ldelt<0
            left_position=num-i;
            break
        else
            if i>=num-10
                %disp('The head rotates clockwise significantly')
                leftsig=1;
                break
            end
        end 
    end
    for  i=1:num-1
        rdelt=newright(num-i)-newright(num-i+1);
        if rdelt>0
            right_position=num-i;  
            break
        else
            if i>=num-10
                %disp('The head rotates counter clockwise significantly')
                rightsig=1;
                break
            end            
        end
    end
    shoulder_position=[left_position, right_position];
    if ~isempty(shoulder_position) 
        final_position=min(shoulder_position);
        newleft(final_position:end,:)=[];
        newright(final_position:end,:)=[];   
    end       
    left0=newleft;
    right0=newright;
else
    %disp('Case2: Do not find shoulder')
    for i=1:p0-nol
        delt=left0(end-i)-left0(end-i+1);
        if delt<0
            lposition=p0-i;   
            break
        else            
            if i==p0-nol                
                break
            end            
        end
    end        
    for i=1:p0-nor
        delt=right0(end-i)-right0(end-i+1);
        if delt>0
            rposition=p0-i;   
            break
        else
            if i==p0-nor
                break
            end            
        end
    end 
    neck_position=[lposition rposition];
    if ~isempty(neck_position)
        final_position=max(neck_position);
        left0(final_position:end,:)=[];
        right0(final_position:end,:)=[];
    end
end
left5=left0;
right5=right0;
sig=[leftsig rightsig];
