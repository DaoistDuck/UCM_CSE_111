--SQLite

select p_type, min(l_discount), max(l_discount)
from part, lineitem
where p_partkey = l_partkey AND p_type like '%ECONOMY%' AND p_type like '%COPPER%'
group by p_type;


--https://www.sqlitetutorial.net/sqlite-like/