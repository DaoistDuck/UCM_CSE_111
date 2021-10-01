--SQLite

SELECT o_orderpriority, count(distinct o_orderkey)
FROM orders, lineitem
WHERE o_orderkey = l_orderkey AND ((strftime('%m', o_orderdate) + 2)/ 3) = 4
AND strftime('%Y', o_orderdate) = '1997'
AND strftime('%Y-%m-%d', l_commitdate) > strftime('%Y-%m-%d', l_receiptdate)
GROUP BY o_orderpriority;

--https://stackoverflow.com/questions/11197814/how-to-group-by-quarter-3-month-period-or-any-custom-time-period-in-sqlite/11198095