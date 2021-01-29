function [outputOfObjection] = objection(x)
global demand

demand = sum(demand);
% pv = x(1);
% wt = x(2);

[~,total_pv,total_wt]=getGeneration(x);

grid = demand - total_pv * 5800 - 3000 * total_wt;

gridTotalCost = grid * 0.5 ;

outputOfObjection = x(1) * 5800 + x(2) * 3000 + gridTotalCost;

end

