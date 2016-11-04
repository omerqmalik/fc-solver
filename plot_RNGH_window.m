function res = plot_gc_FSR(ka,gperp,L,n,N)
    FSR = 2*pi/n/L;
    FSR/gperp
    mid_res = round(ka/real(FSR));
    
    if mod(N,2) == 1
        max_res = floor(N/2) + mid_res;
        min_res = mid_res - floor(N/2);
    else
        max_res = mid_res + N/2;
        min_res = mid_res - N/2 + 1;
    end
    
    res = FSR*(min_res:max_res);
    
    w = linspace(min(real(res)),max(real(res)),1000);
    gc = gperp^2./((ka-w).^2 + gperp^2);
    
    plot(w,gc);
    yL = get(gca,'ylim');
    for i = 1:length(res);
        line([real(res(i)) real(res(i))],yL,'color','r');
    end
    set(gca,'xlim',[min(real(res)),max(real(res))]);
    
    min_s_R = ka + 2.9*gperp;
    max_s_R = ka + 3.6*gperp;
    min_s_L = ka - 2.9*gperp;
    max_s_L = ka - 3.6*gperp;
    
    line([min_s_R min_s_R],yL,'color','g');
    line([max_s_R max_s_R],yL,'color','g');
    line([min_s_L min_s_L],yL,'color','g');
    line([max_s_L max_s_L],yL,'color','g');
    
    res = res.';
end