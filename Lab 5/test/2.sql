--SQLite

SELECT r1.r_name, count(s_suppkey)
FROM region as r1, nation as n1, supplier as s1,
(

    SELECT r_regionkey, avg(s_acctbal) as avg
    FROM region, supplier, nation
    WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey
    GROUP by r_name

) as region_avg

WHERE s1.s_nationkey = n1.n_nationkey AND n1.n_regionkey = r1.r_regionkey AND 
region_avg.r_regionkey = r1.r_regionkey
AND s1.s_acctbal < region_avg.avg
GROUP BY r1.r_name;

--subquerying a new table that has the avg acctbal of suppliers and regionkey
