tfinal = 2e4; % Simulation time, required by the Simulink file
F = 1; % kmol/hr, feed flowrate
vL0 = 50.0; % reflux valve % for nominal L0 flow of 0.6 kmol/hr
vB0 = 50.0; % bottoms valve % for nominal B0 flow 0f 0.5 kmol/hr
vD0 = 50.0; % distillate valve % for nominal D0 flow
vV0 = 50.0; % distillate valve % for nominal V0 flow
% Step campaign
step_size = 1;

% Initial steady state
vL = vL0;
vB = vB0;
vD = -1;
vV = -1;
% Run simulations
SS = sim("DistillationColumn.slx");

% >>> MVs: vL and vB
% Scenario:
disp('CV1 = xD, CV2 = xB, MV1 = vL, MV2 = vB')
% vL step, vB constant
vL = vL0 + step_size;
vB = vB0;
% Other valves used for inventory control
vD = -1;
vV = -1;
% Run simulation
MV1 = sim("DistillationColumn.slx");
% vL constant, vB step
vL = vL0;
vB = vB0 + step_size;
vD = -1;
vV = -1;
% Run simulation
MV2 = sim("DistillationColumn.slx");
% Steady state gain matrix
K = [(MV1.xD(end)-SS.xD(end))/step_size (MV2.xD(end)-SS.xD(end))/step_size
    (MV1.xB(end)-SS.xB(end))/step_size (MV2.xB(end)-SS.xB(end))/step_size];
K
% Relative gain array
L = K.*inv(K)';
L
% SVA
[U, S, V] = svd(K);
S
V

% >>> MVs: vL and vV
% Scenario:
disp('CV1 = xD, CV2 = xB, MV1 = vL, MV2 = vV')
% vL step, vV constant
vL = vL0 + step_size;
vV = vV0;
% Other valves used for inventory control
vD = -1;
vB = -1;
% Run simulation
MV1 = sim("DistillationColumn.slx");
% vL constant, vV step
vL = vL0;
vV = vV0 + step_size;
vD = -1;
vB = -1;
% Run simulation
MV2 = sim("DistillationColumn.slx");
% Steady state gain matrix
K = [(MV1.xD(end)-SS.xD(end))/step_size (MV2.xD(end)-SS.xD(end))/step_size
    (MV1.xB(end)-SS.xB(end))/step_size (MV2.xB(end)-SS.xB(end))/step_size];
K
% Relative gain array
L = K.*inv(K)';
L
% SVA
[U, S, V] = svd(K);
S
V

% >>> MVs: vL and vD
% Scenario:
disp('CV1 = xD, CV2 = xB, MV1 = vL, MV2 = vD')
% vL step, vD constant
vL = vL0 + step_size;
vD = vD0;
% Other valves used for inventory control
vV = -1;
vB = -1;
% Run simulation
MV1 = sim("DistillationColumn.slx");
% vL constant, vD step
vL = vL0;
vD = vD0 + step_size;
vV = -1;
vB = -1;
% Run simulation
MV2 = sim("DistillationColumn.slx");
% Steady state gain matrix
K = [(MV1.xD(end)-SS.xD(end))/step_size (MV2.xD(end)-SS.xD(end))/step_size
    (MV1.xB(end)-SS.xB(end))/step_size (MV2.xB(end)-SS.xB(end))/step_size];
K
% Relative gain array
L = K.*inv(K)';
L
% SVA
[U, S, V] = svd(K);
S
V


% >>> MVs: vV and vD
% Scenario:
disp('CV1 = xD, CV2 = xB, MV1 = vV, MV2 = vD')
% vV step, vD constant
vV = vV0 + step_size;
vD = vD0;
% Other valves used for inventory control
vL = -1;
vB = -1;
% Run simulation
MV1 = sim("DistillationColumn.slx");
% vV constant, vD step
vV = vV0;
vD = vD0 + step_size;
vL = -1;
vB = -1;
% Run simulation
MV2 = sim("DistillationColumn.slx");
% Steady state gain matrix
K = [(MV1.xD(end)-SS.xD(end))/step_size (MV2.xD(end)-SS.xD(end))/step_size
    (MV1.xB(end)-SS.xB(end))/step_size (MV2.xB(end)-SS.xB(end))/step_size];
K
% Relative gain array
L = K.*inv(K)';
L
% SVA
[U, S, V] = svd(K);
S
V


% >>> MVs: vV and vB
% Scenario:
disp('CV1 = xD, CV2 = xB, MV1 = vV, MV2 = vB')
% vV step, vB constant
vV = vV0 + step_size;
vB = vB0;
% Other valves used for inventory control
vL = -1;
vD = -1;
% Run simulation
MV1 = sim("DistillationColumn.slx");
% vV constant, vB step
vV = vV0;
vB = vB0 + step_size;
vL = -1;
vD = -1;
% Run simulation
MV2 = sim("DistillationColumn.slx");
% Steady state gain matrix
K = [(MV1.xD(end)-SS.xD(end))/step_size (MV2.xD(end)-SS.xD(end))/step_size
    (MV1.xB(end)-SS.xB(end))/step_size (MV2.xB(end)-SS.xB(end))/step_size];
K
% Relative gain array
L = K.*inv(K)';
L
% SVA
[U, S, V] = svd(K);
S
V
