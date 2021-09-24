--SQLite 

select s_name, o_orderpriority, count(distinct p_partkey)
from supplier, nation, orders, lineitem, part
where s_nationkey = n_nationkey AND n_name = 'CANADA' AND o_orderkey = l_orderkey
AND l_suppkey = s_suppkey AND l_partkey = p_partkey
group by s_name, o_orderpriority;