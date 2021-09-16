-- SQLite

select c_mktsegment, MIN(c_acctbal), MAX(c_acctbal), SUM(c_acctbal)
from customer
group by c_mktsegment;