function show_FC_eigenvector(V,D,e)
    [~,m] = min(abs(reshape(D,numel(D),1)-e));
    
    if mod(m,4) == 0
        this_V = V((m-3):m);
    else
        this_V = V(m:(m+3));
    end
    
    reshape(this_V,2,2)
end