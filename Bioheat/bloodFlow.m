function Vs = bloodFlow (I)
[p,q,r]=size(I);
Vs=repmat(zeros,[p,q,r]);
for i = 1:r
    Ts=I(:,:,i);
    Kr = 5.67*(10^(-8));
    E = 0.98;
    n=find(Ts(:)>1);
    subpixs = Ts(n);
    Tmin=min(subpixs);
    delt=(Tmin-273.15)*(1-E);
    Te = Tmin + delt;
    Qr = Kr*E.*(Ts.^4 - Te^4);
    Ta=312.15;
    % Vs: blood perfusion rate
    BF = Qr./(Ta-Ts);
    n=find(BF(:)<0);
    BF(n)=0;
    Vs(:,:,i)=BF;
end