function [ deltaL ] = Postprocess2D( x, z, Gamma, rho, Qinf )
%POSTPROCESS2D Summary of this function goes here
nPanels = size(x,2)-1;
% ��������������: ��������� ���� � ������� ��������
% �� ��������� ����������.
deltaL = zeros(1,nPanels);
deltaP = zeros(1,nPanels);
for i=1:nPanels
    deltaL(i) = rho*Qinf*Gamma(i,1);
    % dc = ����� ������.
    dc = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
    deltaP(i) = rho*Qinf*Gamma(i,1)/dc;
end
%disp(deltaL);
disp('��������� ����');
disp(sum(deltaL));
disp('CL');
chord = max(x)-min(x);
disp (sum(deltaL)/(0.5*rho*(Qinf^2)*chord));
%disp(deltaP);
disp('������� ��������');
disp(sum(deltaP));
end