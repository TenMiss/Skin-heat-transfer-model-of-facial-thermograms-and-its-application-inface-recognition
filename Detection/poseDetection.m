function [F,signature]=poseDetection(left,right,threshold)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            This program determines whether the face pose is great 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   $Revision: 1.0 $  $Date: 3 August 2004 21:45:15 $
%

    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature=1;
        %msgbox('There may be two objects in the bw2contour file')
        break
    end
    
    [left,right,sig]=deshoulder(left,right);
    minleft=min(left);
    maxright=max(right);
   
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