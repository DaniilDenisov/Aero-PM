function [ DL,DM0,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho,...
    Qinf, alpha )
% DL - сумм. подъемная сила профиля.
% DM0 - сумм. аэродинамический момент относительно носка профиля.
% DMQC - сумм. аэродинамический момент относительно 1/4 хорды.
% CL - коэффициент подъемной силы профиля.
% DP - суммарная разница давлений между в. и н. поверхностью профиля.
% x,z - координаты точек хорды (для метода дискретных вихрей).
% Gamma - определенные решателем значения циркуляций в дискретных вихрях.
% rho - плотность воздуха.
% Qinf, alpha - скорость невозмущенного потока и угол установки (атаки).

nPanels = size(x,2)-1;
% Величина хорды и четверти хорды.
chord = max(x)-min(x);
quChord = chord/4;
% Постпроцессинг: подъемная сила и перепад давления
% по найденной циркуляции.
deltaL = zeros(1,nPanels);
deltaP = zeros(1,nPanels);
deltaM0 = zeros(1,nPanels);
deltaMQC = zeros(1,nPanels);
for i=1:nPanels
    % Подъемная сила.
    deltaL(i) = rho*Qinf*Gamma(i,1);
    % Момент от носка.
    deltaM0(i) = deltaL(i)*(x(i)*cos(alpha*pi/180));
    % Момент от 1/4 хорды.
    deltaMQC(i) = deltaL(i)*((x(i)-quChord)*cos(alpha*pi/180));
    % dc = длина панели.
    dc = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
    % Перепад давления на панели.
    deltaP(i) = rho*Qinf*Gamma(i,1)/dc;
end
%Переменная подъемной силы и момента относительно носка и 1/4 хорды.
DL = sum(deltaL);
DM0 = sum(deltaM0);
DMQC = sum(deltaMQC);
%Переменная коэффициента ПС (СL).
CL = sum(deltaL)/(0.5*rho*(Qinf^2)*chord);
%Переменная перепада давления.
DP = sum(deltaP);

end