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
    disp(AngleOfAttack);
    disp([ DL,DM0,DMQC,CL,DP ]);
end