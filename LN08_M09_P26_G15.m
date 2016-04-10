% LN08_M09_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875

function p09
clc
clear all
close all

q = 70;
c = 450;
sig = 5.67e-8;
alfa = 0.5;

%q = -v*alfa*(T-Tar)-sig*T^4+Rs+Ra;

% alinea a)
t = 0:60:259200;

% alinea b)
Tar = 290+10*sin(((2*pi*t)/86400)+pi);

% alinea c)
Rs = max(0,800*sin((2*pi*t)/86400+3*pi/2));



% alinea d)
Ra = 300;

% alinea e)
v = 5;

% alinea f)
% metodo de euler

T(1)=Tar(1)
N=size(t);

figure(70)
euler_labnum(v,alfa,Tar,sig,Rs,Ra,70,c,t,T,N)

figure(700)
euler_labnum(v,alfa,Tar,sig,Rs,Ra,700,c,t,T,N)

end

function [void] = euler_labnum (v,alfa,Tar,sig,Rs,Ra,q,c,t,T,N)




for k=2:N(2)
    
    T(k)=T(k-1)+60*(-v*alfa*(T(k-1)-Tar(k-1))-sig*T(k-1)^4+Rs(k-1)+Ra)/(q*c);
    H(k)=v*alfa*(T(k-1)-Tar(k-1));
end


subplot(4,1,1)
plot(t/3600,Tar)
title({['Qs = ', num2str(q)];'';'Temperatura do Ar'})
ylabel('T(K)')
xlabel('tempo(h)')

subplot(4,1,2)
plot(t/3600,T)
title('Temperatura da Placa')
ylabel('T(K)')
xlabel('tempo(h)')

subplot(4,1,3)
plot(t/3600,H)
title('Fluxo de Calor Sensível')
ylabel('W/m^2')
xlabel('tempo(h)')


subplot(4,1,4)
plot(t/3600,Ra+Rs)
title('Radiação Total Descendente')
ylabel('T')
xlabel('tempo(h)')

end

