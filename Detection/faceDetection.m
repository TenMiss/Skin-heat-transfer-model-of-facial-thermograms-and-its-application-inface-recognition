function [F,signature]=faceDetection(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            This program is for face detection 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   $Revision: 2.3 $  $Date: 23 July 2004 23:45:15 $
%
[height,width,r]=size(I);
if ~isa(I,'double')
    I=double(I);
end
min_area=2000;max_area=5000;
par_noise=10;
edge=3;delt=1.5;
signature=[0,0];
background = 0.00001;
F=[];
for i=1:r
    % Face detection and normalization    
    A=I(:,:,i);
    A=imresize(A,0.5);
    [height,width]=size(A);
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    B=delete_bw_noise(B0,[min_area max_area]);
    if all(B==0)
        signature(2)=1;
        continue
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
        signature(2)=1;
        %msgbox('There may be two objects in the bw2contour file')
        continue
    end
    if up <= edge+1
        %msgbox('The upper part of face is cut off')
        signature(1)=1;    
        continue
    end  
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    [left,right,sig]=deshoulder(left,right);
    minleft=min(left);
    maxright=max(right);
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        signature(1)=1;
        continue
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature(2)=1;
        continue
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
        [left,right,AA]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    AA=normalize(AA,[80 60],background);
    %A=remove_glasses(A);
    F=cat(3,F,AA);
end