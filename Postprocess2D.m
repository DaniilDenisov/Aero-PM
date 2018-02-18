function [ DL,DM0,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho,...
    Qinf, alpha )
%POSTPROCESS2D Summary of this function goes here
nPanels = size(x,2)-1;
% �������� ����� � �������� �����.
chord = max(x)-min(x);
quChord = chord/4;
% ��������������: ��������� ���� � ������� ��������
% �� ��������� ����������.
deltaL = zeros(1,nPanels);
deltaP = zeros(1,nPanels);
deltaM0 = zeros(1,nPanels);
deltaMQC = zeros(1,nPanels);
for i=1:nPanels
    % ��������� ����.
    deltaL(i) = rho*Qinf*Gamma(i,1);
    % ������ �� �����.
    deltaM0(i) = deltaL(i)*(x(i)*cos(alpha*pi/180));
    % ������ �� 1/4 �����.
    deltaMQC(i) = deltaL(i)*((x(i)-quChord)*cos(alpha*pi/180));
    % dc = ����� ������.
    dc = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
    % ������� �������� �� ������.
    deltaP(i) = rho*Qinf*Gamma(i,1)/dc;
end
%���������� ��������� ���� � ������� ������������ �����.
DL = sum(deltaL);
DM0 = sum(deltaM0);
DMQC = sum(deltaMQC);
%���������� ������������ �� (�L).
CL = sum(deltaL)/(0.5*rho*(Qinf^2)*chord);
%���������� �������� ��������.
DP = sum(deltaP);
end