% Programa do disco
function main
clc
clear all
close all
xc=2;
yc=0;
a=4;
b=2;
r=0.5;
res1=montedocarlos(xc,yc,r,a,b,10);
res2=montedocarlos(xc,yc,r,a,b,100);
res3=montedocarlos(xc,yc,r,a,b,1000);

end
function  [massa xcm ycm Vdisco]= montedocarlos(xc,yc,r,a,b,n)


xlen=a*2;
ylen=b*2;
zlen=0.2;

ro=0.0074;

figure(1)
hold on
axis([-a a -a a])
%ellipse(a,b,0,0,0);
%ellipse(r,r,0,xc,yc);

Sro=0; Sro2=0; Sx=0; Sx2=0; Sy=0; Sy2=0; Sz=0; Sz2=0;

for k=1:n
    X=-a+xlen*rand(1);
    Y=-b+ylen*rand(1);
    Z=zlen*rand(1);

   
    if((((X)/4)^2+((Y)/2)^2<=1) & ((X-xc)^2+(Y-yc)^2>=r))
        Sro=Sro+ro;
        Sro2=Sro2+ro^2;
        Sx=Sx+ro*X;
        Sx2=Sx2+(ro*X)^2;
        Sy=Sy+ro*Y;
        Sy2=Sy2+(ro*Y)^2;
        Sz=Sz+ro*Z;
        Sz2=Sz2+(ro*Z)^2;
        scatter(X,Y,7,'r');
    end
    
end

Sro=Sro/n;
Sro2=Sro2/n;
Sx=Sx/n; Sx2=Sx2/n;
Sy=Sy/n; Sy2=Sy2/n;
Sz=Sz/n; Sz2=Sz2/n;

V=xlen*ylen*zlen;
massa=V*Sro;
erro=V*sqrt((Sro2-Sro^2)/n);
Vdisco=massa/ro;

%centro de massa
XCM=V*Sx/massa; errox=V*sqrt((Sx2-Sx^2)/n);
YCM=V*Sy/massa; erroy=V*sqrt((Sy2-Sy^2)/n);
ZCM=V*Sz/massa; erroz=V*sqrt((Sz2-Sz^2)/n);

fprintf('n=%d \n Volume do disco=%.4f cm^3 \t Massa=%.4f \t Erro=%.4f (Erro relativo=%.4f )\n ', n, Vdisco, massa, erro, erro/Vdisco)
fprintf('Centro de massa: \n\tx=%.4f cm +- %.4f  \n\ty=%.4f cm +- %.4f \n\tz=%.4f cm +- %.4f \n',XCM, errox, YCM, erroy, ZCM,erroz)

end