function Vs = bloodFlow (I)
[p,q,r]=size(I);
Vs=repmat(zeros,[p,q,r]);
for i = 1:r
    Ts=I(:,:,i);
    x=Ts;
    num = find(x(:)<1);
    x(num)=inf;
    Te = min(x(:))-0.5;
    Kr = 5.67*(10^(-8));
    E = 0.985;
    % Qr: Radiated heat
    Qr = Kr*E.*(Ts.^4 - Te^4);    
    d=0.095;
    Tc=312.15;  % i.e. 39 degree
    Ta = Tc;
    % Vs: blood perfusion rate
    %BF = Qb./(pb*Cb.*(Ta-Ts));
    BF = Qr;
    %BF = Qr./(Ta-Ts);
    n=find(BF<0);
    BF(n)=0.01;
    Vs(:,:,i)=BF;
end