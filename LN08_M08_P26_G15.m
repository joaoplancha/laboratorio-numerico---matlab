% LN08_M08_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875


function p08
clc
clear all
close all

f1 = 1e2;
f2 = 1e3;
f3 = 1e4;
t = [0:1e-5:0.02];                   %serie temporal 
[l,n]=size(t);
%emendar
%for noise=0:1
noise=0;
x=sin (2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t)+noise*(rand(1,n)-0.5);

y1=MediaMovel(x,11);
y2=x-y1;
y3=MediaMovel(y1,101);
y4=y1-y3;

figure(1)
subplot(5,1,1)
plot(t,x)
title({'Ruido = 0';'X = serie temporal original'})
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,2)
plot(t,y1)
title('Y1 = Filtro passa baixo do X')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,3)
plot(t,y2)
title('Y2 = Filtro passa alto do X')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,4)
plot(t,y3)
title('Y3 = Filtro passa baixo do Y1')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,5)
plot(t,y4)
title('Y4 = Filtro passa alto do Y1')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

noise = 1;

x=sin (2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t)+noise*(rand(1,n)-0.5);

y1=MediaMovel(x,11);
y2=x-y1;
y3=MediaMovel(y1,101);
y4=y1-y3;

figure(2)
subplot(5,1,1)
plot(t,x)
title({'Ruido ~= 0';'X = serie temporal original'})
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,2)
plot(t,y1)
title('Y1 = Filtro passa baixo do X')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,3)
plot(t,y2)
title('Y2 = Filtro passa alto do X')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,4)
plot(t,y3)
title('Y3 = Filtro passa baixo do Y1')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

subplot(5,1,5)
plot(t,y4)
title('Y4 = Filtro passa alto do Y1')
axis([0 0.02 -3 3])
ylabel('x')
xlabel('tempo(s)')

%end
end

function [y]=MediaMovel(x,mm)
[lin,N]=size(x);
y(1,1:N)= NaN;
filtro=ones(1,mm)/mm;
mm2=(mm-1)/2;                          %assume-se que MM é impar
for j=mm2+1:N-mm2
    y(j)=0;
       for k=-mm2:1:mm2
           y(j)=y(j)+x(j-k)*filtro(k+mm2+1);
       end
       
end
return
end
       
        
%Y(1,1:N)=NaN;