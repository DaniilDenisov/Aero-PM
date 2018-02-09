function [ deltaL ] = Postprocess2D( x, z, Gamma, rho, Qinf )
%POSTPROCESS2D Summary of this function goes here
nPanels = size(x,2)-1;
% Постпроцессинг: подъемная сила по найденной циркуляции.
deltaL = zeros(1,nPanels);
for i=1:nPanels
    deltaL(i) = rho*Qinf*Gamma(i,1);
end
%disp(deltaL);
disp(sum(deltaL));
end