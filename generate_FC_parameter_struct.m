function S_dparameters = generate_FC_parameter_struct(param_vecs)
    %units:
	%delta0 (unitless, delta0*L/c)
    S_dparameters = struct('tooth',[],'neighbors',[],'n',[],'gper',[], ...
        'gpar',[],'Omegaa',[],'Deltap',[],'omegan',[],'omeganm',[], ...
        'delta0',[],'gamma0',[],'Gamma0',[],'Dth',[],'L',[], ...
        'valid2b2',[],'Na',[]);

    leN = size(param_vecs,1);
    S_dparameters(leN).tooth = [];

    parfor i = 1:leN
        tooth     = param_vecs(i,1);
        neighbors = param_vecs(i,2);
        n         = param_vecs(i,3);
        gper      = param_vecs(i,4);
        gpar      = param_vecs(i,5);

%         Omegaa    = param_vecs(i,6);
%         Na        = get_Na_from_Omegaa(Omegaa,n);
        
        Na        = param_vecs(i,6);
        Omegaa    = get_Omegaa_from_nI(n,Na);

        Deltap    = get_RING_Deltap(n);
        omega0    = Na*Deltap;
        nu0       = real(omega0);
        kappa0    = -imag(omega0);
        delta0    = -gper*(Omegaa^2 - nu0^2 + kappa0^2)/2/(gper*Omegaa + nu0*kappa0);
        gamma0    = -1i*gper/(gper - 1i*delta0);
        Gamma0    = gper^2/(gper^2 + delta0^2);
        Dth       = real(n)^2*(2*gper*nu0*kappa0 - 2*Omegaa*delta0^2 - (Omegaa^2 - nu0^2 + kappa0^2)*delta0)/gper/Omegaa^2;

        if neighbors == 0
            m = tooth;
        elseif neighbors >= tooth
            M = tooth + neighbors;
            m = [-M:-1 1:M];
        else
            m = [-(tooth + neighbors):-(tooth - neighbors) (tooth - neighbors):(tooth + neighbors)];
        end
        omegan    = (Na+m)*Deltap;
        omeganm   = (Na-m)*Deltap;

        S_dparameters(i).tooth     = tooth;
        S_dparameters(i).neighbors = neighbors;
        S_dparameters(i).n         = n;
        S_dparameters(i).gper      = gper;
        S_dparameters(i).gpar      = gpar;
        S_dparameters(i).Omegaa    = Omegaa;
        S_dparameters(i).Deltap    = Deltap;
        S_dparameters(i).omegan    = omegan;
        S_dparameters(i).omeganm   = omeganm;
        S_dparameters(i).delta0    = delta0;
        S_dparameters(i).gamma0    = gamma0;
        S_dparameters(i).Gamma0    = Gamma0;
        S_dparameters(i).Dth       = Dth;
        if neighbors == 0
            S_dparameters(i).valid2b2  = (2*Omegaa^2 - (omegan^2 + conj(omeganm)^2))/2/Omegaa;
        else
            S_dparameters(i).valid2b2  = [];
        end
        S_dparameters(i).Na        = Na;
        
        fprintf('%g of %g\n',i,leN);
    end
end