function [beta,Rxy,S,a,b]=nhline(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program is used to calculate the approximated line evaluated via 
%  least square
%
%  This program is served for the function bestnhline
%
%  Parameters:
%
%  input:  Both x and y should be either a row vector or a column vector
%
%  output: a,b are the coefficients of the approximated line y=a+bx
%              S is the residual error of x   
%              Rxy is the relative coefficient. 
%                                                             If Rxy =0, x,y are independent
%                                                             If Rxy is positive, the face need be rotated clockwise
%                                                             Otherwise, rotated countclockwise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[xr,xc]=size(x);
[yr,yc]=size(y);
if xr~=yr & xc~=yc
    error('The size of input is not same')
end
if xr<=2 & xc<=2
    error('The number of sample data is not enough')
end
if xr==1
    n=xc;
else
    n=xr;
end
xmean=mean(x);
ymean=mean(y);
sxy=0;
sxx=0;
syy=0;
for i=1:n
    sxy=sxy+(x(i)-xmean)*(y(i)-ymean);
    sxx=sxx+(x(i)-xmean)*(x(i)-xmean);
    syy=syy+(y(i)-ymean)*(y(i)-ymean);
end             
if sxx/n<=0.1
    beta=0;
    Rxy=0;
    S=sum((xmean-x).*(xmean-x))/length(x);
else
    b=sxy/sxx;
    a=ymean-b*xmean;
    Rxy=sxy/sqrt(sxx*syy);                
    xx=(y-a)/b;
    S=sum((xx-x).*(xx-x))/length(x);
    beta=angle_transform(b);
    %figure
    %plot(x,y,'r*')
    %hold on
    %plot(xx,y,'c-')
    %hold off
end