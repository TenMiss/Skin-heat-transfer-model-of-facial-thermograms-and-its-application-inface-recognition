function [xx,yy,sig]=useful_data(x,y,delt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      
%             This program is used to search the useful data (inliers) and delete the outliers 
%
%  Parameters:
%
%  inputs:     'x','y' are data with outliers. x,y are row or column vectors.
%
%  outputs:   'xx', 'yy' are two column vectors without outliers.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig=0;
if nargin<3
    delt=10;       
end
[xr,xc]=size(x);
[yr,yc]=size(y);
if xr~=yr & xc~=yc
    error('The size of input is not same in the Useful_data file')
    sig=1;
    xx=0;
    yy=0;
    return
end
if xr==1
    n=xc;
    x=x';
    y=y';
else
    n=xr;
end
if n<=6
    %errordlg('The number of sample data is not enough','Useful_data file')
    sig=1;
    xx=0;
    yy=0;
    return
end
sp=round(n/2);
data=[x,y]';
%% data is a 2-row matrix in which each column represents a sample. so it's size is    2*n
data1=data(:,sp);
data2=data(:,sp);
for i=1:sp-1
    datai=data(:,sp-i);
    [row,m]=size(data1);
    %delt=data1-datai*ones(1,m);
    %sum((x-y).^2)
    distance=sum((data1-datai*ones(1,m)).^2);
    %Note: parameter 'distance' should be the square of distance
    if any(distance<=delt)
        data1=[data1 datai];
    end
end
if m<=2
    %warndlg('This is impossible or the threshold for distance is too small when search the upper data', ...
        %'Useful_data file') 
    sig=1;
    xx=0;
    yy=0;
    return
else
    data1=data1(:,length(data1): -1:1);
end

for i=sp+1:n
    datai=data(:,i);
    [row,m]=size(data2);
    distance=sum((data2-datai*ones(1,m)).^2);
    if any(distance<=delt)
        data2=[data2 datai];
 
    end    
end
if m<=2
    %warndlg('This is impossible or the threshold for distance is too small when search the lower data', ...
        %'Useful_data file lower data warning')
    sig=1;
    xx=0;
    yy=0;
    return
end
data1(:,end)=[];
data=[data1 data2];
xx=data(1,:)';
yy=data(2,:)';
%figure
%plot(x,y,'r*')
%hold on
%plot(xx,yy,'bo')
%hold off