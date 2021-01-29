function [const1,const2] = constrains(x)
global demand

demand = sum(demand);
[~,total_pv_for_const,total_wt_for_const]=getGeneration(x);
const1 = total_pv_for_const + total_wt_for_const - demand * 50/100;

const2 =  total_wt_for_const * 20/100 - total_pv_for_const;

end

