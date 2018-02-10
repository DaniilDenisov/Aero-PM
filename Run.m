function Run(Qinf, AngleOfAttack, rho, filename)

    [x, z, xcol, zcol, xvor, zvor, normal] = Preprocess2D( filename );
    [ Gamma ] = SolveDiscreteVortex2D( xvor, zvor, xcol, zcol, normal,...
        AngleOfAttack, Qinf );
    [ ~ ] = Postprocess2D( x, z, Gamma, rho, Qinf );

end