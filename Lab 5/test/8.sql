--SQLite

SELECT count(DISTINCT s_suppkey)
FROM supplier, part, partsupp 
WHERE s_suppkey = ps_suppkey AND ps_partkey = p_partkey
AND p_type LIKE '%POLISHED%'
AND p_size IN (3,23,36,49);

--https://stackoverflow.com/questions/35742531/sql-or-statement-vs-multiple-select-queries