% The checks for constraint violation: vector "c" must be < 0.
function [c, ceq] = simpleNonLinearConstraints(x, d, p, h1) % TODO h4, h7
F = x(1); V = x(2); u = SteadyState(F,V,d,p);
c = [h1(u)]; % TODO: [h1(u),h4(u),h7(u)]
ceq = [];
end