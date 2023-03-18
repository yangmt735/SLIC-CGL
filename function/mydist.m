function [ dists ] = mydist( dg, R )

Ng = R; % Spatial normalization factor

if (size(dg,1) == 1)
    dg = dg';
end

dists = sqrt((dg / Ng) .^ 2); 




