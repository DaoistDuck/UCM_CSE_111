--SQLite

SELECT strftime('%m', l_shipdate), sum(l_quantity)
FROM lineitem
WHERE strftime('%Y', l_shipdate) == '1995'
GROUP BY strftime('%m', l_shipdate);

--sum and total dont return the same thing