function [Vs, Qr, Qf, Qe, Qc, Qb] = bloodFlow_complex (I)
[p,q,r]=size(I);
Vs=repmat(zeros,[p,q,r]);
for i = 1:r
    Ts=I(:,:,i);
    Kr = 5.67*(10^(-8));
    E = 0.98;
    % Te: enviromental temperature
    Tmin=min(min(Ts));
    delt=(Tmin-273.15)*(1-E);
    %Te = Tmin + delt;
    Te=Tmin;
    % Qr: Radiated heat
    Qr = Kr*E.*(Ts.^4 - Te^4);
    % gloc: local acceleration due to gravity
    gloc = 9.8;
    % b: volume coefficient of expansion of air at 25 degree
    b = 3.354*(10^(-3));
    d=0.095;
    % v: kinematic viscosity of air at 25 degree
    v = 1.56*(10^(-5));
    Pr=0.72;
    Gr = gloc*b.*(Ts-Te)*d^3*v^(-2);
    Ray=Pr*Gr;
    % Nu: Nusselt number under free convection at 25 degree
    Nu = 0.54*Ray.^(-0.25);
    % kf: thermal conductivity of air at 25 degree
    kf = 0.024;
    % hc: convection heat transfer coefficient
    hc = Nu*kf/d;
    % Qf: Heat convected by air
    Qf = hc.*(Ts-Te);
    % Pe: water vapor saturation pressure in air at room temperature
    % peSat: density of saturated water vapor in air at room temperature
    Pe = exp(77.3450+0.0057*Te-7235/Te)/(Te^8.2);
    peSat = 0.0022*Pe/Te;
    RH=0.5;
    % peAct: actual density of water vapor in air at room temperature
    peAct = RH*peSat;
    % Ps: water vapor saturation pressure at skin surface
    % psSat: mass density of saturated water vapor at skin surface
    Ps = exp(77.3450+0.0057.*Ts-7235./Ts)./(Ts.^8.2);
    psSat = 0.0022*Ps./Ts;
    % B: air pressure in mmHg
    B = 760;
    % eVp: vapor pressure in mmHg
    eVp = peAct*Te/0.0022*7.5028*10^(-3);
    % pa: air density
    pa = 1.2929*273.13/Te*(B-0.3783*eVp)/760;
    % Ca: specific heat capacity of air
    Ca = 1005;
    % hfg: phase-change enthalpy of water
    hfg = 2.257*10^(-6);
    % Le: lewis number for the diffusion of water vapor into air
    Le = 1;
    % Qe: Evaporated heat
    Qe = hfg*hc.*(peAct-psSat)/(pa*Ca*Le^(2/3));
    % Kc: Thermal conductivity of skin
    %Kc = 0.000209;
    Kc=0.5;
    % Tc: Body core temperature
    Tc=311;
    % Qc: Heat conducted by subcutaneous tissue
    Qc = Kc.*(Tc-Ts)/d;
    % Cb: specific heat capacity of blood
    Cb = 3.7810*(10^3);
    % pb: blood density
    pb = 1060;
    % Ta: temperature of the arterial blood, assume is the asme as the body core temperature
    Ta = 312;
    % Qb: Heat convected by blood perfusion
    Qb = Qr+Qf+Qe-Qc;
    % Vs: blood perfusion rate
    BF = Qb./(pb*Cb.*(Ta-Ts));
    n=find(BF<0);
    BF(n)=0;
    Vs(:,:,i)=BF*1000000;
end
