function Vel = PlotVelocity2D( xvor, zvor, Gamma, ptx, ptz)
% ѕечать на график скоростей по данным решени€.
% xvor, zvor - точки вихр€,
% Gamma - значени€ циркул€ций в точках вихр€.
% ptx, ptz - координаты целевой точки (где вычисл. скорость) x и z.

%  ол-во точек вихр€.
vortexPtsNum = size(xvor,2);
% »нициализаци€ вектора скорости.
Vel = [0 0];
% ѕо всем точкам вихр€ считаем и суммируем вклады.
for i=1:vortexPtsNum
    [tmpU, tmpV] = Vortex2D(ptx, ptz, xvor(i), zvor(i), Gamma(i));
    Vel(1) = Vel(1) + tmpU;
    Vel(2) = Vel(2) + tmpV;
end

end
