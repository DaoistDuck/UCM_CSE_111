--SQLite

select c_name, count(o_orderkey)
from customer, orders, nation
where o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_name = 'GERMANY' AND strftime('%Y', o_orderdate) = '1993'
group by c_name;