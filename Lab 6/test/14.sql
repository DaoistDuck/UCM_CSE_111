--SQLite

WITH localSup AS(
SELECT n_name AS supNat, count(l_linenumber) AS numLocalSup
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey = n_nationkey
AND c_nationkey != n_nationkey
AND strftime('%Y',l_shipdate) = '1994'
GROUP BY n_name
), localCus AS(
SELECT n_name AS cusNat, count(l_linenumber) AS numLocalCus
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey != n_nationkey
AND c_nationkey = n_nationkey
AND strftime('%Y',l_shipdate) = '1994'
GROUP BY n_name
)
SELECT localSup.supNat, localSup.numLocalSup - localCus.numLocalCus
FROM localSup, localCus
WHERE localSup.supNat = localCus.cusNat
GROUP BY localSup.supNat