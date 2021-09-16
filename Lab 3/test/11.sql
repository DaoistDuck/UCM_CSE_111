-- SQLite

select count(DISTINCT c_custkey)
from customer, lineitem, orders
where l_orderkey = o_orderkey AND o_custkey = c_custkey AND l_discount >= '0.10';