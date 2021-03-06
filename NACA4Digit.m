function [ xu, xl, yu, yl, yc, x ] = NACA4Digit( m, p, xx, nPanels, c)
% ������� ������ 4-� ������� ������� NACA �� �����������.
% M, P, XX - ����� �� ����������� ������� (MPXX).
chord = 1;
x = 0:chord/nPanels:chord;
nNodes = size(x,2);
% ���������� ������� ����� � �����������.
yc = zeros(nNodes,1);
dyc = zeros(nNodes,1);
p = (p/10)*chord;
m = (m/100)*chord;
for i=1:nNodes
    if 0<=x(i)&&x(i)<p
        yc(i) = (m/(p^2))*(2*p*x(i)-x(i)^2);
        dyc(i) = (2*m/(p^2))*(p-x(i));
    elseif p<=x(i)&&x(i)<=chord
        yc(i) = (m/((1-p)^2))*(1-2*p+2*p*x(i)-x(i)^2);
        dyc(i) = (2*m/((1-p)^2))*(p-x(i));
    end
end
% ���������� ������������� ������� ��� � ��� ������� ������.
yt = zeros(nNodes,1);
t=xx/100;
for i=1:nNodes
    yt(i) = (t/0.2)*(0.2969*sqrt(x(i))-0.1260*x(i)-0.3516*(x(i)^2)+...
        0.2843*(x(i)^3)-0.1015*(x(i)^4));
end
% ���������� ��������� ������� � ������ ����� �������.
xu = zeros(nNodes,1);
yu = zeros(nNodes,1);
xl = zeros(nNodes,1);
yl = zeros(nNodes,1);
for i=1:nNodes-1
    theta = atan(dyc(i));
    xu(i) = x(i)-yt(i)*sin(theta);
    yu(i) = yc(i)+yt(i)*cos(theta);
    xl(i) = x(i)-yt(i)*sin(theta);
    yl(i) = yc(i)-yt(i)*cos(theta);
end
xu(nNodes) = chord;
xl(nNodes) = chord;
yu(nNodes) = 0;
yl(nNodes) = 0;
% ��������������� �����������.
xu = xu*c;
xl = xl*c;
yu = yu*c;
yl = yl*c;
yc = yc*c;
x = x*c;
% Plot.
plot(xu,yu);
hold on;
plot(xl,yl);
plot(x,yc);
daspect([1 1 1])
hold off;
% ���������� ������� ����� � ����.
fileID = fopen('tmpFoil.txt','w');
fprintf(fileID,'%s\n',strcat('NACA',num2str(m*100),num2str(p*10),...
    num2str(xx)));
tmpData = [x;yc'];
fprintf(fileID,'%6.4f %6.4f\r\n',tmpData);
fclose(fileID);
% ���������� ����� ������� � ���� ������� selig.
fileID = fopen('tmpFoilSelig.txt','w');
fprintf(fileID,'%s\n',strcat('NACA',num2str(m*100),num2str(p*10),...
    num2str(xx)));
tmpData = [fliplr(xu');fliplr(yu')];
fprintf(fileID,'%6.4f %6.4f\r\n',tmpData);
tmpData = [xl';yl'];
tmpData(:,1)=[];
fprintf(fileID,'%6.4f %6.4f\r\n',tmpData);
fclose(fileID);
end
