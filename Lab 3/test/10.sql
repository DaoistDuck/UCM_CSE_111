-- SQLite

select SUM(o_totalprice)
from orders, nation, region, customer
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA' AND strftime('%Y', o_orderdate) = '1996';
