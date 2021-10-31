--SQLlite
/*
Two warehouses are created for every supplier.
The nations where these warehouses are located are those that have the largest number of lineitems supplied by the supplier that are ordered by customers from that nation. 
In case of equality, the nations are sorted in alphabetical order and the first two are selected. 
The name of a warehouse is obtained by concatenating the supplier name with “ ” and with the name of the nation where the warehouse is located. 
In order to determine the capacity of a warehouse, you have to compute the total size of the parts (p size) supplied by the supplier to the customers in a nation. 
Then, the warehouse capacity is taken as the double of the maximum total part size across all the nations. 
The two warehouses owned by a supplier have the same capacity. 
Finally, the w warehousekey value is set as an increasing number that is unique across the tuples in the table.

*/

.headers on

--This query does the 2nd line
SELECT n_name, count(l_linenumber) as totalNum, n_nationkey
FROM supplier, lineitem, customer, orders, nation
WHERE c_nationkey = n_nationkey
AND c_custkey = o_custkey
AND o_orderkey = l_orderkey
AND s_suppkey = l_suppkey
AND s_name = "Supplier#000000001"
GROUP BY n_name
ORDER BY totalNum DESC, n_name ASC
LIMIT 2;

SELECT n_name, s_name, TOTAL(p_size) as totalSize
FROM part, supplier, customer, nation, lineitem, orders
WHERE c_nationkey = n_nationkey
AND c_custkey = o_custkey
AND o_orderkey = l_orderkey
AND s_suppkey = l_suppkey
AND p_partkey = l_partkey
AND s_name = "Supplier#000000001"
GROUP BY n_name, s_name;

WITH nTotal AS(
SELECT n_name,  s_name, TOTAL(p_size) as totalSize
FROM part, supplier, customer, nation, lineitem, orders
WHERE c_nationkey = n_nationkey
AND c_custkey = o_custkey
AND o_orderkey = l_orderkey
AND s_suppkey = l_suppkey
AND p_partkey = l_partkey
AND s_name = "Supplier#000000001"
GROUP BY n_name, s_name
)
SELECT max(nTotal.totalSize) * 2 AS DoubleMaxTotalPartSize
FROM nTotal;
