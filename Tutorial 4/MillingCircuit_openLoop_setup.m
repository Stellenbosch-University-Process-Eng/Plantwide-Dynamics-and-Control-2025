% Clear all workspace variables and define nominal inputs
clear
u0.rMIW = 0.572;    % ~, mill feed water ratio
u0.MFO = 1191;      % ~, t/h, mill feed ore
u0.phi_c = 0.768;   % ~, fraction of critical mill speed
u0.CFF = 2921;      % m3/h, cyclone feed flowrate
u0.SFW = 870.24;    % m3/h, sump feed water flowrates
% Simulate open-loop (unstable) system
out = sim('MillingCircuit_openLoop.slx');