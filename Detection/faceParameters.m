function [F,signature]=faceDetection(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            This program is for face detection 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   $Revision: 2.3 $  $Date: 23 July 2004 23:45:15 $
%
[height,width,r]=size(I);
min_area=2000;max_area=5000;
par_noise=10;
edge=3;delt=2;
signature=0;
F=zeros(80,60,r);
for i=1:r
    % Face detection and normalization    
    A=I(:,:,i);
    A=imresize(A,0.5);
    [height,width]=size(A);
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    B=delete_bw_noise(B0,[min_area max_area]);
    if all(B==0)
        signature=1;
        break
    end
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature=1;
        %msgbox('There may be two objects in the bw2contour file')
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
    if up <= edge+1
        %msgbox('The upper part of face is cut off')
        signature=1;    
        break
    end       
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        %msgbox('The side face is cut off')
        signature=1;
        break
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature=1;
        break
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=2
        %disp('No need to rotate')
        alfa=0;        
        A(1:up-1,:)=[];
        A(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        [countangle,sig]=iterative_rotate(CB,alfa,10); 
        alfa=sum(countangle);
        A([1:up-1,down+1:end],:)=[];
        A(:,[1:minleft-2 maxright+2:end])=[];
        A=rotate_pad(A,[alfa,bbg]);
        [left,right,A]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    A=normalize(A,[80 60],bbg);
    %A=remove_glasses(A);
    F(:,:,i)=A;
end