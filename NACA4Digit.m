function [ xu, xl, yu, yl, yc ] = NACA4Digit( m, p, xx, chord, nPanels )
% Функция строит 4-х значный профиль NACA по обозначению.
% M, P, XX - цифры из обозначения профиля (MPXX).
x = 0:chord/nPanels:chord;
nNodes = size(x,2);
% Вычисление средней линии и производной.
yc = zeros(nNodes,1);
dyc = zeros(nNodes,1);
p = (p/10)*chord;
m = (m/100)*chord;
for i=1:nNodes
    if 0<=x(i)&&x(i)<p
        yc(i) = (m/(p^2))*(2*p*x(i)-x(i)^2);
        dyc(i) = (2*m/(p^2))*(p-x(i));
    elseif p<=x(i)&&x(i)<=chord
        yc(i) = (m/((1-p)^2))*(1-2*p+2*p*x(i)-x(i)^2);
        dyc(i) = (2*m/((1-p)^2))*(p-x(i));
    end
end
% Вычисление распределения толщины над и под средней линией.
yt = zeros(nNodes,1);
t=xx/100;
for i=1:nNodes
    yt(i) = (t/0.2)*(0.2969*sqrt(x(i))-0.1260*x(i)-0.3516*(x(i)^2)+...
        0.2843*(x(i)^3)-0.1015*(x(i)^4));
end
% Вычисление координат верхней и нижней линии профиля.
xu = zeros(nNodes,1);
yu = zeros(nNodes,1);
xl = zeros(nNodes,1);
yl = zeros(nNodes,1);
for i=1:nNodes-1
    theta = atan(dyc(i));
    xu(i) = x(i)-yt(i)*sin(theta);
    yu(i) = yc(i)+yt(i)*cos(theta);
    xl(i) = x(i)-yt(i)*sin(theta);
    yl(i) = yc(i)-yt(i)*cos(theta);
end
xu(nNodes) = chord;
xl(nNodes) = chord;
yu(nNodes) = 0;
yl(nNodes) = 0;
% Plot.
plot(xu,yu);
hold on;
plot(xl,yl);
plot(x,yc);
daspect([1 1 1])
end
