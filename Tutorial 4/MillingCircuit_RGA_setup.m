% Clear all workspace variables and define nominal inputs
clear
u0.rMIW = 0.572;    % ~, mill feed water ratio
u0.MFO = 1191;      % ~, t/h, mill feed ore
u0.phi_c = 0.768;   % ~, fraction of critical mill speed
u0.CFF = 2921;      % m3/h, cyclone feed flowrate
u0.SFW = 870.24;    % m3/h, sump feed water flowrates

% BEFORE PROCEEDING!
% Copy MillingCircuit_openLoop.slx
% Change name to MillingCircuit_RGA.slx
% Control sump level with an appropriate MV
% Proceed with rest of this analysis

% Define the number of MVs as well as the field names
% Excluding the MV that has been used for controlling the sump level
% In this case, "SFW"
MV.N = 4;
MV.fields = ["rMIW", "MFO", "phi_c", "CFF"];

% Define the number of CVs as well as the field names
% Excluding the sump level that is controlled
% Exclude Slev
CV.N = 4;
CV.fields = ["JT","Pmill","rho","PSE"];

% Calculate the steady state gain matrix
K = zeros(CV.N, MV.N);
u = u0;                         % Set MVs to nominal values
y0 = SteadyState(CV.fields);    % Calculate steady state CVs
for i = 1:MV.N
    % Set inputs to nominal values, then change a single MV by 1%
    u = u0;
    u.(MV.fields(i)) = 1.01*u0.(MV.fields(i));
    delta_u = u.(MV.fields(i)) - u0.(MV.fields(i));   % Calculate step change in MV
    
    % Calculate the steady state CVs under new MVs
    y = SteadyState(CV.fields);
    
    % Populate the column in K corresponding to MV(i)
    for j = 1:CV.N
        K(j,i) = ( y.(CV.fields(j)) - y0.(CV.fields(j)) ) / delta_u;
    end
end

% Convert K to named column and row table for readability
K_table = array2table(K,'RowNames',CV.fields, 'VariableNames',MV.fields);
% Calculate RGA
RGA = K .* (inv(K))';
% Convert RGA to named column and row table for readability
RGA_table = array2table(RGA,'RowNames',CV.fields,'VariableNames',MV.fields);