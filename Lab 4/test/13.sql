--SQLite 

select count(*)
from supplier, nation as supnation, nation as cusnation, region, lineitem, customer, orders
where s_nationkey = supnation.n_nationkey AND supnation.n_regionkey = r_regionkey AND r_name = 'AFRICA'
AND o_custkey = c_custkey AND c_nationkey = cusnation.n_nationkey AND cusnation.n_name = 'UNITED STATES'
AND o_orderkey = l_orderkey AND s_suppkey = l_suppkey;

--able to create multiple same tables by table_name as name_of_new_table