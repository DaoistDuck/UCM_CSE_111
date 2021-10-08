--SQLite

WITH numCus AS 
(SELECT o_custkey
FROM orders
WHERE strftime('%Y-%m',o_orderdate) == '1995-11'
GROUP BY o_custkey
HAVING count(*) >= 3)
SELECT count(*)
FROM numCus

--https://social.msdn.microsoft.com/Forums/sqlserver/en-US/62dbd5d1-263a-412b-b20e-b2eeb29dc31c/count-subset-of-rows-in-subquery?forum=transactsql
