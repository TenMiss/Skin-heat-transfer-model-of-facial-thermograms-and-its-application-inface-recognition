function [A,signature]=faceDetection(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            This program is for face detection 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   $Revision: 2.3 $  $Date: 23 July 2004 23:45:15 $
%
[height,width]=size(A);
min_area=300;max_area=2000;
par_noise=10;
edge=3;
signature=0;
A=imresize(A,0.5);
%figure,imagesc(A),axis image;
[A,bbg]=ir2bbg(A,[edge,edge]);
B0=ir2bw(A,bbg+3);
%figure,imshow(B0,'truesize')
B=delete_bw_noise(B0,[min_area max_area]);
figure,imshow(B,'truesize')
if all(B==0)
    A=0;
    signature=1;
    return
end
[left,right,up,down,sig,num]=bw2contour(B);
if sig==1
    A=0;   
    signature=1;
    return
end
CB=zeros(length(left),max(right))
for j=1:length(left)
    CB(j, left(j):right(j))=1.0;
end   
CB(:,1:min(left))=[];
figure,imshow(CB,'truesize');
[left,right,sig]=deshoulder(left,right);
C=zeros(length(left),max(right))
for j=1:length(left)
    C(j, left(j):right(j))=1.0;
end   
C(:,1:min(left))=[];
figure,imshow(C,'truesize');
minleft=min(left);
maxright=max(right);
if up<=edge
    errordlg('The upper part of face is cut off')
    A=0;
    signature=1;    
    return
end       
if (minleft<=edge)|(maxright>=width-edge)
    errordlg('The side face is cut off')
    A=0;
    signature=1;
    return
end       
[dleft,dright,sig]=useful_data(left,right,par_noise);
if sig==1
    A=0;    
    signature=1;
    return
end
alfa=side2rotate(dleft,dright);
if abs(alfa)<=6
    %disp('No need to rotate')
    alfa=0;        
    A(1:up,:)=[];
    A(:,[1:minleft-1 maxright+1:end])=[];     
else        
    [countangle,sig]=iterative_rotate(CB,alfa,10); 
    if sig==1
        A=0;
        signature=1;
        return
    end
    alfa=sum(countangle);
    A([1:up-2,down+1:end],:)=[];
    A(:,[1:minleft-3 maxright+3:end])=[];
    A=imrotate(A,-alfa,'bilinear');
    [left,right,A]=ir2face(A,[bbg,min_area,max_area]); 
end
A=normalize(A,[80 60]);
A=remove_glasses(A);