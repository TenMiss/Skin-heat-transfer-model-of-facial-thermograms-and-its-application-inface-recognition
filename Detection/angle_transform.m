function beta=angle_transform(b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to calculate the angle between vertical axe and the
%           approximated line obtained by function 'nhline' 
%
%  This program is served for the function 'nhline'---i.e., assume the approximated 
%          line is   y=bx+a
%
%  Parameters:
%
%  input:  'b' --------is the coefficient of x in the approximated line
%
%  output: 'beta'----is the angle between vertical axe and the approximated line obtained
%                           by function 'nhline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gama=180*atan(b)/pi;
if gama<0
    beta=-(90-abs(gama));
else
    beta=90-gama;
end