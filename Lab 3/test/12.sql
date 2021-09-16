-- SQLite

select r_name, count(o_orderstatus)
from orders, customer, nation, region
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND o_orderstatus = 'F'
group by r_name;