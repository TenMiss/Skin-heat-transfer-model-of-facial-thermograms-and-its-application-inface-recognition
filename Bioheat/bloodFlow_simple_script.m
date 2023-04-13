clear all
load('J:\A40\testData\level5outside\test557.mat')
I0=double(I0);
figure,imshow(mat2gray(I0))
I=faceDetection(I0);
[p,q,r]=size(I0);
figure,imshow(I)
%Vs=repmat(zeros,[p,q,r]);
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
    Ta=312;
    % Vs: blood perfusion rate
    BF = Qr./(Ta-Ts);
    n=find(BF(:)<0);
    BF(n)=0;
    Vs(:,:,i)=BF;
end