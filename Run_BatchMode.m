function Run_BatchMode(Qinf, AngleOfAttackArr, rho, filename)
%[ xu, xl, yu, yl, yc, x ] = NACA4Digit( 2, 4, 15, 10, 2);
% Run_BatchMode(2, [-5 0 5 10]', 1.225, 'tmpFoil.txt')
    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    % Число углов атаки.
    aaNum = size(AngleOfAttackArr,1);
    % Массив для выходных значений DL,CL,DP на всех углах атаки.
    DLCLDP = zeros(aaNum,3);
    for i=1:aaNum
        [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol,...
            normal, AngleOfAttackArr(i), Qinf );
        [ DL,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf );
        DLCLDP(i,1) = DLCLDP(i,1) + DL;
        DLCLDP(i,2) = DLCLDP(i,2) + CL;
        DLCLDP(i,3) = DLCLDP(i,3) + DP;
    end
    figure
    plot(AngleOfAttackArr, DLCLDP(:,2));
    grid on;
end