function dydt = Vm_diffeq(t,y,n,r)
% y = [g_str1, g_str2,... g_gp1,...,g_snr1,
% Variables
% g_i = y(1:(n+n/r+n/r.^2));
g_str = y(1:n);
g_gp = y((n+1):(n+n/r));
% Vm_i = y((n+n/r+n/r.^2+1):length(y));
V_str = y((n+n/r+1):(2*n+n/r));
V_gp = y((2*n+n/r+1):(2*(n+n/r)));
V_snr = y((2*(n+n/r)+1):length(y));
% Jump Vm_i if it exceeds threshold voltage?


% Define Constants
%%cellular
tau_cell = 0.005;
Cm = 1;
Erev_i = -85*ones(length(Vm_i),1);
I_const = 10; 
Vrest = -70;
Vm_thres = -40;
%%synaptic
tau_syn =0.005;
prob_syn = 0.1; % probability of successful synaptic transmission
g_uni = 0.01*ones(length(Vm_i),1) ; % conductance of a single synapse 
synSuccess_i = rand(length(Vm_i),1)<prob_syn; % flip a coin: success (1) or failure (0)
% probSyn_gp = rand(n./r)>prob_syn; 

% probSyn_gp = rand(length(t_span),n./r)>prob_syn; 
% sum(spk_count_str.*synSuccess

%Striatum
delta_str = Vm_str>Vm_thres;
Vm_str(Vm_str>Vm_thres) = Vrest;   % bring it back to Vrest
I_syn =  -g_i.*(Vm_i-Erev_i);
Isyn_gpe = -g_str.*(V



dg_i= -g_i./tau_syn + sum(delta_i.*synSuccess_i.*g_uni);
I_ext = I_syn + I_const*ones(length(Vm_i),1);
dVm_i = -(Vm_i-Vrest*ones(length(Vm_i),1))/tau_cell + 20./(1+exp(-I_ext));
dydt = [dg_i;dVm_i];