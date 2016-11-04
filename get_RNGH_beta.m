function [beta_m,beta_p] = get_RNGH_beta(S_this_param,lambda)
    gper = S_this_param.gper;
    gpar = S_this_param.gpar;

    fsolve(@(x) get_beta(gper,gpar,kappa,alpha
end