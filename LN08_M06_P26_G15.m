% LN08_M06_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875

function p06
clc
clear all
close all

L = 0.3;                     % comprimento da barra
Nv=[30,300];
Tleft=273.15;
Tright=293.15;
res=[1e-2,1e-3,1e-6];

for l=1:2
    N=Nv(l);
    Lam(1:N/3) = 209.3;          % condutividade termica do aluminio
    Lam(N/3+1:2*N/3) = 45;       % condutividade termica do aco
    Lam(2*N/3:N) = 389.6;        % condutividade termica do cobre

    for m=1:3
        resmax=res(m);
        [T,iter,resid]=barra(Lam,Tleft,Tright,N,resmax)
        F(1:N/3)=209.3*T((N/3)-1)/(N/3);
        F(N/3+1:2*N/3)=45*T(2*N/3-(N/3+1))/(N/3);
        F(2*N/3:N)=389.6*T(N-(2*N/3))/(N/3);
    
        figure
        subplot(2,1,1);
        plot(T)
        title({['N = ',num2str(N)]; ['Precisao = ',num2str(resmax)]})
        xlabel('x(m)')
        ylabel('T(K)')
        subplot(2,1,2);
        plot(F)
        xlabel('x(m)')
        ylabel('F(W/m^2)')
        
    end
end
end




function [T,iter,resid]=barra(Lam,Tleft,Tright,N,resmax)

T=zeros(1,N);
T(1)=Tleft;
T(N)=Tright;
B=1.5;
iter=0;
resid = 2*resmax;

while resid>resmax
    iter=iter+1;
    resid=0;
       for k=2:N-1
           R=Lam(k)*(T(k+1)-T(k))+Lam(k-1)*(T(k-1)-T(k));
           T(k)=T(k)+B*R/(Lam(k)+Lam(k-1));
           resid=max(resid,abs(R));
       end
end
return
end