% LN08_M07_P26_G15

% Nuno Morgadinho n 26211
% Joao Plancha    n 30875


function p08
clc
clear all

loadfile1='C:\Documents and Settings\Nuno\My Documents\faculdade\lab_numerico\work\temperaturas.txt';
temp=load (loadfile1);
loadfile2='C:\Documents and Settings\Nuno\My Documents\faculdade\lab_numerico\work\precipitacao.txt'; 
prec=load (loadfile2);

X_30=[1:30];
Y_30m(:,1)=[1:30];
index=find(temp==-99);
normal_comp_temp=[11.5 12.6 14.6 15.6 17.8 20.9 22.9 23.3 22.1 18.6 14.9 12.4];
normal_comp_prec=[92.0 82.7 54.1 64.2 50.6 14.0 4.1 6.7 31.5 96.1 120.5 112.1];

%Usando interp1... opcao = 1

%temperatura
[Y_30m_temp,normal_temp] = normais(X_30,Y_30m,normal_comp_temp,temp,1);

%precipitacao
[Y_30m_prec,normal_prec] = normais(X_30,Y_30m,normal_comp_prec,prec,1);

%Normais Climaticas - alinea e
figure(1)
subplot(2,1,1)
bar(normal_temp')
title({'INTERPOLACAO LINEAR';'Normais Climaticas - Temperatura '})
xlabel('Mês')
ylabel('ºC')

subplot(2,1,2)
bar(normal_prec')
title('Normais Climaticas - Precipitacao')
xlabel('Mês')
ylabel('mm')

%alinea f

figure(2)
subplot(2,1,1)
plot(Y_30m_temp(:,2:13)')
title({'INTERPOLACAO LINEAR';'Series Temporais - Temperatura'})
xlabel('Mês')
ylabel('ºC')

subplot(2,1,2)
plot(Y_30m_prec(:,2:13)')
title('Series Temporais - Precipitacao')
xlabel('Mês')
ylabel('mm')

%Usando spline... opcao = 2 alinea g

%temperatura
[Y_30m_temp,normal_temp] = normais(X_30,Y_30m,normal_comp_temp,temp,2);

%precipitacao
[Y_30m_prec,normal_prec] = normais(X_30,Y_30m,normal_comp_prec,prec,2);

%Normais Climaticas - alinea e
figure(3)
subplot(2,1,1)
bar(normal_temp')
title({'SPLINE';'Normais Climaticas - Temperatura'})
xlabel('Mês')
ylabel('ºC')

subplot(2,1,2)
bar(normal_prec')
title('Normais Climaticas - Precipitacao')
xlabel('Mês')
ylabel('mm')

%alinea f

figure(4)
subplot(2,1,1)
plot(Y_30m_temp(:,2:13)')
title({'SPLINE';'Series Temporais - Temperatura'})
xlabel('Mês')
ylabel('ºC')

subplot(2,1,2)
plot(Y_30m_prec(:,2:13)')
title('Series Temporais  - Precipitacao')
xlabel('Mês')
ylabel('mm')


%Usando media... opcao = 2 alinea h e tambem alinea b
for n=2:13
indicet=find(temp(:,n)~=-99);
indicep=find(prec(:,n)~=-99);
tmedia(n-1)=mean(temp(indicet,n))
pmedia(n-1)=mean(prec(indicep,n));
end
tmedia(2,:)=normal_comp_temp(1,:);
pmedia(2,:)=normal_comp_prec(1,:);

figure(5)
subplot(2,1,1)
bar(tmedia')
title({'alinea h - medias';'Normais Climaticas - Temperatura'})
xlabel('Mês')
ylabel('ºC')

subplot(2,1,2)
bar(pmedia')
title('Normais Climaticas - Precipitacao')
xlabel('Mês')
ylabel('mm')

end

function [Y_30m,normal_tp] = normais(X_30,Y_30m,normal_comp,var,opcao) 

[n_linas n_colunas]=size(var);
for n=2:n_colunas

index=find(var(:,n)~=-99);    %encontra os indices dos valores medidos diferentes de -99 para cada mes

    if(var(1,n)==-99)
        var(1,n)=mean(var(index,n));
    end
    
    if(var(30,n)==-99)
        var(30,n)=mean(var(index,n));
    end

index=find(var(:,n)~=-99);   %encontra os indices dos valores medidos diferentes de -99 para cada mes
  
%faz a media so com os valores diferentes de -99
y=var(index,n);
if (opcao==1)
Y_30=interp1(index,y,X_30);
else
    if (opcao==2)
        Y_30=spline(index,y,X_30);
            
    end
end

Y_30m(:,n)=Y_30';

normal_tp(n-1)=mean(Y_30');
end

 normal_tp(2,:)=normal_comp(1,:);

end