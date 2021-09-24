--SQLite

select s_name, count(p_size)
from supplier, nation, part, partsupp
where s_nationkey = n_nationkey AND n_name = 'CANADA' AND s_suppkey = ps_suppkey AND ps_partkey = p_partkey AND p_size < 20
group by s_name;