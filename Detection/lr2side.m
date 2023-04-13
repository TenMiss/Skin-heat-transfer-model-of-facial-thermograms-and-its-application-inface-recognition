function [left0,right0,AA]=lr2side(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to process the rotated image (rotated intensity image 
%  which filtered with background intensity)
%
%  The function is to obtain the left and right vectors from the rotated intensity
%  image
%
%  input:  rotated intensity image A.
%  output: two vectors--left and right which are two column vector and
%          intensity image AA containing the detected body (the body is filled 
%          at top and bottom, but not left and right sides)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[height,width]=size(A);
theta_bright=0.015;
error=4;

%% Estimate the gray level of background in images A
bbg=sum(sum(A(1:2,1:2)))/4;
%%% Find the positions where the ring occur and
%%% get the original binary image B0
B=ir2bw(A,bbg);
B0=B;
%%% Delete noises which may not belong to the face contour
%%% Get the denoised binary image B 
B=delete_bw_noise(B,[30,30])

%% Initially determine the upper position of head up0
num0=[];
up0=[];
for i=1:height
    rowi=B(i,:);      
    if all(rowi==0)
        num0=[num0 i];          
    end
end
[pp,qq]=size(num0);
for i=2:qq
    delt=num0(i)-num0(i-1);
    if delt>1
        up0=i-1;         
        break
    end
end

B(num0,:)=[];
B0(num0,:)=[];
%% Determine the start points sp for searching the face contour
[leftstart,rightstart,sp]=bw2start_points(B)
%%% Start searching the face contour and get original values left00, right00 and
%%% left0 right0 which are used for following processing   
left0=[];
right0=[];
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
left2=[];
right2=[];
%%% %% Further determine the upper parameter up1
up1=[];
no10=find((right0-left0)<0);
[pp,q1]=size(no10);
if ~isempty(no10) & no10(1)==1
    for i=2:pp
        delt=no10(i)-no10(i-1);
        if delt>1
            up1=i-1;         
            break
        else
            if i==pp
                up1=pp;
            end
        end
    end       
end
B(no10,:)=[];
left0(no10,:)=[];
right0(no10,:)=[];
A(1:up0+up1,:)=[];

%Reconstruct the face contour-----The value in left0 and right0 should be 
%monotonously descendent or ascendent  
[left0,right0]=reconstruct(left0,right0);
AA=A;
