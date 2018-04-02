function Vel = PlotVelocity2D( xvor, zvor, Gamma, ptx, ptz)
% ������ �� ������ ��������� �� ������ �������.
% xvor, zvor - ����� �����,
% Gamma - �������� ���������� � ������ �����.
% ptx, ptz - ���������� ������� ����� (��� ������. ��������) x � z.

% ���-�� ����� �����.
vortexPtsNum = size(xvor,2);
% ������������� ������� ��������.
Vel = [0 0];
% �� ���� ������ ����� ������� � ��������� ������.
for i=1:vortexPtsNum
    [tmpU, tmpV] = Vortex2D(ptx, ptz, xvor(i), zvor(i), Gamma(i));
    Vel(1) = Vel(1) + tmpU;
    Vel(2) = Vel(2) + tmpV;
end

end
