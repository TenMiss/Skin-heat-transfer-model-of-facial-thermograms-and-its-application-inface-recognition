function B=preprocessing(A,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  function B=preprocessing(A,k)
%
%  This program is used for preprocessing which comprises two functions:
%
%     (1) change the size of preprocessed image by k. if k<1, it means to 
%         reduce the image size; if k=1,the size will keep the same.
%     (2) two times of median filters
%
%  input:  A is the original intensity image
%          k is a factor which control the size of preprocessed image
%
%  output: B is the preprocessed intensity image
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    resp=questdlg('Do you want to use the default accuracy?',...
        'preprocessing file')
    switch resp
    case {'no','cancel','No','Cancel'}
        return
    case {'yes','Yes'}
        k=0.25;
    end    
end
A=double(A)/255;
%%AA=imresize(A,k);
AA=imresize(A,[120,160]);
AA=medfilt2(AA);  
B=medfilt2(AA,[5 5]);
