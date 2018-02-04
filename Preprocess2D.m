function [ x, z, xcol, zcol, normal ] = Preprocess2D( filename )
%PREPROCESS2D Summary of this function goes here
% ����� �������:
% x, z - ���������� �� x, ���������� �� z.
% xcol � zcol - ���������� ����� ���������� �� x � z.
% ����:
% filename - ��� �����.

    % �������� ����������� �����. -1 ���� ����� ���.
    fid = fopen(filename,'r');
    % ������ ������ ������������ ������� (���������).
    line = fgetl(fid);
    airfoilName = sscanf(line,'%s');
    disp(airfoilName);

    % ������ ������. ������ �����.
    i = 1;
    line = fgetl(fid);
    while(line~=-1)
        currentPts = sscanf(line,'%f');
        x(i) = currentPts(1);
        z(i) = currentPts(2);
        i = i+1;
        line = fgetl(fid);
    end
    % �������� �����.
    fclose(fid);
    
    % ������������ ����� ���������� (�������� ������).
    ptsTotalNum = size(x,2);
    xcol = zeros(1,ptsTotalNum-1);
    zcol = zeros(1,ptsTotalNum-1);
    for i=1:ptsTotalNum-1
        xcol(i) = x(i)+(x(i+1)-x(i))/2;
        zcol(i) = z(i)+(z(i+1)-z(i))/2;
    end
    
    % ������������ ��� ��������� ������� ��� ������ ������.
    panelsTotalNum = ptsTotalNum-1;
    normal = zeros(panelsTotalNum,2);
    for i=1:panelsTotalNum
        L = sqrt((x(i+1)-x(i))^2+(z(i+1)-z(i))^2);
        normal(i,1) = (z(i+1)-z(i))/L;
        normal(i,2) = (x(i+1)-x(i))/L;
    end
    
end