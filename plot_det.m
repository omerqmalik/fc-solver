function plot_det(S_dparameters,x)
    Deltap = S_dparameters.Deltap;
    
    beta_min = x(1)-1;
    beta_max = x(1)+1;
    beta = linspace(beta_min,beta_max,100);
    
    delta_min = x(2) - Deltap/100;
    delta_max = x(2) + Deltap/100;
    delta = linspace(delta_min,delta_max,100);

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
    for i = 1:length(delta)
        alphamu  = 1 - 1i*(delta0 + delta(i))/gper;
        alphamum = 1 + 1i*(delta0 - delta(i))/gper;
        betamu   = 1 - 1i*delta(i)/gpar;

        detM = zeros(1,length(beta));
        for ii = 1:length(beta)
            M = get_M(n,Omegaa,omegan,omeganm,delta0,gamma0,Gamma0,Dth,N,alphamu,alphamum,betamu,beta(ii),delta(i));
            detM(ii) = det(M);
        end    
        plot(beta,real(detM),'color',c(i,:));
        hold on;
        plot(beta,imag(detM),'color',c(i,:));
    end
end