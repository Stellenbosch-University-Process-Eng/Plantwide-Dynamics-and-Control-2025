% Simulation setup
% Process parameters
p.dH_pcp = 5; % K.L/mol, heat of reaction divided by molar heat capacity
p.E_R = 6000; % K, activation energy divided by universal gas constant
p.Fj = 1.04;  % L/s, cooling water flowrate
p.k0 = 2.7e5; % 1/s, pre-exponential rate coefficient
p.Vj = 10;    % L, cooling jacket volume
% Nominal values for process disturbances
d.Tj0 = 283;        % K, cooling water temperature
d.T0 = 300;         % K, feed stream temperature
d.CA0 = 20;         % mol/L feed stream concentration
d.UA_pcp = 0.350;   % K/s, jacket overall heat transfer coefficient and area
% Profit
F = 0.7; % operating point guess
V = 400; % operating point guess
u_simulate = SteadyState(F, V, d, p);
% Run simulation
out = sim("NonisothermalCSTR_openLoop.slx");
