--SQLite 

select count(distinct o_orderkey)
from customer, supplier, lineitem, orders
where c_acctbal > 0 AND s_acctbal < 0
AND c_custkey = o_custkey AND s_suppkey = l_suppkey 
AND l_orderkey = o_orderkey;
