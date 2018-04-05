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
    disp('Angle of attack:');
    disp(AngleOfAttack);
    disp('Lift, Moment, Moment1/4chord, LiftCoeff, PressureDiff:');
    disp([ DL,DM0,DMQC,CL,DP ]);
    % ���������� �������� ������ ��� ��������.
    ptx = 0:0.1*max(x):max(x);
    ptz = 0.25*ones(1,size(ptx,2));
    VelT = zeros(size(ptx,2),2);
    for i=1:size(ptx,2)
        VelT(i,:) = PlotVelocity2D( xvor, zvor, Gamma, ptx(i), ptz(i));
    end 
    disp('Velocities:');
    disp(VelT);
    % ���������� �������� ����� ��� ��������.
    ptz = -0.25*ones(1,size(ptx,2));
    VelB = zeros(size(ptx,2),2);
    for i=1:size(ptx,2)
        VelB(i,:) = PlotVelocity2D( xvor, zvor, Gamma, ptx(i), ptz(i));
    end 
    disp(VelB);
end