function [complex_n,Om_this] = get_complex_n(n,L,Na,target)
    [nI,Om] = get_nI(n,L,Na,1000);
    
    real_nI = real(nI);
    real_nI = real_nI(real_nI>0);
    
    found = 0;
    while found == 0
        if real_nI(end) > target
            Om_min = Om(length(real_nI));
            Om_max = Om(length(real_nI)+1);
            [nI,Om] = get_nI_zoom(n,L,Na,1000,Om_min,Om_max);
            
            real_nI = real(nI);
            real_nI = real_nI(real_nI>0);
        else
            found = 1;
        end
    end
    
    nI = real(nI);
    [nI_this,ind] = get_closest_match(target,nI);
    
    Om_this = Om(ind);
    complex_n = n + 1i*nI_this;
end