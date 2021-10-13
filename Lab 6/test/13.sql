--SQLite

with totalLineItemPrice AS(
SELECT n_name, total(l_extendedprice) as totalPrice
FROM nation, supplier, lineitem
WHERE s_nationkey = n_nationkey 
AND s_suppkey = l_suppkey
AND strftime('%Y', l_shipdate) = '1994'
GROUP BY n_name
)

SELECT totalLineItemPrice.n_name
FROM totalLineItemPrice
GROUP BY totalLineItemPrice.n_name
ORDER BY totalLineItemPrice.totalPrice DESC
LIMIT 1

