function [Vs, Qr, Qf, Qe, Qc, Qb] = bloodFlow (A)
%%%%%%%%%%%%%%%%computation of converting A to temperature info needed here%%%%%%%%%%%%%%%%%%
[p,q,r]=size(A);
Vs=repmat(zeros,[p,q,r]);
for i = 1:r
    I=A(:,:,i);
    % Kr: Stefan-Boltzman constant, E: epsilon is the emissivity of skin
    Kr = 4.7856*10^(-8);
    %Tamb=min(min(I));
    Tamb=297.5;
    %Tamb=sum(sum(I(25:29,25:29)))/25;
    Q_radiation=Kr*0.98*(I.^4-Tamb^4);
    % Kf: Coefficient for heat convection
    Kf = 0.58*(10^(-2));
    % D: Diameter of the model, changes with experiment object, set at 9.5cm first (cm)
    D = 9.5;
    % Qf: Heat convected to air
    Q_toAir=Kf*(I-Tamb).^1.25./9.5^0.25;
    Q_evaporation=0.0185;
    % Kc: Thermal conductivity of skin
    %Kc = 0.0279;
    Kc=0.168;
    % d: Depth of core temperature point from skin surface, takes it same as D (cm)
    d = 9.5;
    Q_conduction=Kc*(310.55-I)/d;
    % Mo: Coefficient for metabolic rate heat
    Mo = 1.44*(10^(-2));
    % S: Thickness of skin, take it same as D (cm)
    S = 9.5;
    % Tm: Standard tissue temperature sets at 36 degree (value is 220 on the picture)
    Tstand = 309;
    Q_metabolism = Mo*S*2.^((I-Tstand)/10);
    % alpha: counter current heat exchange ratio in a warm condition
    alpha = 0.8;
    % pc: heat capacity of blood
    pc = 0.92;
    % Tb: blood temperature in the core (value is 260 on the picture)
    Tb = 310.15;
    BF=(Q_radiation+Q_toAir+Q_evaporation-Q_conduction-...
        Q_metabolism)./(alpha*pc*S*(Tb-I));
    Vs(:,:,i)=BF;
    Q_bloodFlow=Q_radiation+Q_toAir+Q_evaporation-Q_conduction-Q_metabolism;
    figure,imshow(mat2gray(I));
    figure,imshow(mat2gray(Vs))
end