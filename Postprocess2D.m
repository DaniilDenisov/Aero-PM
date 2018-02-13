function [ DL,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf )
%POSTPROCESS2D Summary of this function goes here
nPanels = size(x,2)-1;
% Постпроцессинг: подъемная сила и перепад давления
% по найденной циркуляции.
deltaL = zeros(1,nPanels);
deltaP = zeros(1,nPanels);
for i=1:nPanels
    deltaL(i) = rho*Qinf*Gamma(i,1);
    % dc = длина панели.
    dc = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
    deltaP(i) = rho*Qinf*Gamma(i,1)/dc;
end
%Переменная подъемной силы.
DL = sum(deltaL);
%Переменная коэффициента ПС (СL).
chord = max(x)-min(x);
CL = sum(deltaL)/(0.5*rho*(Qinf^2)*chord);
%Переменная перепада давления.
DP = sum(deltaP);
end