% LN08_M05_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875

%alinea a)
%
%dv/dt=-(k/m)*x
%dx/dt=v
%
%X(k+1) = X(k)+V(k)*(T(k+1)-T(k));
%X(k+1) = X(k)+0.5*(V(k)+V(k+1))*(T(k+1)-T(k));
%
%V(k+1) = V(k)-(kapa/massa)*X(k)*(T(k+1)-T(k));
%V(k+1) = V(k)-(kapa/massa)*0.5*(X(k+1)+X(k))*(T(k+1)-T(k));  
%
%fim alinea a)

function p05
clc
clear all
close all

kapa = 0.1;             % constante elastica
massa = 0.1;            % massa
n=[100,1000,5000];      % alinea c) numero de pontos por oscilacao
Tmax = 2*pi*sqrt(massa/kapa);
x0=[0.1,0.1,0.2];
v0=[0,0.01,0];
[T,X,V] = oscilador(kapa,massa,n,Tmax,x0,v0)
end

%alinea b)
function [T,X,V] = oscilador(kapa,massa,n,Tmax,x0,v0)

%alinea d) calculo para cada par de condicoes iniciais
for m=1:3
    X=x0(m);
    V=v0(m);
    
%alinea c) calculo do vector tempo para 100, 1000 e 5000 pontos
for l=1:3

dt=5*Tmax/n(l);     %calculo do passo de tempo consoante o numero de pontos
T=0:dt:5*Tmax;      %vector tempo, com 5 oscilacoes completas


for k=1:n(l)

    %alinea a)
    X(k+1) = X(k)+V(k)*(T(k+1)-T(k));
    V(k+1) = V(k)-(kapa/massa)*X(k)*(T(k+1)-T(k));
   %trapezio
    X(k+1) = X(k)+0.5*(V(k)+V(k+1))*(T(k+1)-T(k));
    V(k+1) = V(k)-(kapa/massa)*0.5*(X(k+1)+X(k))*(T(k+1)-T(k));    
   
end




figure
subplot(3,1,1)
plot(T,X)
title({'';['Numero de pontos = ',num2str(n(l))];...
    ['X0 = ',num2str(x0(m)),'  V0 = ',num2str(v0(m))]})
xlabel('Tempo (s)')
ylabel('X (m)')


subplot(3,1,2)
plot(T,V)
%title({'';['Numero de pontos = ',num2str(n(l))];...
  %  ['X0 = ',num2str(x0(m)),'  V0 = ',num2str(v0(m))]})
xlabel('Tempo (s)')
ylabel('V (m/s)')


subplot(3,1,3)
plot(T,((0.5*massa*V.^2)+(0.5*kapa*X.^2))) %calculo da energia mecanica (cinetica + potencial)
%title({'';['Numero de pontos = ',num2str(n(l))];...
 %   ['X0 = ',num2str(x0(m)),'  V0 = ',num2str(v0(m))]})
xlabel('Tempo (s)')
ylabel('E (J)')



end
    
end

end