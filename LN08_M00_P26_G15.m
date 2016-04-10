% LN08_M00_P21_G01
 
% Nuno Morgadinho n 26211
% Joao Plancha    n 30875
clc
clear

%Definicao das variaveis:
t = [ones(10,1) (1:10)'];

V = [9.40 7.31 5.15 3.55 2.81 2.04 1.26 0.97 0.74 0.58]'; %d.d.p.
R = 2000; %resistencia


%ALINEA a
b = regress(log(V),t); %regressao linear

lnV0 = b(1); %ordenada na origem da recta de minimos quadrados (corresponde a V0)
m = b(2); %declive da recta de minimos quadrados
V0 = exp(lnV0); 

C = - 1/(R*m); %valor de C

%ALINEA b
y = inline ('V0 * exp (-t/(R*C))','t','V0','R','C'); %definicao da funcao de descarga V(t)

scatter(t(:,2),V,'r') %grafico de dispersao dos pontos experimentais

hold on 


plot ([0:0.1:10], feval(y,[0:0.1:10],V0,R,C)); %grafico da descarga do condensador com os valores calculados

%ALINEA c

text (2,2,['C=',num2str(C)]) %escreve o valor de C


%ALINEA d
title ('Lab 0 - Descarga do Condensador'); %escreve o titulo
xlabel ('tempo (s)'); %escreve a variavel e as unidades no eixo xx
ylabel ('D.D.P.  (V)'); %escreve a variavel e as unidades no eixo yy
