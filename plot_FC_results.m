function plot_FC_results(extra_clean1,extra_clean2,param_x,param_z,ymin,ymax,z)
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
    
    if nargin < 6
        z = sort(unique(param_vecs(:,param_z)));
    end
    
    markers = 'ox*.+sd^v><ph';
    marklen = length(markers);
    for i = z.'
        S_this_results = S_clean(param_vecs(:,param_z) == i);
        S_this_params  = S_dparameters(param_vecs(:,param_z) == i);
        this_length    = length(S_this_results);
        
        this_param_vecs = param_vecs(param_vecs(:,param_z) == i,:);
        
        fig1 = figure;
        fig2 = figure;
        
        for ii = 1:this_length
            if param_z == 1 %ie: tooth
                hold_param = S_this_params(ii).neighbors + 1;
                k = unique(param_vecs(:,2));
            elseif param_z == 2 %ie: neighbors
                hold_param = S_this_params(ii).tooth;
                k = unique(param_vecs(:,1));
            end
            c = colormap(jet(length(k)));
            
            g = mod(hold_param,marklen);
            if g == 0
                g = mod(hold_param-1,marklen) + 1;
            end
            if param_x == 3
                xvar  = imag(this_param_vecs(ii,param_x));
            else
                xvar  = this_param_vecs(ii,param_x);
            end
            
            figure(fig1);
            y1 = S_this_results(ii).x(1,:);
            y2 = S_this_results(ii).x(2,:);
            y2 = y2(y1 <= ymax & y1 >= ymin);
            y1 = y1(y1 <= ymax & y1 >= ymin);
            x = xvar*ones(size(y1));
            plot(x,y1,'linestyle','none','marker',markers(g == 1:marklen),'color',c(hold_param - min(k) + 1,:));
            hold on;
%             plot_analytic_beta(xvar,S_this_params(ii),y2);

            figure(fig2);
            plot(x,y2,'linestyle','none','marker',markers(g == 1:marklen),'color',c(hold_param - min(k) + 1,:));
            hold on;
%             plot_analytic_Delta(x,S_this_params(ii).tooth,real(S_this_params(ii).n),S_this_params(ii).gpar,S_this_params(ii).gper,real(S_this_params(ii).Deltap),S_this_params(ii).Omegaa,S_this_params(ii).Dth);
        end
        figure(fig2);
        xL = get(gca,'xlim');

        for ii = unique(param_vecs(:,1)).'
            if param_x == 7 || param_x == 3
                [a,b] = unique(param_vecs(:,param_x));
                if param_x == 3
                    a = imag(a);
                end
                [a,s] = sort(a);
                b = b(s);
                Deltap = [S_dparameters(b).Deltap];
                plot(a,ii*real(Deltap),'b-');
            else
                Deltap = S_dparameters(1).Deltap;
                line(xL,[ii ii]*real(Deltap));
            end
        end
        
        x_label = get_x_label(param_x);
        if param_z == 1
            title_str = 'tooth=';
        elseif param_z == 2
            title_str = 'neighbors=';
        end
        
        figure(fig1);
        xlabel(x_label);
        ylabel('beta');
        title([title_str num2str(i)]);
        
        figure(fig2);
        xlabel(x_label);
        ylabel('frequency');
        title([title_str num2str(i)]);
    end
%     export_fig(fig1
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
        case 7
            x_label = 'L';
    end
end

function plot_analytic_beta(x,S_this_params,Deltas)
    n = real(S_this_params.n);
    kappa = -imag(S_this_params.omegan);
    gper = S_this_params.gper;
    gpar = S_this_params.gpar;
    Dth = S_this_params.Dth;
    Omegaa = S_this_params.Omegaa;
    
    for i = 1:length(Deltas)
        Deltamu = Deltas(i);
        beta_a = (-4*n^2*kappa*gpar*gper + 4*n^2*kappa*Deltamu^2 + Dth*Omegaa*Deltamu^2 + sqrt(-8*n^2*kappa*gpar*gper*(4*n^2*kappa + Dth*Omegaa)*Deltamu^2 + Deltamu^2*(4*gper^2*(-4*n^4*kappa^2 + Dth^2*Omegaa^2) + Dth^2*Omegaa^2*Deltamu^2) + 4*gpar^2*(Dth^2*gper^2*Omegaa^2 - 2*n^2*kappa*(2*n^2*kappa + Dth*Omegaa)*Deltamu^2)))/2/gpar/gper/(2*n^2*kappa + Dth*Omegaa) + 1;
        plot(x,beta_a,'linestyle','none','color','r','marker','p');
        hold on;
    end    
end

function plot_analytic_beta_old(x,gper,gpar,Deltamu)
    beta_a = (gpar*Deltamu.^2 + gpar*sqrt(4*gpar^2*gper^2 + 4*gper^2*Deltamu.^2 + Deltamu.^4))/2/gpar^2/gper;
    plot(x,beta_a,'linestyle','none','color','r','marker','p');
end

function plot_analytic_Delta(x,m,n,gpar,gper,FSR,Omegaa,Dth)
    Delta_a = -2*m*n^2*gpar*FSR*(m*FSR + 2*Omegaa)/gper/(Dth - 4*n^2*gpar*Omegaa);
    if ~isempty(x)
        plot(x(1),Delta_a,'color','r','marker','p');
    end
end