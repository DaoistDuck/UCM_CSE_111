--SQLite


SELECT COUNT(DISTINCT c_name)
FROM customer, orders as o1
WHERE c_custkey = o_custkey

AND NOT EXISTS(

SELECT *
    FROM orders as o2, supplier, lineitem, nation, region
    WHERE o1.o_orderkey = o2.o_orderkey AND o2.o_orderkey = l_orderkey 
    AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey 
    AND n_regionkey = r_regionkey AND r_name NOT IN('AMERICA')
)

--this code runs a bit slow
--https://stackoverflow.com/questions/2246772/whats-the-difference-between-not-exists-vs-not-in-vs-left-join-where-is-null
-- can use either r_name IN('ASIA', 'EUROPE', 'AFRICA', 'MIDDLE EAST')
-- or r_name NOT IN('AMERICA')