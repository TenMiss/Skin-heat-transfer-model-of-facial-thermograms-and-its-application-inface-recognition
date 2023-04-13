function B=ir2bw(A,par)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to convert an IR image to binary image
%  
%  input: 'A' is an intensity image
%         'par' is a threshold
%
%  output: 'B' is a binary image which has the same size as A
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    disp('Please specify the threshold value')
    B=zeros(size(A))
    return;
else
    threshold=par;  
end
[height,width]=size(A);
B=A;
for k=1:height
    for j=1:width
        if B(k,j)>threshold
            B(k,j)=1;
        else
            B(k,j)=0;
        end
    end
end
