-- SQLite

select n_name, count(s_nationkey), MAX(s_acctbal)
from nation, supplier
where s_nationkey = n_nationkey 
group by n_name
having count(s_nationkey) > 5;

--first find nations more than 5 suppliers