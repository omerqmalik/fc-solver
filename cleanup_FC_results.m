function cleanup_FC_results(extra_clean1,extra_clean2,limit)
    load('parameters.mat');
    load('data_raw.mat');
    
    len_results = length(S_results);
    for i = 1:len_results
        x_this = S_results(i).x;
        f_this = S_results(i).fval;
        M_this = S_results(i).M;
        d_this = S_results(i).detM;
        e_this = S_results(i).exitflag;
        
        x_this = x_this(:,e_this > 0);
        f_this = f_this(:,e_this > 0);
        M_this = M_this(:,:,e_this > 0);
        d_this = d_this(e_this > 0);
        e_this = e_this(e_this > 0);
        
        if extra_clean2
            f_this = f_this(:,x_this(1,:) >= 9);
            M_this = M_this(:,:,x_this(1,:) >= 9);
            d_this = d_this(x_this(1,:) >= 9);
            e_this = e_this(x_this(1,:) >= 9);
            x_this = x_this(:,x_this(1,:) > 9);
        end
        
        [~,s1] = uniquetol(x_this(1,:));
        [~,s2] = uniquetol(x_this(2,:));
        if length(s1) > 1 || length(s2) >1
            s = sort(intersect(s1,s2));
        else
            s = s1;
        end
        
        x = [x_this(1,s); x_this(2,s)];
        f = [f_this(1,s); f_this(2,s)];
        e = e_this(s);
        M = M_this(:,:,s);
        d = d_this(s);
        
        this_tooth  = S_dparameters(i).tooth;
        this_Deltap = S_dparameters(i).Deltap;
        this_freq   = this_tooth*real(this_Deltap);
        
        if extra_clean1
            f(:,abs(x(2,:) - this_freq) > limit*real(this_Deltap)) = [];
            e(abs(x(2,:) - this_freq) > limit*real(this_Deltap)) = [];
            x(:,abs(x(2,:) - this_freq) > limit*real(this_Deltap)) = [];
            M(:,:,abs(x(2,:) - this_freq) > limit*real(this_Deltap)) = [];
            d(abs(x(2,:) - this_freq) > limit*real(this_Deltap)) = [];
        end
        
        S_results(i).x = x;
        S_results(i).fval = f;
        S_results(i).exitflag = e; %#ok<*AGROW>
        S_results(i).M = M;
        S_results(i).detM = d;
    end
    S_clean = S_results;
    
    if extra_clean1 && extra_clean2
        save('data_extra_clean_1_1.mat','S_clean');
    elseif extra_clean1 && ~extra_clean2
        save('data_extra_clean_1_0.mat','S_clean');
    elseif ~extra_clean1 && extra_clean2
        save('data_extra_clean_0_1.mat','S_clean');
    else
        save('data_clean_0_0.mat','S_clean');
    end
end