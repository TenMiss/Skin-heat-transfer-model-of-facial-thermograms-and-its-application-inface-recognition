clear all
close all

%%%% Parameters
E=0.98;     Kr = 5.67*(10^(-8));
A=0.27; Pr = 0.72; g = 9.8; beta = 3.354*10^(-3); d = 0.17; gama = 1.56*10^(-5); M=0.25; Kf=0.024;
Ks = 0.2; D=d/2; Ta = 312.15; Tc=Ta;
alfa = 0.8; Pb = 1060; Cb = 3.78*10^3; 
Tambience = 25+273.15;
step=0.25;
Te = Tambience;
Ts=Te:step:310.15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Qr
Qr = Kr*E.*(Ts.^4 - Te^4);
%%%%%%%%%%%%%%%%%%%%%%%%%%% Qf
Gr = g*beta*(Ts-Te)*d^3/(gama^2);
Nu = A*(Pr*Gr).^M;
hf = Kf*Nu./d;
Qf = hf.*(Ts-Te);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Qc
Qc = Ks*(Tc-Ts)/D;
num = find(Qc(:)< 0);
if ~isempty(num)
    disp('The face temperature is more than 38 degree');
    return
end
BFK = alfa*Cb*(Ta-Ts);
num = find(BFK(:)< 0);
if ~isempty(num)
    disp('The face temperature is more than 38 degree');
    return
end
B = 1000*(Qr+Qf-Qc-4.186)./BFK;   
num = find(B(:)< 0);
if ~isempty(num)
    B(num)=0.00001;
end
x_axis = Ts-273.15;
y1_axis = B;

B = 1000*Qr./BFK;   
num = find(B(:)< 0);
if ~isempty(num)
    B(num)=0.00001;
end
y2_axis = B;

figure, hold on
plot(x_axis,y1_axis,'r-*');
plot(x_axis,y2_axis,'r-o');
hold off  

xlabel('Temperature T  (  \it^{o}C)'  )
ylabel('Blood perfusion w (   \itgm^{-2}s^{-1})'  )
