syms w
eqns = [w == 1.05/(1 - (3.64/w) - (0.6969*w^(-0.1546)))];

S = solve(eqns,w)