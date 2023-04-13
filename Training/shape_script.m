clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            $Revision: 1.0 $  $Date: 3 August 2004 20:45:15 $
%
%data=load('D:\MATLAB6p5\Project\Data\rawData\test.mat');
data=load('D:\Data\test.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if isa(I,'single')
    I=double(I);
end
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
    figure,imshow(mat2gray(A));
    [A,bbg]=ir2bbg(A,[edge,edge]);
    B0=ir2bw(A,bbg+delt);
    figure,imshow(logical(B0),'truesize')
    B=delete_bw_noise(B0,[min_area max_area]);
    figure,imshow(logical(B),'truesize');
    if all(B==0)
        signature=1        
        break
    end
    
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature=1
        disp('There may be two objects in the bw2contour file')
        break
    end
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    figure,imshow(CB,'truesize');
    [left,right,sig]=deshoulder(left,right);
    C=zeros(length(left),max(right));
    for j=1:length(left)
        C(j, left(j):right(j))=1.0;
    end   
    C(:,1:min(left))=[];
    figure,imshow(C,'truesize');
    minleft=min(left);
    maxright=max(right);
    if up <= edge+1
        disp('The upper part of face is cut off')
        signature=1
        break
    end       
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        disp('The side face is cut off')
        signature=1
        break
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature=1
        break
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=2
        %disp('No need to rotate')
        alfa=0;        
        A(1:up-1,:)=[];
        A(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        [countangle,sig]=iterative_rotate(CB,alfa,10) 
        if sig==1
            signature=1
            break
        end
        alfa=sum(countangle);
        A([1:up-1,down+1:end],:)=[];
        A(:,[1:minleft-2 maxright+2:end])=[];
        A=rotate_pad(A,[alfa,bbg]);
        %figure,imshow(mat2gray(A),'truesize');
        [left,right,A]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    %figure,imshow(mat2gray(A),'truesize');
    A=normalize(A,[80 60],bbg);
    A=remove_glasses(A);
    F(:,:,i)=A;
    figure,imshow(mat2gray(A),'truesize');
end