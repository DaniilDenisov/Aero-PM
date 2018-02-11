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
%Печать подъемной силы.
disp('Подъемная сила');
DL = sum(deltaL);
disp(DL);
% Печать коэффициента ПС (СL).
disp('Коэфф. ПС (CL)');
chord = max(x)-min(x);
CL = sum(deltaL)/(0.5*rho*(Qinf^2)*chord);
disp (CL);
%Печать перепада давления.
disp('Перепад давления');
DP = sum(deltaP);
disp(DP);
end