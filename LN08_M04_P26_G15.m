% LN08_M04_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875

function main
clc
clear all
close all

V0 = 1;       % Potencial aplicado
f = 10;       % Frequencia inicial
R = 100;      % Resistencia
C = 4.7e-6;   % Capacidade do condensador
N = 1000;     % Numero de pontos amostrados
Np = 2;       % Numero de ciclos completos

for j=1:5
    [Time, V, VC, VR]=circuito(V0,f,Np,N,R,C)
    
  
    figure(f)
    
    subplot (3,1,1)
    
    plot(Time,V)
    title('V')
    xlabel('tempo (s)')
    ylabel('DDP (V)')
    
    
    subplot (3,1,2)
    plot(Time,VR)
    title('VR')
    xlabel('tempo (s)')
    ylabel('DDP (V)')
    
    subplot (3,1,3)
    plot(Time,VC)
    title('VC')
    xlabel('tempo (s)')
    ylabel('DDP (V)')
    
    f=f*10;
end
    

end
function  [Time, V, VC, VR] = circuito(V0, f, Np, N, R, C)

Time=0;

w=2*pi*f;
    
Time = [0:(Np/f)/N:(Np/f)];

V = V0*exp(i*w*Time);     %*cos(w*t);

Zc = -i/(w*C);            %impedancia do condensador
Z=Zc+R;
I = V./Z;                 %intensidade da corrente

VR = R.*I;                %tensao na resitencia

VC = Zc.*I;               %tensao no condensador

end