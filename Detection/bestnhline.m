function beta=bestnhline(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     This program is used to calculate the optimal approximated line evaluated via least square
%
%      Functions:
%                            (1) Detect outliers via function 'useful_data'
%                            (2) If the Rxy is great enough, This mean the result obtained via LS is accurate, and here is 
%                                  the angle 'beta'.
%                            (3) If the Rxy is not satisfied, then determine whether beta is within -10~+10 degree according
%                                  to the parameter S or maybe the result via LS is the best.
%
%      bestnhline--best ni he (ping ying) line
%
%     Parameters:
%
%     input x,y: collected sample data which are column vectors.
%
%     output:
%
%            beta is the angle between the approximated line and y axis
%
%            Rxy  is the relative coefficient
%
%            S    is the residual error of x
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xr,xc]=size(x);
[yr,yc]=size(y);
if xr~=yr & xc~=yc
    error('The size of input is not same')
end
if xr<=5 & xc<=5
    error('The number of sample data is not enough')
end

f=[-89:-50 89:-1:50];
ff=[-1:-1:-40, 1:40, 0];
%g=tan(f*pi/180);

g=[-57.2900, -28.6363, -19.0811,  -14.3007,  -11.4301,   -9.5144,   -8.1443,   -7.1154, -6.3138   -5.6713, ...
        -5.1446, -4.7046,  -4.3315, -4.0108, -3.7321, -3.4874, -3.2709, -3.0777, -2.9042, -2.7475,...
        -2.6051, -2.4751, -2.3559, -2.2460, -2.1445, -2.0503, -1.9626, -1.8807, -1.8040, -1.7321,...
        -1.6643, -1.6003, -1.5399, -1.4826, -1.4281, -1.3764, -1.3270, -1.2799, -1.2349, -1.1918, ...
        57.2900, 28.6363, 19.0811, 14.3007, 11.4301, 9.5144, 8.1443, 7.1154, 6.3138, 5.6713, 5.1446, ...
        4.7046,  4.3315, 4.0108, 3.7321, 3.4874, 3.2709, 3.0777, 2.9042, 2.7475, 2.6051, 2.4751, 2.3559,...
        2.2460, 2.1445, 2.0503, 1.9626, 1.8807, 1.8040, 1.7321, 1.6643, 1.6003, 1.5399, 1.4826,...
        1.4281, 1.3764, 1.3270, 1.2799, 1.2349, 1.1918];

xmedian=median(x);
ymedian=median(y);
for i=1:length(f)
    xx(:,i)=xmedian+(y-ymedian)/g(i);
end    
xx=[xx xmedian*ones(length(x),1)];
SR=sum((xx-x*ones(1,length(f)+1)).^2)/length(x);
[v,num]=min(SR);
beta=ff(num);
%figure
%plot(ff,SR,'r*')
%figure
%plot(x,y)
%hold on
%plot(xx(:,num),y','r-')
%hold off
if beta>0
    beta=beta+1;
elseif beta<0
    beta=beta-1;
end
