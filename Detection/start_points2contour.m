function [left0,right0,sg]=start_points2contour(B0,V,error)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                           This program is used to search the contour points from the start points 
%
%  Parameters:
%
%  input:  'B0' is a binary image with noise
%
%             'V' is a 3-element row vector which is [startleft startright sp] where sp 
%
%                 is the row number
%
%             'error' control the searching accuracy
%
%  output: two column vectors 'left0' and 'roght0'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<=2
    error=4;
end
[sr,sc]=size(V);
if sr~=1 & sc~=3
    error('The input is incorrect in the start_points2contour file')
end
%% Get the parameters
[p0,q0]=size(B0);
leftstart=V(1);
rightstart=V(2);
sp=V(3);

left1=zeros(sp,1);
left2=zeros(p0,1);
right1=zeros(sp,1);
right2=zeros(p0,1);
left1(end,:)=leftstart;
left2(sp,:)=leftstart;
right1(end,:)=rightstart;
right2(sp,:)=rightstart;
%%%% First determine the left side 
for i=1:sp-1
    row2=B0(sp-i:sp-i+1,:);
    [L1,unm]=bwlabel(row2,8);
    object=L1(2,left1(sp-i+1,:));
    no=find(L1(1,:)==object);
    if ~isempty(no)
        left1(sp-i,:)=no(end);           
    else
        %%% The contour is broken
        no1=find(L1(1,:)~=0);
        delt=abs(no1-left1(sp-i+1,:));
        [vmin,nom]=min(delt);
        if vmin<=3*error
            left1(sp-i,:)=no1(nom);               
        else
            left1(sp-i,:)=left1(sp-i+1);
            B0(sp-i,left1(sp-i,:))=1.0;
        end           
    end
end
for i=sp:p0-1
    row2=B0(i:i+1,:);
    [L1,unm]=bwlabel(row2,8);
    object=L1(1,left2(i,:));
    no=find(L1(2,:)==object);
    if ~isempty(no)
        left2(i+1,:)=no(end);
    else
        no1=find(L1(2,:)~=0);           
        delt=abs(no1-left2(i,:));
        [vmin,nom]=min(delt);
        if vmin<=4*error
            left2(i+1,:)=no1(nom);               
        else
            left2(i+1,:)=left2(i,:);
            B0(i+1,left2(i+1,:))=1.0;
        end                      
    end       
end
%%%% Then determine the right side
for i=1:sp-1
    row2=B0(sp-i:sp-i+1,:);
    [L1,unm]=bwlabel(row2,8);
    object=L1(2,right1(sp-i+1,:));
    no=find(L1(1,:)==object);
    if ~isempty(no)
        right1(sp-i,:)=no(1);
    else
        no1=find(L1(1,:)~=0);
        delt=abs(no1-right1(sp-i+1,:));
        [vmin,nom]=min(delt);
        if vmin<=4*error
            right1(sp-i,:)=no1(nom);               
        else
            right1(sp-i,:)=right1(sp-i+1);
            B0(sp-i,right1(sp-i,:))=1.0;
        end                      
    end
end
for i=sp:p0-1
    row2=B0(i:i+1,:);
    [L1,unm]=bwlabel(row2,8);
    object=L1(1,right2(i,:));
    no=find(L1(2,:)==object);
    if ~isempty(no)
        right2(i+1,:)=no(1);
    else
        no1=find(L1(2,:)~=0);
        delt=abs(no1-right2(i,:));
        [vmin,nom]=min(delt);
        if vmin<=4*error
            right2(i+1,:)=no1(nom);               
        else
            right2(i+1,:)=right2(i);
            B0(i+1,right2(i+1,:))=1.0;
        end           
    end
end
left2(1:sp,:)=left1;
right2(1:sp,:)=right1;
left0=left2+2;
right0=right2;

sg=0;
if length(left0)<=20
    sg=1;
    %errordlg('Something wrong or the face image is too small','start_points2contour')    
end
