function [x, z, xcol, zcol, xvor, zvor, normal] = ...
    Preprocess2D( filename )
%PREPROCESS2D Summary of this function goes here
% ����� �������:
% x, z - ���������� �� x, ���������� �� z.
% xcol � zcol - ���������� ����� ���������� �� x � z.
% xvor � zvor - ���������� ����� ��������� �����.
% normal - ������� Nx2: ������ ������ - ��� ���������� �-�� �������.
% ����:
% filename - ��� �����.

    % �������� ����������� �����. -1 ���� ����� ���.
    fid = fopen(filename,'r');
    % ������ ������ ������������ ������� (���������).
    lineRed = fgetl(fid);
    airfoilName = sscanf(lineRed,'%s');
    disp(airfoilName);

    % ������ ������. ������ �����.
    i = 1;
    lineRed = fgetl(fid);
    while(lineRed~=-1)
        currentPts = sscanf(lineRed,'%f');
        x(i) = currentPts(1);
        z(i) = currentPts(2);
        i = i+1;
        lineRed = fgetl(fid);
    end
    % �������� �����.
    fclose(fid);
    
    % ������������ ����� ��������� ����� (1-� �������� ������).
    ptsTotalNum = size(x,2);
    xvor = zeros(1,ptsTotalNum-1);
    zvor = zeros(1,ptsTotalNum-1);
    for i=1:ptsTotalNum-1
        xvor(i) = x(i)+(x(i+1)-x(i))/4;
        zvor(i) = z(i)+(z(i+1)-z(i))/4;
    end
    % ������������ ����� ���������� (3-� �������� ������).
    xcol = zeros(1,ptsTotalNum-1);
    zcol = zeros(1,ptsTotalNum-1);
    for i=1:ptsTotalNum-1
        xcol(i) = x(i)+3*(x(i+1)-x(i))/4;
        zcol(i) = z(i)+3*(z(i+1)-z(i))/4;
    end
    
    % ������������ ��� ��������� ������� ��� ������ ������.
    panelsTotalNum = ptsTotalNum-1;
    normal = zeros(panelsTotalNum,2);
    for i=1:panelsTotalNum
        L = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
        normal(i,1) = -(z(i+1)-z(i))/L;
        normal(i,2) = (x(i+1)-x(i))/L;
    end
    
    % ������ ����� ������� �����, ������ � ����������.
    f = figure(3);
    figure(f);
    plot(x,z,'s');
    hold on;
    plot(xvor,zvor,'o');
    plot(xcol,zcol,'+');
    daspect([1 1 1])
    % ������ �� ������ ��������.
    for i=1:panelsTotalNum
        L = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
        xline = [xcol(i) xcol(i)+normal(i,1)*L/5];
        zline = [zcol(i) zcol(i)+normal(i,2)*L/5];
        line(xline,zline);
    end
    hold on;
end