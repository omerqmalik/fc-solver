function S_results = find_FC_thresholds(D0)
    load('parameters.mat','S_dparameters');
    
    leN   = length(S_dparameters);
    lenD0 = length(D0);
    len   = leN*lenD0;
    
    S_linear  = repelem(S_dparameters,lenD0);
    D0_linear = repmat(D0,1,leN);

    options = optimoptions('fsolve','Display','None','MaxFunEvals',1000,'MaxIter',1000,'TolFun',1e-10,'TolX',1e-10);

    x        = zeros(2,len);
    fval     = zeros(2,len);
    exitflag = zeros(1,len);
    detM     = zeros(1,len);
    M        = cell(1,len);
    
    parfor i = 1:len
        tooth  = S_linear(i).tooth;
        Deltap = S_linear(i).Deltap;
        Delta  = tooth*real(Deltap);
        
        [x(:,i),fval(:,i),exitflag(i)] = fsolve(@(x)det_roots(x,S_linear(i)),[D0_linear(i),Delta],options);
        [~,M{i},detM(i)] = det_roots(x(:,i),S_linear(i));
        
        fprintf('%d of %d\n',i,len);
    end

    S_results = convert_to_struct(reshape(x,2,lenD0,leN),reshape(fval,2,lenD0,leN),reshape(exitflag,1,lenD0,leN),reshape(M,1,lenD0,leN),reshape(detM,1,lenD0,leN));
%     S_results = convert_to_struct(x,fval,exitflag,S_linear);

    save('data_raw.mat','S_results','D0');
%     cleanup_FC_results(0,1);
end

function S = convert_to_struct(x,fval,exitflag,M,detM)
    leN = size(x,3);
    S = struct('x',[],'fval',[],'exitflag',[],'M',[],'detM',[]);
    S(leN).x = [];
    
    for i = 1:leN
        S(i).x        = x(:,:,i);
        S(i).fval     = fval(:,:,i);
        S(i).exitflag = exitflag(:,:,i);
        S(i).M        = reshape([M{:,:,i}],size(M{1,1,i},1),size(M{1,1,i},1),size(M,2));
        S(i).detM     = detM(:,:,i);
    end
end