--SQLite

WITH smallAmount AS(

SELECT r_name
FROM region, nation, customer, supplier, lineitem
WHERE c_nationkey = s_nationkey AND s_nationkey = n_nationkey 
AND n_regionkey = r_regionkey AND s_suppkey = l_suppkey
AND l_extendedprice = (select min(l_extendedprice) from lineitem)
)

SELECT DISTINCT smallAmount.r_name
FROM smallAmount