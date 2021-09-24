--SQLite 

select n_name, count(distinct o_orderkey)
from nation, orders, supplier, lineitem
where o_orderkey = l_orderkey AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND o_orderstatus = 'F' AND strftime('%Y', o_orderdate) = '1995' 
group by n_name
having count(distinct o_orderkey) > 50;