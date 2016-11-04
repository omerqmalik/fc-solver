function plot_FC_results2(extra_clean1,extra_clean2,param_x,param_z,param_k,ymin,ymax)
    load('parameters.mat');
    if extra_clean1 && extra_clean2
        load('data_extra_clean_1_1.mat','S_clean');
    elseif extra_clean1 && ~extra_clean2
        load('data_extra_clean_1_0.mat','S_clean');
    elseif ~extra_clean1 && extra_clean2
        load('data_extra_clean_0_1.mat','S_clean');
    else
        load('data_clean_0_0.mat','S_clean');
    end
    
    z = sort(unique(param_vecs(:,param_z)));
    k = sort(unique(param_vecs(:,param_k)));
    c = lines(length(k));
    
    for i = z.'
        ii_ind = 0;
        fig1 = figure;
        fig2 = figure;
        
        axs1 = zeros(1,length(k));
        axs2 = zeros(1,length(k));
        legendstr = cell(1,length(k));
        for ii = k.'
            ii_ind = ii_ind + 1;
            S_this_results = S_clean(param_vecs(:,param_z) == i & param_vecs(:,param_k) == ii);
            this_param_vecs = param_vecs(param_vecs(:,param_z) == i & param_vecs(:,param_k) == ii,:);
            this_length    = length(S_this_results);

            X  = [];
            Y1 = [];
            Y2 = [];
            for iii = 1:this_length
                xvar  = this_param_vecs(iii,param_x);
                
                y1 = S_this_results(iii).x(1,:);
                y2 = S_this_results(iii).x(2,:);
                y2 = y2(y1 <= ymax & y1 >= ymin);
                y1 = y1(y1 <= ymax & y1 >= ymin);
                x = xvar*ones(size(y1));
                
                X  = [X x];
                Y1 = [Y1 y1];
                Y2 = [Y2 y2];
            end
            if ~isempty(X)
                figure(fig1); axs1(ii_ind) = plot(X,Y1,'linestyle','none','marker','o','color',c(ii_ind,:)); hold on;
                figure(fig2); axs2(ii_ind) = plot(X,Y2,'linestyle','none','marker','o','color',c(ii_ind,:)); hold on;
                legendstr{ii_ind} = ['gpar=' num2str(ii)];
            end
        end
        legendstr(axs1 == 0) = [];
        axs1(axs1 == 0) = [];
        axs2(axs2 == 0) = [];
        
        xL = get(gca,'xlim');
        t = param_vecs(1,1); %Will only work if there is only one tooth
        Deltap = S_dparameters(1).Deltap;
        line(xL,[t t]*real(Deltap));
        
        x_label = get_x_label(param_x);
        title_str = 'Na=';
        
        figure(fig1);
        xlabel(x_label);
        ylabel('beta');
        title([title_str num2str(i)]);
        legend(axs1,legendstr);
        set(gca,'ylim',[ymin ymax]);
        
        figure(fig2);
        xlabel(x_label);
        ylabel('frequency');
        title([title_str num2str(i)]);
        legend(axs2,legendstr);
    end
end

function x_label = get_x_label(param)
    switch param
        case 1
            x_label = 'tooth';
        case 2
            x_label = 'neighbor';
        case 3
            x_label = 'n';
        case 4
            x_label = 'gper';
        case 5
            x_label = 'gpar';
        case 6
            x_label = 'N_a';
    end
end