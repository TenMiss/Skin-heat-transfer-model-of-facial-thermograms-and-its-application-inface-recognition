clear all
close all

%%%% Parameters
E=0.98;     Kr = 5.67*(10^(-8));
A=0.27; Pr = 0.72; g = 9.8; beta = 3.354*10^(-3); d = 0.17; gama = 1.56*10^(-5); M=0.25; Kf=0.024;
Ks = 0.2; D=d/2; Ta = 312.15; Tc=Ta;
alfa = 0.8; Pb = 1060; Cb = 3.78*10^3; 
Tambience = 25+273.15:2:29+273.15;
step=0.25;
for i = 1:length(Tambience)
    Te = Tambience(i);
    Ts=Te:step:310.15;
    TTs{i}=Ts;
   
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
    x_axis{i}=Ts-273.15;
    y_axis{i}=B;
end 
PTs1=TTs{1}([33 43 49])-273.15;
PTs2=TTs{2}([20 30 40])-273.15;
PTs3=TTs{3}([13 23 33])-273.15;
ya1=y_axis{1}([33 43 49]);
ya2=y_axis{2}([20 30 40]);
ya3=y_axis{3}([13 23 33]);
figure, hold on
plot(TTs{1}-273.15,y_axis{1},'r-*');
plot(TTs{2}-273.15,y_axis{2},'r-o');
plot(TTs{3}-273.15,y_axis{3},'r-+');
hold off  

xlabel('Temperature T  (  \it^{o}C)'  )
ylabel('Blood perfusion w (   \itgm^{-2}s^{-1})'  )

n=length(y_axis{3});
ax=TTs{1}(end-n+1:end); ay=y_axis{1}(end-n+1:end);
bx=TTs{2}(end-n+1:end); by=y_axis{2}(end-n+1:end);
cx=TTs{3};cy=y_axis{3};
figure
plot(ay-by,'r-o');
hold on
%plot(ay-cy,'r-*');
plot(by-cy,'r-*');
hold off  
xlabel('Temperature T  (  \it^{o}C)'  )
ylabel('Blood perfusion w (   \itgm^{-2}s^{-1})'  )
