--SQLite 

select r_name, s_name, max(s_acctbal)
from region, supplier, nation
where s_nationkey = n_nationkey AND n_regionkey = r_regionkey
group by r_name;