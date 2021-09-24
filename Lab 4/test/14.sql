--SQLite

select supregion.r_name, cusregion.r_name, max(o_totalprice)
from region as cusregion, region as supregion, nation as cusnation, nation as supnation, supplier, customer, orders, lineitem
where s_nationkey = supnation.n_nationkey AND supnation.n_regionkey = supregion.r_regionkey
AND c_nationkey = cusnation.n_nationkey AND cusnation.n_regionkey = cusregion.r_regionkey 
AND c_custkey = o_custkey AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey
group by supregion.r_name, cusregion.r_name;
