function [AA,bbg]=ir2bbg(A,edge)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to (1) estimate the brightness of background and
%
%                          (2) preprocess the IR image---padding the edge
%                              with bbg value
%
%  input:  'A' is an IR intensity image
%
%          'edge' is a 2-element row vector which control the area of padding
%          height_edge=edge(1) and width_edge=edge(2)
%
%  output: AA-- preprocessed (padding) IR intensity image
%
%          bbg--brightness of IR image background
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
    hedge=2;
    wedge=2;    
else
    hedge=edge(1);
    wedge=edge(2);
end
bbg=sum(sum(A(13:27,13:27)))/225;
A(1:hedge,:)=bbg;
A(:,[1:wedge end-wedge+1:end])=bbg;
AA=A;