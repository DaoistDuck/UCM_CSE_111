--SQLite 

select count(distinct o_clerk)
from orders, nation, supplier, lineitem
where o_orderkey = l_orderkey AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'UNITED STATES';