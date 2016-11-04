function M = get_M(n,Omegaa,omegan,omeganm,delta0,gamma0,Gamma0,Dth,N,alphamu,alphamum,betamu,beta,Deltamu)
    ess  = sqrt((beta-1)/Gamma0);
    gmu  = alphamum*ess^2*Dth/(2*alphamu*alphamum*betamu + (alphamu + alphamum)*ess^2);
    gmum = alphamu*ess^2*Dth/(2*alphamu*alphamum*betamu + (alphamu + alphamum)*ess^2);

    amu  = ones(1,N)*(Deltamu + delta0 + Omegaa/2 + Omegaa*gmu*conj(gamma0)/2/real(n)^2) - omegan.^2/2/Omegaa;
    Amu  = 1i*Omegaa*(gmu-Dth)/2/real(n)^2/alphamu;
    Amat = diag(amu) + ones(N,N)*Amu;

    amum  = ones(1,N)*(-Deltamu + delta0 + Omegaa/2 + Omegaa*gmum*gamma0/2/real(n)^2) - conj(omeganm).^2/2/Omegaa;
    Amum  = -1i*Omegaa*(gmum-Dth)/2/real(n)^2/alphamum;
    Amatm = diag(amum) + ones(N,N)*Amum;

    bmu  = ones(1,N)*(Omegaa*gmu*gamma0/2/real(n)^2);
    Bmu  = -1i*Omegaa*gmu/2/real(n)^2/alphamum;
    Bmat = diag(bmu) + ones(N,N)*Bmu;

    bmum  = ones(1,N)*(Omegaa*gmum*conj(gamma0)/2/real(n)^2);
    Bmum  = 1i*Omegaa*gmum/2/real(n)^2/alphamu;
    Bmatm = diag(bmum) + ones(N,N)*Bmum;

    Mtop = [Amat -Bmat];
    Mbot = [-Bmatm Amatm];
    M    = [Mtop; Mbot];
end