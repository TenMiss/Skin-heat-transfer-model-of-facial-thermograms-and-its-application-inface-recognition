clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            This program is used for face detection 
%%
%   $Revision: 2.3 $  $Date: 23 July 2004 23:45:15 $
%

data=load('D:\Data\rawImages\office\test001.mat');
%data=load('D:\MATLAB6p5\Project\Data\rawData\Hu Ke.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if (~isa(I,'double'))
    I=double(I);
end
[height,width,r]=size(I);
min_area=2000;max_area=5000;
par_noise=10;
edge=3;delt=1.5;
signature=[0,0];
background = 0.00001;
F=repmat(zeros,[80 60 r]);
for i=1:r
    % Face detection and normalization    
    A=I(:,:,i);
    A=imresize(A,0.5);
    [height,width]=size(A);
    figure,imshow(mat2gray(A),'truesize');
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    B=delete_bw_noise(B0,[min_area max_area]);
    figure,imshow(B,'truesize')
    if all(B==0)
        signature(1)=1;
        break
    end
    [up0,num0]=detect_up0(B);
    unit=min(10,up0);
    if unit>=3
        SE=strel('disk',unit);
        B=imclose(B,SE);
    end
    B = imfill(B,'holes');
    AA=A.*B+background;
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature(1)=1;
        msgbox('There may be two objects in the bw2contour file')
        break
    end
    if up <= edge+1
        msgbox('The upper part of face is cut off')
        signature(1)=1;    
        break
    end  
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    %figure,imshow(CB,'truesize');
    [left,right,sig]=deshoulder(left,right);
    minleft=min(left);
    maxright=max(right);
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        signature(1)=1;
        break
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature(1)=1;
        break
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=6
        alfa=0;        
        AA(1:up-1,:)=[];
        AA(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        [countangle,sig]=iterative_rotate(CB,alfa,10); 
        alfa=sum(countangle);
        A([1:up-2,down+1:end],:)=[];
        A(:,[1:minleft-3 maxright+3:end])=[];
        A=rotate_pad(A,[alfa,background]);
        figure,imshow(mat2gray(A),'truesize');
        [left,right,AA]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    AA=normalize(AA,[80 60],background);
    figure,imshow(AA);
    %A=remove_glasses(A);
    F(:,:,i)=AA;
end