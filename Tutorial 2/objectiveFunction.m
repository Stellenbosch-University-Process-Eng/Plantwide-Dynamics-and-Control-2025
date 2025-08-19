% Calculates the objective function to minimize (-profit)
function J = objectiveFunction(x, d, p, phi)
    F = x(1); V = x(2); u = SteadyState(F,V,d,p);
    J = -phi(u);
end