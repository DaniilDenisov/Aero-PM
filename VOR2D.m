function [u, w] = VOR2D(X, Z, X1, Z1, Gamma)
% VOR2D: Katz & Plotkin p.p. 304, 618.
% “очность.
tol = 0.001;
% ќпределение рассто€ни€ до точки, где вычисл€етс€ скорость.
Rx = X-X1;
Rz = Z-Z1;
R = sqrt(Rx^2+Rz^2);
% ќпределение составл€ющих скорости (u и w).
% ≈сли рассто€ние равно нулю, на него нельз€ делить.
if R<=tol
    u = 0;
    w = 0;
else
    v = (0.5/pi)*(Gamma/R);
    u = v*(Rz/R);
    w = v*(-Rx/R);
end
end

