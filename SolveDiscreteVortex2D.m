function [ Gamma ] = SolveDiscreteVortex2D( x, z, xcol, zcol, normal, angleOfAttack, Qinf )
% x, y - координаты точек вычислени€ (точки вихр€).
% xcol, zcol - координаты точек коллокации.
% normal - вектор нормалей в точках коллокации.
% angleOfAttack - угол атаки невозмущенного набегающего потока.
% Qinf - скорость набегающего потока.
angleOfAttackRad = angleOfAttack*pi/180;
nPanels = size(normal,1);
% ћатрица коэффициентов левой части уравнени€.
a = zeros(nPanels, nPanels);
for i=1:nPanels
    for j=1:nPanels
        [u, w] = Vortex2D(x(j), z(j), xcol(i), zcol(i), 1.0);
        a(i,j) = dot([u w], [normal(i,1) normal(i,2)]);
    end
end

% ¬ектор правой части (инициализаци€).
RHS = zeros(nPanels,1);
%  омпоненты скорости набегающего потока.
Uinf = cos(angleOfAttackRad)*Qinf;
Winf = sin(angleOfAttackRad)*Qinf;
% ¬ектор правой части. ¬ычисление.
for i=1:nPanels
    RHS(i) = dot([Uinf Winf], [normal(i,1) normal(i,2)]);
end

% –ешение уравнени€.
Gamma = a\RHS;
end