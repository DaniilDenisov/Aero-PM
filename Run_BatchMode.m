function Run_BatchMode(Qinf, AngleOfAttackArr, rho, filename)
%[ xu, xl, yu, yl, yc, x ] = NACA4Digit( 2, 4, 15, 10, 2);
% Run_BatchMode(2, [-5 0 5 10]', 1.225, 'tmpFoil.txt')
    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    % Число углов атаки.
    aaNum = size(AngleOfAttackArr,1);
    % Массив для выходных значений DL,DM,DMQC,CL,DP на всех углах атаки.
    PPARR = zeros(aaNum,5);
    for i=1:aaNum
        [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol,...
            normal, AngleOfAttackArr(i), Qinf );
        [ DL,DM,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf,...
            AngleOfAttackArr(i) );
        PPARR(i,1) = PPARR(i,1) + DL;
        PPARR(i,2) = PPARR(i,2) + DM;
        PPARR(i,3) = PPARR(i,3) + DMQC;
        PPARR(i,4) = PPARR(i,4) + CL;
        PPARR(i,5) = PPARR(i,5) + DP;
    end
    f = figure(2);
    % График коэффициента ПС.
    figure(f);
    subplot(1,3,1);
    plot(AngleOfAttackArr, PPARR(:,3));
    title('CL(a)');
    xlabel('Angle of attack');
    ylabel('CL');
    grid on;
    % График момента относительно Leading Edge.
    subplot(1,3,2);
    plot(AngleOfAttackArr, PPARR(:,2));
    title('MLE(a)');
    xlabel('Angle of attack');
    ylabel('MLE');
    grid on;
    % График момента относительно Quarter Chord.
    subplot(1,3,3);
    plot(AngleOfAttackArr, PPARR(:,3));
    title('MQC(a)');
    xlabel('Angle of attack');
    ylabel('MQC');
    grid on;
end