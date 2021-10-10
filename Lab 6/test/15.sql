--SQLite
WITH localSup1994 AS(
SELECT n_name AS supNat, count(l_linenumber) AS numLocalSup
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey = n_nationkey
AND c_nationkey != n_nationkey
AND strftime('%Y',l_shipdate) = '1994'
GROUP BY n_name
), localCus1994 AS(
SELECT n_name AS cusNat, count(l_linenumber) AS numLocalCus
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey != n_nationkey
AND c_nationkey = n_nationkey
AND strftime('%Y',l_shipdate) = '1994'
GROUP BY n_name
), differenceEcoEx1994 AS(
SELECT localSup1994.supNat as name, (localSup1994.numLocalSup - localCus1994.numLocalCus) as differenceEco
FROM localSup1994, localCus1994
WHERE localSup1994.supNat = localCus1994.cusNat
GROUP BY localSup1994.supNat
),
localSup1995 AS(
SELECT n_name AS supNat, count(l_linenumber) AS numLocalSup
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey = n_nationkey
AND c_nationkey != n_nationkey
AND strftime('%Y',l_shipdate) = '1995'
GROUP BY n_name
), localCus1995 AS(
SELECT n_name AS cusNat, count(l_linenumber) AS numLocalCus
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey != n_nationkey
AND c_nationkey = n_nationkey
AND strftime('%Y',l_shipdate) = '1995'
GROUP BY n_name
), differenceEcoEx1995 AS(
SELECT localSup1995.supNat as name, (localSup1995.numLocalSup - localCus1995.numLocalCus) as differenceEco
FROM localSup1995, localCus1995
WHERE localSup1995.supNat = localCus1995.cusNat
GROUP BY localSup1995.supNat
),localSup1996 AS(
SELECT n_name AS supNat, count(l_linenumber) AS numLocalSup
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey = n_nationkey
AND c_nationkey != n_nationkey
AND strftime('%Y',l_shipdate) = '1996'
GROUP BY n_name
), localCus1996 AS(
SELECT n_name AS cusNat, count(l_linenumber) AS numLocalCus
FROM nation, supplier, customer, lineitem, orders
WHERE l_suppkey = s_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey 
AND s_nationkey != n_nationkey
AND c_nationkey = n_nationkey
AND strftime('%Y',l_shipdate) = '1996'
GROUP BY n_name
), differenceEcoEx1996 AS(
SELECT localSup1996.supNat as name, (localSup1996.numLocalSup - localCus1996.numLocalCus) as differenceEco
FROM localSup1996, localCus1996
WHERE localSup1996.supNat = localCus1996.cusNat
GROUP BY localSup1996.supNat
)

SELECT differenceEcoEx1994.name, differenceEcoEx1995.differenceEco - differenceEcoEx1994.differenceEco, differenceEcoEx1996.differenceEco - differenceEcoEx1995.differenceEco
FROM differenceEcoEx1994, differenceEcoEx1995, differenceEcoEx1996
WHERE differenceEcoEx1994.name = differenceEcoEx1995.name
AND differenceEcoEx1995.name = differenceEcoEx1996.name
GROUP BY differenceEcoEx1994.name