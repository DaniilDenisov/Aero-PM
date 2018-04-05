function Run(Qinf, AngleOfAttack, rho, filename)
% Перед запуском сгенерировать профиль в файле filename.
% [ xu, xl, yu, yl, yc, x ] = NACA4Digit( 6, 4, 09, 10, 2);
% Запуск данной функции.
% Run(2, 0, 1.225, 'tmpFoil.txt');
% Qinf - скорость невозмущенного набегающего потока.
% AngleOfAttack - угол атаки потока.
% rho - плотность воздуха.
% filename - сгенерированный NACA4Digit файл профиля (например tmpFoil.txt).
    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol, normal,...
        AngleOfAttack, Qinf );
    [ DL,DM0,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf, AngleOfAttack );
    disp('Angle of attack:');
    disp(AngleOfAttack);
    disp('Lift, Moment, Moment1/4chord, LiftCoeff, PressureDiff:');
    disp([ DL,DM0,DMQC,CL,DP ]);
    % Вычисление скорости сверху над профилем.
    ptx = 0:0.1*max(x):max(x);
    ptz = 0.25*ones(1,size(ptx,2));
    VelT = zeros(size(ptx,2),2);
    for i=1:size(ptx,2)
        VelT(i,:) = PlotVelocity2D( xvor, zvor, Gamma, ptx(i), ptz(i));
    end 
    disp('Velocities:');
    disp(VelT);
    % Вычисление скорости снизу под профилем.
    ptz = -0.25*ones(1,size(ptx,2));
    VelB = zeros(size(ptx,2),2);
    for i=1:size(ptx,2)
        VelB(i,:) = PlotVelocity2D( xvor, zvor, Gamma, ptx(i), ptz(i));
    end 
    disp(VelB);
end