function plot3D_det(S_dparameters,x)
    Deltap = S_dparameters.Deltap;
    
    betaD = 1;
    betaN = 100;
    beta_min = x(1)-betaD;
    beta_max = x(1)+betaD;
    beta = linspace(beta_min,beta_max,betaN);
    
    deltaD = 100;
    deltaN = 100;
    delta_min = x(2) - Deltap/deltaD;
    delta_max = x(2) + Deltap/deltaD;
    delta = linspace(delta_min,delta_max,deltaN);

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

    c = colormap(jet(length(delta)));
    detM = zeros(length(beta),length(delta));
    for i = 1:length(delta)
        alphamu  = 1 - 1i*(delta0 + delta(i))/gper;
        alphamum = 1 + 1i*(delta0 - delta(i))/gper;
        betamu   = 1 - 1i*delta(i)/gpar;

        for ii = 1:length(beta)
            M = get_M(n,Omegaa,omegan,omeganm,delta0,gamma0,Gamma0,Dth,N,alphamu,alphamum,betamu,beta(ii),delta(i));
            detM(ii,i) = det(M);
        end
    end
    Z = real(detM).^2 + imag(detM).^2;
    surf(real(delta),beta,Z); hold on;
    surf(real(delta),beta,zeros(length(beta),length(delta)));
    shading interp;
end