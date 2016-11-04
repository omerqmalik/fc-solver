function plot_FC_validity(extra_clean,param_x)
    load parameters.mat
    if extra_clean
        load('data_extra_clean.mat');
    else
        load('data_clean.mat');
    end
    
    fig1 = figure;
    fig2 = figure;
    fig3 = figure;
    fig4 = figure;
    
    t = unique(param_vecs(:,1));
    c = colormap(lines(length(t)));
    for i = 1:length(t)
        figure(fig1);
        param_this = param_vecs(param_vecs(:,1) == t(i),:);
        S_dpa_this = S_dparameters(param_vecs(:,1) == t(i));
        S_cle_this = S_clean(param_vecs(:,1) == t(i));
        
        x = unique(param_this(:,param_x));
        y = [S_dpa_this.delta0];
        plot(x,y);
        hold on;
    
        figure(fig2);
        y = abs([S_dpa_this.valid2b2]);
        semilogy(x,y);
        hold on;
    
        for ii = 1:length(S_cle_this)
            for iii = 1:length(S_cle_this(ii).exitflag)
                figure(fig3);
                x_this = param_this(ii,param_x);
                y_this = S_cle_this(ii).M(1,1,iii) + S_cle_this(ii).M(2,2,iii);
                semilogy(x_this,y_this,'marker','o','color',c(i,:));
                hold on;

                figure(fig4);
                y_this = S_cle_this(ii).M(1,2,iii) + S_cle_this(ii).M(2,1,iii);
                semilogy(x_this,y_this,'marker','o','color',c(i,:));
                hold on;
            end
        end
    end
end