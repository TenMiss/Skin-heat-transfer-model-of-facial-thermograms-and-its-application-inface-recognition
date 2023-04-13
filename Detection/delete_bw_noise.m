function BB=delete_bw_noise(B,par)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This program is used to 
% 
%        (1) remove the noise in a binary image which converted from an IR image
%
%        (2) get the label image
%  
%    input  B:   original binary image B which is converted from an IR image
%           par = [min_area max_area]
%
%    output BB:  binary image without noise,which havs the same size as B.
%           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    disp('Please specify the minimun area and maximum area')
    BB=B;
    return
else
    min_area=par(1);
    max_area=par(2);
end
[L,num]=bwlabel(B,8);
position=[];
for i=1:num
    [r,c]=find(L==i);
    [area,cc]=size(r);
    if area<min_area
        for j=1:area;
            B(r(j),c(j))=0.0;
        end
    else
        a=[i,min(r),max(r),min(c),max(c),area];
        position=[position;a];     
    end
end
[m,n]=size(position);
if m>2
    up=position(:,2);
    [v,n]=min(up);  % v is the min value, n is the index
    reference=position(n,:);
    position(n,:)=[];
    [p,q]=size(position); % p = m-1. i.e. the reminder after removing the reference 
    for j=1:p
        if abs(reference(4)-position(j,5))<=60 | abs(reference(5)-position(j,4))<=60 ...
                | abs((reference(4)+reference(5))/2 -(position(j,4)+position(j,5))/2)<80  
            [r,c]=find(L==position(j,1));
            [area,cc]=size(r);
            for k=1:area;
                B(r(k),c(k))=0.0;
            end
        end
    end
end
BB=B;
