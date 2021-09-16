-- SQLite

select count(o_orderpriority)
from customer, orders, nation
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_name = 'BRAZIL' AND o_orderpriority = '1-URGENT' AND strftime('%Y', o_orderdate) BETWEEN '1994' AND '1997';