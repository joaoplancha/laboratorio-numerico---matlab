% LN08_M03_P26_G15
% Nuno Morgadinho nº 26211  
% Joao Plancha    nº 30875

function main
clc
clear all
close all
%centro do disco relativamente ao centro da elipse
xc=2;
yc=0;

%semi-eixos maior e menor da elipse
a=4;
b=2;

%raio do disco
r=0.5;
n=1000;

%iniciacao do ciclo que chama a funcao monte carlo e incrementa o numero de
%pontos ate n*100 pontos.

for i=1:3       
    
    %apresentacao de 3 graficos com os pontos calculados
    %figure(i)
    %hold on
    %axis([-a a -a a])
    
    %chamada da funcao monte carlo
    montecarlo(xc,yc,r,a,b,n);
    
    %aumento em uma ordem de grandeza do numero de pontos
    n=n*10;
    end
end


%funcao montecarlo
%recebe as coordenadas do centro do disco (xc,yc) relativamente ao centro
%da elipse, o raio do disco (r), os semi-eixos maior e menor da elipse 
%(a,b), e o numero de pontos para os quais e efectuado o calculo (n)
%retorna a massa (m), o centro de massa (xcm,ycm) e o volume da elipse
%(Velipse)
%note-se que a elipse vai ser colocada posteriormente no (0,0)
function  [massa, xcm, ycm, Velipse]= montecarlo(xc,yc,r,a,b,n)  
%inicialização do contador de tempo
tini=cputime;

%definição do paralelipipedo que contem a elipse
xlen=a*2;
ylen=b*2;
zlen=0.2;

%densidade da elipse em kg/cm^3
ro=0.0074;

%inicialização dos somatórios usados no algoritmo
Sro=0; Sro2=0; Sx=0; Sx2=0; Sy=0; Sy2=0; Sz=0; Sz2=0;

%calculo de n pontos usando um numero aleatorio entre 0 e 1
%sao calculadas as 3 coordenadas espaciais de cada ponto usando as
%dimensoes do rectangulo definido anteriormente
for k=1:n
    X=-a+xlen*rand(1);
    Y=-b+ylen*rand(1);
    Z=zlen*rand(1);

% condicao que impede que os pontos calculados dentro do rectangulo, mas
% fora das dimensoes da elipse sem o disco de raio r, entrem nos calculos
% com o monte carlo
%a elipse e centrada na origem do referencial
    if((((X)/4)^2+((Y)/2)^2<=1) & ((X-xc)^2+(Y-yc)^2>=r^2)) 
        
        %caso os pontos caiam dentro da elipse excluindo o disco,  vamos
        %executar os somatorios que serao usados para determinar o <f> e o
        %<f^2> a usar no metodo de monte carlo
        
        Sro=Sro+ro;
        Sro2=Sro2+ro^2;
        Sx=Sx+ro*X;
        Sx2=Sx2+(ro*X)^2;
        Sy=Sy+ro*Y;
        Sy2=Sy2+(ro*Y)^2;
        Sz=Sz+ro*Z;
        Sz2=Sz2+(ro*Z)^2;
        %scatter(X,Y,7,'r');
    end
    
end

%determinacao do <f> e <f^2>
Sro=Sro/n;
Sro2=Sro2/n;
Sx=Sx/n; Sx2=Sx2/n;
Sy=Sy/n; Sy2=Sy2/n;
Sz=Sz/n; Sz2=Sz2/n;

V=xlen*ylen*zlen;              %volume do paralelipipedo
massa=V*Sro;                   %calculo da massa da elipse
erro=V*sqrt((Sro2-Sro^2)/n);   %calculo do erro pelo metodo de monte carlo
Velipse=massa/ro;              %volume da elipse atraves da densidade
erroeli=erro/ro;               %calculo do erro do volume da elipse

%calculo do centro de massa e do erro absoluto respectivo
XCM=V*Sx/massa; errox=V*sqrt((Sx2-Sx^2)/n);     
YCM=V*Sy/massa; erroy=V*sqrt((Sy2-Sy^2)/n);
ZCM=V*Sz/massa; erroz=V*sqrt((Sz2-Sz^2)/n);

%Apresentacao dos resultados pedidos no ecra e calculo do erro relativo
fprintf('\nn=%d \nMassa da elipse = %.6f kg Erro=%.6f (Erro relativo=%.6f)\n ', n, massa, erro, erro/massa)
fprintf('\nVolume da elipse = %.6f cm^3 Erro=%.6f (Erro relativo=%.6f)\n ', Velipse, erroeli, erroeli/Velipse)
fprintf('\nCentro de massa: \n\tx = %.6f cm Erro=%.6f Eerro relativo: %.6f) \n\ty = %.6f cm +- %.6f (erro relativo: %.6f) \n\tz = %.6f cm +- %.6f (erro relativo: %.6f) \n\n',XCM, errox, errox/xlen, YCM, erroy, erroy/ylen, ZCM,erroz, erroz/zlen)
fprintf('Tempo de calculo: %.5f s \n',(cputime-tini));
end