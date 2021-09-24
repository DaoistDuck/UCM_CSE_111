-- SQLite

select c_name, sum(o_totalprice)
from customer, orders, nation
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_name = 'FRANCE' AND strftime('%Y', o_orderdate) = '1995'
group by c_name;