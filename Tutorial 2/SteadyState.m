function u = SteadyState(F, V, d, p)
u.F = F;      % L/s, feed flowrate
u.V = V;      % L, reactor volume
% Find steady state values of CAs, Ts, Tjs
[~, x] = ode23s(@(t,x) ODEs(x, u, d, p), [0 1e4], [d.CA0, d.T0, d.T0]);
u.CAs = x(end,1);
u.Ts = x(end,2);
u.Tjs = x(end,3);
end
