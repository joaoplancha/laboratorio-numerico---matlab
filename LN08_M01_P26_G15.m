% LN08_M01_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875

clc
clear all
close all

%Verificacao grafica que x=exp(-x) tem uma solucao no intervalo ]0,1[
%A solucao corresponde a interseccao grafica de x e exp(-x)
figure (1)
subplot(2,1,1)
hold on
fplot('x',[0,1])
fplot('exp(-x)',[0,1])
title('Verificacao grafica da solucao')
set(gca,'Ygrid','on')

%outro modo. a solucao corresponde a exp(-x)-x = 0
%figure (2)
subplot(2,1,2)
fplot('exp(-x)-x',[0,1])
text(0.45,0.3,'exp(-x)-x')
set(gca,'Ygrid','on')

%ALINEA a
solucao_fzero = fzero ('exp(-x)-x',[0,1]);   %valor do zero calculado com a funcao fzero, interna do matlab
solucao_fzero

%ALINEA b
figure (3)
hold on
fplot('x',[0,1],'r')
fplot('exp(-x)',[0,1],'g')
title ('Alinea b');
text(0.05,0.15,'g(x)=x')
text(0.2,0.85,'f(x)=exp(-x)')
set(gca,'Ygrid','on')


%ALINEA c
%representacao grafica da funcao
figure (4)
set(gca,'Ygrid','on')
hold on
fplot('exp(-x)-x',[0,1])
title('Iteracao simples (10 iteracoes)')


%ciclo de iteracao simples
iteracao=1;
x=rand;   %valor inicial de x
while   iteracao <= 10   %para fazer 10 iteracoes
    x(iteracao+1)=exp(-x(iteracao));    %algoritmo da iteracao simples
    iteracao=iteracao+1;
    scatter(x,exp(-x)-x,'r');    %representacao grafica de cada um dos valores calculados por iteracao
end

text(0.6,0.1,['x = ',num2str(x(length(x)))])

x=x'   %vector com o valor inicial de x (x(1)) e os 10 valores de x calculados por iteracao simples
iteracao=iteracao-1

%ALINEA d
comparar = x(length(x)) - solucao_fzero   %diferenca entre o valor calculado na alinea c e o valor da alinea a

figure (5)
hold on
fplot('exp(-x)-x',[0,1])
scatter(x,exp(-x)-x,'r')
scatter(solucao_fzero,0,'b')

title('Comparacao fzero e iteracao simples')
text(0.6,0.5,['iteracao simples = ',num2str(x(length(x)))],'color','r')
text(0.6,0.35,['fzero = ',num2str(solucao_fzero)],'color','b')
text(0.6,0.1,['diferença  = ',num2str(comparar)])