function AA=rotate_pad(A,parameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This program is used to 
% 
%        (1) rotate the input intensity image A by beta
%
%        (2) pad the rotated image
%  
%    input  A:    intensity image
%           parameters=[beta bbg]
%                                 beta: rotation angle
%                                 bbg:  the brightness of background
%
%    output AA:  rotated intensity image with different size of A.
%           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin>=2
    beta=parameters(1);
    bbg=parameters(2);
else
    disp('Please specify the parameters')
    AA=A;
    return
end
A=imrotate(A,-beta);  
[p,q]=size(A);
for i=1:p
    for j=1:q
        if A(i,j)<bbg
            A(i,j)=bbg;
        end
    end
end
AA=A;