-- SQLite

select DISTINCT s_name, s_acctbal
from supplier, nation, region
where s_acctbal > '5000' AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'AMERICA';

