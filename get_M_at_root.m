function M = get_M_at_root(seed,S_dparameters)
    n       = S_dparameters.n;
    gper    = S_dparameters.gper;
    gpar    = S_dparameters.gpar;
    Omegaa  = S_dparameters.Omegaa;
    omegan  = S_dparameters.omegan;
    omeganm = S_dparameters.omeganm;
    delta0  = S_dparameters.delta0;
    gamma0  = S_dparameters.gamma0;
    Gamma0  = S_dparameters.Gamma0;
    Dth     = S_dparameters.Dth;
    N       = length(omegan);

    beta = seed(1);
    Deltamu = seed(2);

    alphamu  = 1 - 1i*(delta0 + Deltamu)/gper;
    alphamum = 1 + 1i*(delta0 - Deltamu)/gper;
    betamu   = 1 - 1i*Deltamu/gpar;

    M = get_M(n,Omegaa,omegan,omeganm,delta0,gamma0,Gamma0,Dth,N,alphamu,alphamum,betamu,beta,Deltamu);
end