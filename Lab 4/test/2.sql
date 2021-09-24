--SQLite

select r_name, count(s_suppkey)
from supplier, nation, region
where s_nationkey = n_nationkey AND n_regionkey = r_regionkey
group by r_name;