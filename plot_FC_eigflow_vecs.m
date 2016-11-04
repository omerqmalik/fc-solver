function [V,D] = plot_FC_eigflow_vecs(S_dparameters,beta,Deltamu)
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
    
    lenDt = length(Deltamu);
    lenD0 = length(beta);
    
    fig1 = figure;
    fig2 = figure;
    V = zeros(2,2,lenD0,lenDt);
    D = zeros(2,2,lenD0,lenDt);
    for i = 1:lenDt
        Deltamu_this = Deltamu(i);
        
        alphamu  = 1 - 1i*(delta0 + Deltamu_this)/gper;
        alphamum = 1 + 1i*(delta0 - Deltamu_this)/gper;
        betamu   = 1 - 1i*Deltamu_this/gpar;
        
        c1 = colormap(autumn(lenD0));
        c2 = colormap(winter(lenD0));
        for j = 1:lenD0
            beta_this = beta(j);
            M = get_M(n,Omegaa,omegan,omeganm,delta0,gamma0,Gamma0,Dth,N,alphamu,alphamum,betamu,beta_this,Deltamu_this);
            [V(:,:,j,i),D(:,:,j,i)] = eig(M);
            e = diag(D(:,:,j,i));
            v = V(:,:,j,i);
            
            if i == ceil(lenDt/2) && j == ceil(lenD0/2)
                figure(fig1);
                plot(real(e(1)),imag(e(1)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c1(j,:)); hold on;
                plot(real(e(2)),imag(e(2)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c2(j,:));
                
                figure(fig2);
                subplot(1,2,1);
                plot(real(v(1,1)),imag(v(1,1)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c1(j,:)); hold on;
                plot(real(v(2,1)),imag(v(2,1)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c2(j,:));
                
                subplot(1,2,2);
                plot(real(v(1,2)),imag(v(1,2)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c1(j,:)); hold on;
                plot(real(v(2,2)),imag(v(2,2)),'linestyle','none','marker','x','markersize',20,'linewidth',3,'color',c2(j,:));
            else
                figure(fig1);
                plot(real(e(1)),imag(e(1)),'linestyle','none','marker','o','color',c1(j,:)); hold on;
                plot(real(e(2)),imag(e(2)),'linestyle','none','marker','o','color',c2(j,:));
                
                figure(fig2);
                subplot(1,2,1);
                plot(real(v(1,1)),imag(v(1,1)),'linestyle','none','marker','o','color',c1(j,:)); hold on;
                plot(real(v(2,1)),imag(v(2,1)),'linestyle','none','marker','o','color',c2(j,:));
                
                subplot(1,2,2);
                plot(real(v(1,2)),imag(v(1,2)),'linestyle','none','marker','o','color',c1(j,:)); hold on;
                plot(real(v(2,2)),imag(v(2,2)),'linestyle','none','marker','o','color',c2(j,:));
            end
        end
%         pause;
    end
    figure(fig1);
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    figure(fig2);
    subplot(1,2,1);
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    subplot(1,2,2);
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
end