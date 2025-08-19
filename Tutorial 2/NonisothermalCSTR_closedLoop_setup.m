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
% Operating point and initial steady state
F = 0.65; % operating point guess
V = 218; % operating point guess
u_simulate = SteadyState(F, V, d, p);
% Run simulation
out = sim("NonisothermalCSTR_closedLoop.slx");
% CA and T constraint violation
figure;
plot(out.CA,out.T)
hold on;
plot([5 5],[273 350],'r')
plot([0 5],[350 350],'r')
xlabel('CA')
ylabel('T')
% F and V constraint violation
figure;
plot(out.F_in,out.V,'o','MarkerSize',10)
hold on;
plot([0.8 0.8],[0 500],'r')
plot([0 0.8],[500 500],'r--')
xlabel('F')
ylabel('v')
% Profit
phi = 10*out.F_out.*(out.CA0 - out.CA) - 0.3*out.F_out.*out.CA0 - 0.01*out.Fj.*(out.Tj0 - out.Tj);
phi_ave = mean(phi);
figure;
plot(phi)
hold on;
plot([0 3600*4],[phi_ave phi_ave],'green','LineWidth',2)
xlabel('Time')
ylabel('phi')
