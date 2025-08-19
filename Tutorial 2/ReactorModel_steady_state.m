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

% Define a grid of (F,V) points
Vmin = 100;  % L, h2: minimum reactor volume 
Vmax = 500;  % L, h3: maximum reactor volume
Fmin = 0.05; % L/s, h5: minimum feed flowrate 
Fmax = 0.8;  % L/s, h6: maximum feed flowrate
N = 20;  % Number of gridpoints to evaluate is N^2
[F, V] = meshgrid(linspace(Fmin, Fmax, N), linspace(Vmin, Vmax, N));

% Define constraint and profit functions
h1 = @(u) u.Ts - 350; % K, h1: maximum reactor temperature
h4 = @(u) p.Fj*(u.Tjs-d.Tj0)-20.1; % maximum cooling rate
h7 = @(u) u.CAs-5; % maximum reactant concentration in the product stream
phi = @(u) 10*u.F*(d.CA0 - u.CAs) - 0.3*u.F*d.CA0 - 0.01*p.Fj*(d.Tj0 - u.Tjs);
% Loop over every gridpoint: For visualization
H1 = zeros(N,N); 
H4 = zeros(N,N);
H7 = zeros(N,N);
Phi = zeros(N,N);
for i = 1:N
    for j = 1:N
        u = SteadyState(F(i,j), V(i,j), d, p);
        % Calculate constraint functions at each grid point
        H1(i,j) = h1(u);
        H4(i,j) = h4(u);
        H7(i,j) = h7(u);
        % Calculate profit at each grid point
        Phi(i,j) = phi(u);
    end
end

% Find optimal F and V
Fguess = 0.3; % initial guess
Vguess = 400; % initial guess
x = fmincon(@(x) objectiveFunction(x, d, p, phi), [Fguess; Vguess],...
            [],[],[],[], [0.05, 100], [0.8, 500], ...
            @(x) nonLinearConstraints(x, d, p, h1, h4, h7)); % TODO
% x = fminsearch(@(x) simpleObjectiveFunction_penalty(x, d, p, h1, phi), [Fguess; Vguess]);

% Show constraints and objective function with optimization result
clf
contourf(F, V, Phi); 
hold on
[C1,handle_h1] = contour(F,V,H1,[0,0],'k','LineWidth',2);
[C1n,handle_h1n] =  contour(F,V,H1,[-1,-1],'k--','LineWidth',2); % indicates direction of decreasing constraint
[C4,handle_h4] = contour(F,V,H4,[0,0],'r','LineWidth',2);
[C4n,handle_h4n] =  contour(F,V,H4,[-1,-1],'r--','LineWidth',2); % indicates direction of decreasing constraint
[C7,handle_h7] = contour(F,V,H7,[0,0],'magenta','LineWidth',2);
[C7n,handle_h7n] =  contour(F,V,H7,[-1,-1],'--','LineWidth',2,'Color','magenta'); % indicates direction of decreasing constraint
handle_cb = colorbar;
handle_cb.Label.String = 'Phi';
handle_opt = plot(x(1), x(2), 'wx','LineWidth',2);
hold off
xlabel('F'); ylabel('V');
legend([handle_h1, handle_h1n, handle_h4, handle_h4n, handle_h7, handle_h7n, handle_opt],{'h1 constraint','h1 decreasing','h4 constraint','h4 decreasing','h7 constraint','h7 decreasing','optimum'})