function res = plot_RNGH_beta(S_this_param,lambda)
    [beta_m,beta_p] = get_RNGH_beta(S_this_param,lambda)
    plot(real(beta_m),
end