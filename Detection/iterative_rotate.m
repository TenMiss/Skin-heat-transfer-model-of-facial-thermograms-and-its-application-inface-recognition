function [countangle,siga]=iterative_rotate(B,alfa,par_noise)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             This program is used to iteratively compute the accurate rotation angles when a image is detected
%
%              to have rotation
%  
%  input:    argument "B" is a binary image without noise 
%            argument "alfa" is the initial angle detected
%            argument "par_noise" control the converagence speed
%               
%  output:  "countangle" is a row vector contains the angle values for each iteration          
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
countangle=alfa;
[left0,right0,A]=bw2sides(B);
L=right0(end)-left0(end);
symbol=1;       
count=1;
while symbol==1
    BB=imrotate(B,-sum(countangle));
    %figure,imshow(BB,'truesize');
    [newleft,newright,BB]=bw2sides(BB);
    delt=ceil(abs(L*sin(sum(countangle)*pi/180)));
    newleft(end-delt:end)=[];
    newright(end-delt:end)=[];
    
    % Obtain the rotated binary image
    BB(end-delt:end,:)=[];
    %figure,imshow(BB,'truesize');   
    [newleft,newright,sig]=deshoulder(newleft,newright);
    [newleft,newright,siga]=useful_data(newleft,newright,max(par_noise-count,1.2));
    if siga==1
        %countangle=0;
        symbol=0;
        break
        %return
    end
    beta=side2rotate(newleft,newright);           
    countangle=[countangle beta];
    count=count+1;         
    if abs(beta)<=3
        symbol=0;
        break
    end       
    if count>=10
        symbol=0;
        break
    end             
end