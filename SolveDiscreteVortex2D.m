function [ Gamma ] = SolveDiscreteVortex2D( x, z, xcol, zcol, normal, angleOfAttack, Qinf )
%SOLVEDISCRETEVORTEX2D Summary of this function goes here

angleOfAttack = angleOfAttack*pi/180;
nPanels = size(normal,1);

% Матрица коэффициентов левой части уравнения.
a = zeros(nPanels, nPanels);
for i=1:nPanels
    for j=1:nPanels
        [u, w] = VOR2D(xcol(i), zcol(i), x(j), z(j), 1.0);
        a(i,j) = dot([u w], [normal(i,1) normal(i,2)]);
    end
end

% Вектор правой части (инициализация).
RHS = zeros(nPanels,1);
% Компоненты скорости набегающего потока.
Uinf = cos(angleOfAttack)*Qinf;
Winf = sin(angleOfAttack)*Qinf;
% Вектор правой части. Вычисление.
for i=1:nPanels
    RHS(i) = -dot([Uinf Winf], [normal(i,1) normal(i,2)]);
end

% Решение уравнения.
Gamma = a\RHS;

end

