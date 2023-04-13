clear all
data=load('E:\A40\NormalizedDatabaseNoBackground\ZTongLing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
if ~isa(I,'double')
    I=double(I);
end
[p,q,r]=size(I);
Vs=repmat(zeros,[p,q,r]);
for i = 1:r
    Ts=I(:,:,i);
    %%%%%%%%  Qr
    E=0.98;     Kr = 5.67*(10^(-8));
    n=find(Ts(:)>1);
    subpixs = Ts(n);
    Te=min(subpixs);
    nn=find(Ts(:)<Te);
    Ts(nn)=Te;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Qr
    Qr = Kr*E.*(Ts.^4 - Te^4);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% Qf
    A=0.27; Pr = 0.72; g = 9.8; beta = 3.354*10^(-3); d = 0.17; gama = 1.56*10^(-5); M=0.25; Kf=0.024;
    Gr = g*beta*(Ts-Te)*d^3/(gama^2);
    Nu = A*(Pr*Gr).^M;
    hf = Kf*Nu./d;
    Qf = hf.*(Ts-Te);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Qc
    Ks = 0.2; D=d/2; Tc = 311.15;
    Qc = Ks*(Tc-Ts)/D;
    num = find(Qc(:)< 0);
    if ~isempty(num)
        disp('The face temperature is more than 38 degree');
        return
    end
    
    alfa = 0.8; Pb = 1060; Cb = 3.78*10^3; Ta=311.15;
    BFK = alfa*Cb*(Ta-Ts);
    num = find(BFK(:)< 0);
    if ~isempty(num)
        disp('The face temperature is more than 39 degree');
        return
    end
    B = 1000*(Qr+Qf-Qc-4.186)./BFK;
    num = find(B(:)< 0);
    if ~isempty(num)
        B(num)=0.00001;
    end
    BF(:,:,i)=B;
end 

    
    