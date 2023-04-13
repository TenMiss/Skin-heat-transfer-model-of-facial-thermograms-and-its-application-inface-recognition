clear all
close all
%%%% Parameters
E=0.98;     Kr = 5.67*(10^(-8));
A=0.27; Pr = 0.72; g = 9.8; beta = 3.354*10^(-3); d = 0.17; gama = 1.56*10^(-5); M=0.25; Kf=0.024;
Ks = 0.2; D=d/2; Tc = 312.15; Ta=Tc;
alfa = 0.8; Pb = 1060; Cb = 3.78*10^3; 
Skin = 32+273.15:2:36+273.15;
stepUnit=0.1;
Te = 18+273.15:stepUnit:28+273.15;
for i = 1:length(Skin)
    Ts=Skin(i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Qr
    Qr = Kr*E.*(Ts.^4 - Te.^4);
    
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
    
    y_axis{i}=B;
end 

figure, plot(Te-273.15,y_axis{1},'b-');
hold on
plot(Te-273.15,y_axis{2},'g');
plot(Te-273.15,y_axis{3},'r-');
hold off    
xlabel('Temperature Te')
ylabel('Blood perfusion w')

ay=diff(y_axis{1});
by=diff(y_axis{2});
cy=diff(y_axis{3});
ayy=cumsum(ay);
byy=cumsum(by);
cyy=cumsum(cy);
xx=cumsum(diff(Te));
figure
plot(xx,ayy,'r-');
% hold on
% plot(xx,byy,'r-o');
%plot(xx,cyy,'r-+');
xlabel('Difference of temperature   (  \Delta Te)'  )
ylabel('Difference of blood perfusion  (   \Delta w)'  )
%hold off    

xxx=xx([10 20 40 60 80 100]);
aayy=ayy([10 20 40 60 80 100]);
bbyy=byy([10 20 40 60 80 100]);
ccyy=cyy([10 20 40 60 80 100]);

figure
plot(xxx,aayy,'r-*');
% hold on
% plot(xxx,bbyy,'r-o');
%plot(xxx,ccyy,'r-+');
xlabel('Difference of temperature   (  \Delta Te)'  )
ylabel('Difference of blood perfusion  (   \Delta w)'  )
%hold off     
    