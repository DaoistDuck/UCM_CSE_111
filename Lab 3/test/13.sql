-- SQLite

select SUM(c_acctbal)
from nation, region, customer
where c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name = 'EUROPE' AND c_mktsegment = 'MACHINERY';