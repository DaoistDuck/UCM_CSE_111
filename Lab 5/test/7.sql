--SQLite

SELECT o_orderpriority, count(o_orderkey)
FROM orders, lineitem
WHERE o_orderkey = l_orderkey AND strftime('%Y', o_orderdate) = '1997'
AND DATE(l_receiptdate) > DATE(l_commitdate)
GROUP BY o_orderpriority;