function AA=detection_normalization(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This is an integrated program for face detection and normalization
%
%  The function is to are to obtain the left and right vectors from the rotated intensity
%
%          image and extract the face image
%
%  input:  'A' is the rotated intensity image.
%          'parameters' is a 3-element row vector which contains
%                       error--the control accuracy when search the contour
%                       bbg----the background intensity
%                       delta--the control value when search the ring
%
%
%  output:  two vectors--'left0' and 'right0' which are two column vectors and
%
%           intensity image AA containing the detected face
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    resp=questdlg('Do you want to use the default accuracy?',...
        'start_points2contour file')
    switch resp
    case {'no','cancel','No','Cancel'}
        return
    case {'yes','Yes'}
        error=3;
        bbg=sum(sum(A(1:4,1:4)))/16;
        delta=0.008;
    end
else
    error=parameters(1);
    bbg=parameters(2);
    delta=parameters(3);
end
[height,width]=size(A);
%%% Get the binary image B
B=ir2bw(A,[bbg delta]);

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
if length(num0)==1 & num0==1
    up0=1;
elseif length(num0)>1 & num0==1
    for i=2:qq
        delt=num0(i)-num0(i-1);
        if delt>1
            up0=i-1;         
            break
        end
    end
end
if ~isempty(up0)
    A(1:up0,:)=[];
    B(1:up0,:)=[];
end
%% Find the start points for searching
[leftstart,rightstart,sp]=bw2start_points(B);

%%% Start searching the face contour and get original values left0, right0
%%% which are used for following processing   
[left0,right0]=start_points2contour(B,[leftstart,rightstart,sp],error);

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
A(no10,:)=[];
left0(no10,:)=[];
right0(no10,:)=[];

%Reconstruct the face contour-----The value in left0 and right0 should be 
%monotonously descendent or ascendent   
[left0,right0]=reconstruct(left0,right0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Find the shoulder
[p0,q]=size(left0);
lnumber=[];
rnumber=[];
count=1;
while count==1
    tic
    for i=1:p0-1
        delt=left0(end-i)-left0(end-i+1);
        if delt<0
            lnumber=i;    
            count=0;
            break
        else
            if i>=p0-20
                count=0;  
                break
            end            
        end
    end
    time=toc;
    if time>10
        errordlg('It is overtime to search shoulder(find lnumber) in ir2face')
        return
    end
end
count=1;
while count==1
    tic
    for i=1:p0-1
        delt=right0(end-i)-right0(end-i+1);
        if delt>0
            rnumber=i;    
            count=0;
            break
        else
            if i>=p0-20
                count=0;  
                break
            end            
        end
    end
    time=toc;
    if time>10
        errordlg('It is overtime to search shoulder(find rnumber) in ir2face')
        return
    end
end      
lrnum=[];
lrnum=[lnumber rnumber];
if ~isempty(lrnum)
    no=max(lrnum);    
    no=p0-no;
    left0(no:end,:)=[];
    right0(no:end,:)=[];
else
    disp('Do not find the shoulder')
end  
left=left0;
right=right0;
fleft=min(left);
fright=max(right);
A(:,[1:fleft-1 fright+1:end])=[];
AA=A;
