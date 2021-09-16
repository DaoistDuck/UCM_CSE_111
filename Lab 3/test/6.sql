-- SQLite

select DISTINCT n_name
from customer, orders, nation
where c_custkey == o_custkey AND o_orderdate BETWEEN '1996-09-10' AND '1996-09-12' AND c_nationkey == n_nationkey
group by n_name;
