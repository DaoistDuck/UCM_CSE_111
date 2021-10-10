--SQLite
SELECT n_name, total(l_extendedprice) as totalPrice
FROM nation, customer, orders, lineitem
WHERE c_nationkey = n_nationkey AND c_custkey = o_custkey 
AND o_orderkey = l_orderkey AND strftime('%Y', l_shipdate) == '1994'
GROUP BY n_name
ORDER BY totalPrice DESC
--LIMIT 1
