function Run(Qinf, AngleOfAttack, rho, filename)
    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol, normal,...
        AngleOfAttack, Qinf );
    [ DL,DM0,DMQC,CL,DP ] = Postprocess2D( x, z, Gamma, rho, Qinf, AngleOfAttack );
    disp(AngleOfAttack);
    disp([ DL,DM0,DMQC,CL,DP ]);
end