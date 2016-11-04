function [V,D,beta,Dp,x] = plot_FC_eigs_at_transition(gper,mu,Nbeta,NDp,beta_d,Dp_d)
    load parameters
    load data_clean
    
    if mod(Nbeta,2) ~= 0; Nbeta = Nbeta + 1; end;
    if mod(NDp,2) ~= 0; NDp = NDp + 1; end;
    
    all_gper = unique(param_vecs(:,4));
    m = get_closest_match(gper,all_gper);
    
    param_this = S_dparameters(param_vecs(:,4) == m & param_vecs(:,1) == mu);
    data_this  = S_clean(param_vecs(:,4) == m & param_vecs(:,1) == mu);
    x = data_this.x(:,1);

    if nargin < 5
        beta_d = 1;
        Dp_d = 0.5;
    end

    g = x(1) - beta_d;
    if g > 1
        beta_min = g;
        beta_max = g + 2;
    else
        beta_min = 1;
        beta_max = x(1) + g;
    end
    delta_beta = abs(beta_min - x(1))/Nbeta;
    beta = [beta_min:delta_beta:(x(1)-delta_beta) x(1) (x(1)+delta_beta):delta_beta:beta_max]; % linspace(beta_min,beta_max,Nbeta);

    Deltap = real(param_this.Deltap);
    Dp_min = x(2) - Dp_d*Deltap;
    Dp_max = x(2) + Dp_d*Deltap;
    delta_Dp = abs(Dp_min - x(2))/NDp;
    Dp = [Dp_min:delta_Dp:(x(2)-delta_Dp) x(2) (x(2)+delta_Dp):delta_Dp:Dp_max];

    
    [V,D] = plot_FC_eigflow(param_this,beta,Dp);
end