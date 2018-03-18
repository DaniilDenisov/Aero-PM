function Run(Qinf, AngleOfAttack, rho, filename)
% ����� �������� ������������� ������� � ����� filename.
% [ xu, xl, yu, yl, yc, x ] = NACA4Digit( 6, 4, 09, 10, 2);
% ������ ������ �������.
% Run(2, 0, 1.225, 'tmpFoil.txt');
% Qinf - �������� �������������� ����������� ������.
% AngleOfAttack - ���� ����� ������.
% rho - ��������� �������.
% filename - ��������������� NACA4Digit ���� ������� (�������� tmpFoil.txt).
    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol, normal,...
        AngleOfAttack, Qinf );
    [ DL,DM0,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf, AngleOfAttack );
    disp(AngleOfAttack);
    disp([ DL,DM0,DMQC,CL,DP ]);
end