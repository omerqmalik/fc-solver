clc;
clear;

%% Define natural parameters characterizing a ring-cavity laser
%units:
%gper (unitless, gper*L/c)
%gpar (unitless, gpar*L/c)

toothA     = 1:1;                          %list of positive integers specifying first-transitioning-tooth
neighborsA = 0:0;                          %list of positive integers specifying number of neighbors to include
nA         = 3.3 + 0.05*1i;                %refractive index
gperA      = 10:1:60;            %polarization relaxation
gparA      = [0.00001:0.00001:0.0001 0.0002:0.0001:0.001];     %inversion relaxation

%Select one or the other
% Omegaa     = 1000*gperA;                 %atomic center frequency
NaA        = 1000;  %atomic center mode number

%% Internal
C_parameters = {toothA.',neighborsA.',nA.',gperA.',gparA.',NaA.'};
order        = [1 2 3 4 5 6];

param_vecs    = setup_genParameterVectors(C_parameters,order);
S_dparameters = generate_FC_parameter_struct(param_vecs);

save([mfilename '.mat'],'S_dparameters','param_vecs');
adjust_gpar;