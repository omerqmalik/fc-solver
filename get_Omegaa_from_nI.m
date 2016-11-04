function w_a = get_Omegaa_from_nI(n,Na)
    %units:
    %w_a (unitless: w_a*L/c)
    w_FSR = get_RING_Deltap(n);
    w_0    = Na*w_FSR;
    nu0    = real(w_0);
    kappa0 = -imag(w_0);
    
    w_a     = fsolve(@(x) nI_root(x,nu0,kappa0),nu0);
end

function y =  nI_root(Om,nu0,kappa0)
    y = Om^2 - nu0^2 + kappa0^2;
end