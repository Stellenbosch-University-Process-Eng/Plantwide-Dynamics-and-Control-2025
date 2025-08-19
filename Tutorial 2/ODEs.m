function dxdt = ODEs(x, u, d, p)
u.CAs = x(1);
u.Ts = x(2);
u.Tjs = x(3);
rxn = @(u, d) p.k0*u.CAs*exp(-p.E_R / u.Ts);
dxdt = [u.F/u.V*(d.CA0 - u.CAs) - rxn(u, d);...
        u.F/u.V*(d.T0 - u.Ts) + p.dH_pcp*rxn(u, d) - d.UA_pcp/u.V*(u.Ts - u.Tjs); ...
        p.Fj/p.Vj*(d.Tj0 - u.Tjs) + d.UA_pcp/p.Vj*(u.Ts - u.Tjs)];
end