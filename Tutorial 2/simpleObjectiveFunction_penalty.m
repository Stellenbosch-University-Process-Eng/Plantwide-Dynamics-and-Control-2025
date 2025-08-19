% The function below implements soft constraints for use with fminsearch,
% if the Optimisation Toolbox is unavailable
function J = simpleObjectiveFunction_penalty(x, d, p, h1, phi)
F = x(1);
V = x(2);
u = SteadyState(F,V,d,p);

Profit = phi(u);

H(1) = h1(u);
H(2) = u.F - 0.8;
H(3) = 0.05 - u.F;
H(4) = u.V - 500;
H(5) = 100 - u.V;

Penalty = 0;
for i = 1:5
    Penalty = Penalty + 1e10*max(0, H(i).^5);
end

J = -Profit + Penalty;

end