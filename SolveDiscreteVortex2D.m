function [ Gamma ] = SolveDiscreteVortex2D( x, z, xcol, zcol, normal, angleOfAttack, Qinf )
%SOLVEDISCRETEVORTEX2D Summary of this function goes here

angleOfAttack = angleOfAttack*pi/180;
nPanels = size(normal,1);

% ������� ������������� ����� ����� ���������.
a = zeros(nPanels, nPanels);
for i=1:nPanels
    for j=1:nPanels
        [u, w] = VOR2D(xcol(i), zcol(i), x(j), z(j), 1.0);
        a(i,j) = dot([u w], [normal(i,1) normal(i,2)]);
    end
end

% ������ ������ ����� (�������������).
RHS = zeros(nPanels,1);
% ���������� �������� ����������� ������.
Uinf = cos(angleOfAttack)*Qinf;
Winf = sin(angleOfAttack)*Qinf;
% ������ ������ �����. ����������.
for i=1:nPanels
    RHS(i) = -dot([Uinf Winf], [normal(i,1) normal(i,2)]);
end

% ������� ���������.
Gamma = a\RHS;

end

