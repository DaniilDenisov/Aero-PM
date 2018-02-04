function Run(Qinf, AngleOfAttack, rho, filename)

    [ x, z, xcol, zcol, normal ] = Preprocess2D( filename );
    [ Gamma ] = SolveDiscreteVortex2D( x, z, xcol, zcol, normal,...
        AngleOfAttack, Qinf );
    [ ~ ] = Postprocess2D( x, z, Gamma, rho, Qinf );

end