--SQLite 

select n_name, s_acctbal
from nation, supplier
where s_nationkey = n_nationkey AND s_acctbal > 9000
group by n_name;