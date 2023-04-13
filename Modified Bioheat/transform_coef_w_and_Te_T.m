clear all
close all
%%% This is figure 2

%%%% Parameters
E=0.98;     Kr = 5.67*(10^(-8));
alfa = 0.8; 
Cb = 3.78*10^3; 
j =4000*E*Kr/(alfa*Cb)
Te=15:0.5:30;
T=32:0.5:36
%T=Ta-j*Te.^3;
[X,Y]=meshgrid(Te,T);
K = j*(X+273.15).^3./(39-Y)
mesh(X,Y,K)
%axis([15 30 32 36 0 1])
xlabel('Te  (  \it^{o}C)'  )
ylabel('T  (  \it^{o}C)'  )

