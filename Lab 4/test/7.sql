--SQLite 

select n_name, o_orderstatus, count(o_orderkey)
from nation, orders, customer, region
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA'
group by n_name, o_orderstatus;