-- SELECT COUNT(DISTINCT o_orderkey) -- DISTINCT counts order only once
-- FROM orders, lineitem AS l1, lineitem AS l2, supplier
-- WHERE o_orderkey = l1.l_orderkey
-- AND o_orderkey = l2.l_orderkey
-- AND l1.l_suppkey = s_suppkey
-- AND l2.l_suppkey = s_suppkey -- same supplier
-- AND l1.l_partkey NOT IN(l2.l_partkey); -- two different parts as sep lineitems
-- --AND l1.l_partkey != l2.l_partkey; -- two different parts as sep lineitems


-- SELECT n_name as nname, COUNT(DISTINCT o_orderkey)
-- FROM nation, orders, supplier, lineitem
-- WHERE o_orderkey = l_orderkey
-- AND l_suppkey = s_suppkey
-- AND s_nationkey = n_nationkey -- cuz it needs to find suppliers that both l1 and l2 provided
-- GROUP BY n_name
-- HAVING COUNT(l_suppkey) >= 2

-- SELECT l_orderkey
-- FROM lineitem, supplier
-- WHERE l_suppkey = s_suppkey
-- AND l_partkey NOT IN( SELECT l_partkey FROM lineitem
-- GROUP BY l_orderkey

-- -- SELECT numLineitem.nname, COUNT(DISTINCT o_orderkey)
-- -- FROM orders, numLineitem
-- -- WHERE o_orderkey = numLineitem.okey


-- SELECT n_name, COUNT(DISTINCT o_orderkey)
-- FROM nation, orders, supplier, lineitem AS l1, lineitem AS l2
-- WHERE o_orderkey = l1.l_orderkey
-- AND o_orderkey = l2.l_orderkey
-- AND l1.l_suppkey = s_suppkey
-- AND l2.l_suppkey = s_suppkey -- same supplier
-- AND l1.l_partkey NOT IN(l2.l_partkey) -- at least 2 lineitems provided by same supplier
-- AND s_nationkey = n_nationkey -- cuz it needs to find suppliers that both l1 and l2 provided
-- GROUP BY n_name

SELECT n_name, COUNT(DISTINCT o_orderkey)
FROM nation, orders, supplier, lineitem AS l0, lineitem AS l1, lineitem AS l2
WHERE s_nationkey = n_nationkey
AND o_orderkey = l0.l_orderkey
AND o_orderkey = l1.l_orderkey
AND o_orderkey = l2.l_orderkey
AND l0.l_suppkey = s_suppkey
AND l1.l_suppkey = s_suppkey
AND l2.l_suppkey = s_suppkey
AND l0.l_linenumber NOT IN(l1.l_linenumber,l2.l_linenumber)
AND l1.l_linenumber NOT IN(l0.l_linenumber,l2.l_linenumber)
AND l2.l_linenumber NOT IN(l1.l_linenumber,l0.l_linenumber)
GROUP BY n_name;

-- SELECT n_name, COUNT(DISTINCT o_orderkey)
-- FROM nation, orders, supplier, lineitem AS l0, lineitem AS l1
-- WHERE s_nationkey = n_nationkey
-- AND o_orderkey = l0.l_orderkey
-- AND o_orderkey = l1.l_orderkey
-- AND l0.l_suppkey = s_suppkey
-- AND l1.l_suppkey = s_suppkey
-- AND l0.l_linenumber NOT IN(l1.l_linenumber)
-- AND l1.l_linenumber NOT IN(l0.l_linenumber)
-- GROUP BY n_name;

-- DROP TABLE IF EXISTS RegionItems;
-- CREATE TABLE IF NOT EXISTS RegionItems(supReg, custReg, itemNo);
-- INSERT INTO RegionItems(supReg, custReg, itemNo)
--     SELECT sup.r_name, cust.r_name, COUNT(l_linenumber)
--     FROM supplier, nation as supnat, region as sup, nation as custnat, region as cust, orders, customer, lineitem
--     WHERE c_nationkey = custnat.n_nationkey
--     AND custnat.n_regionkey = cust.r_regionkey
--     AND s_nationkey = supnat.n_nationkey
--     AND supnat.n_regionkey = sup.r_regionkey
--     AND c_custkey = o_custkey
--     AND o_orderkey = l_orderkey
--     AND l_suppkey = s_suppkey
--     GROUP BY sup.r_name, cust.r_name;
-- DELETE FROM lineitem
-- WHERE l_orderkey IN(
-- SELECT l_orderkey
-- FROM lineitem, supplier, nation
-- WHERE l_suppkey = s_suppkey
-- AND s_nationkey = n_nationkey
-- AND n_name = 'FRANCE'
-- )

-- ROMANIA
-- BRAZIL

-- SELECT n1.n_nationkey, n2.n_nationkey
-- FROM nation as n1, nation as n2
-- WHERE n1.n_name = 'ROMANIA' 
-- AND n2.n_name = 'BRAZIL';

-- UPDATE customer set nationkey = 2
-- WHERE c_nationkey = 19

