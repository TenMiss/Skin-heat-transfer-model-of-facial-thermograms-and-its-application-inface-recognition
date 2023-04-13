clear all
% This function computes the blood flow rate from the known skin temperature
% Ts contains the original temperature information
% Each pixel of Ts contains 3 components
% Vs is skin blood-flow rate


% [filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, 'Select MAT file');
% if isequal([filename,pathname],[0,0])
%     return
% else
%     File = fullfile(pathname,filename);    
% end
% data=load(File);
% fld=fieldnames(data);
% I=getfield(data,fld{1});
% I=I(:,:,1);
data=load('D:\Project\A40\normalizedData\testData.mat');%,'BF');
fld=fieldnames(data);
I=getfield(data,fld{1});
I=I(:,:,1);
[row, col, dim] = size(I);

%%%%%%%%%%%%%%%%computation of converting Ts to temperature info needed here%%%%%%%%%%%%%%%%%%

% Kr: Stefan-Boltzman constant, E: epsilon is the emissivity of skin
Kr = 4.7856*10^(-8);
Tamb=min(min(I));
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
Vs=(Q_radiation+Q_toAir+Q_evaporation-Q_conduction-...
    Q_metabolism)./(alpha*pc*S*(Tb-I));
Q_bloodFlow=Q_radiation+Q_toAir+Q_evaporation-Q_conduction-Q_metabolism;
figure,imshow(mat2gray(I));
figure,imshow(mat2gray(Vs))
II=mat2gray(I);
I1=II-0.3;
I2=0.7*II;
figure,imshow(I1)
figure,imshow(I2)