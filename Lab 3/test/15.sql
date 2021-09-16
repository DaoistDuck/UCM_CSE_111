-- SQLite

select strftime('%Y', o_orderdate), count(l_partkey)
from orders, lineitem, supplier, nation
where l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'CANADA' AND o_orderpriority = '3-MEDIUM' AND l_orderkey = o_orderkey 
group by strftime('%Y', o_orderdate);