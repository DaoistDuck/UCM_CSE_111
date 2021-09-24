--SQLite

select n_name, count(o_orderkey)
from orders, nation, region, customer
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA'
group by n_name;