function [ Gamma ] = SolveDiscreteVortex2D( x, z, xcol, zcol, normal, angleOfAttack, Qinf )
% x, y - ���������� ����� ���������� (����� �����).
% xcol, zcol - ���������� ����� ����������.
% normal - ������ �������� � ������ ����������.
% angleOfAttack - ���� ����� �������������� ����������� ������.
% Qinf - �������� ����������� ������.
angleOfAttackRad = angleOfAttack*pi/180;
nPanels = size(normal,1);
% ������� ������������� ����� ����� ���������.
a = zeros(nPanels, nPanels);
for i=1:nPanels
    for j=1:nPanels
        [u, w] = Vortex2D(x(j), z(j), xcol(i), zcol(i), 1.0);
        a(i,j) = dot([u w], [normal(i,1) normal(i,2)]);
    end
end

% ������ ������ ����� (�������������).
RHS = zeros(nPanels,1);
% ���������� �������� ����������� ������.
Uinf = cos(angleOfAttackRad)*Qinf;
Winf = sin(angleOfAttackRad)*Qinf;
% ������ ������ �����. ����������.
for i=1:nPanels
    RHS(i) = dot([Uinf Winf], [normal(i,1) normal(i,2)]);
end

% ������� ���������.
Gamma = a\RHS;
end