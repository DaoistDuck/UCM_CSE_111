--SQLite

SELECT count(c_custkey)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey AND n_regionkey = r_regionkey
AND r_name NOT IN('EUROPE', 'AFRICA', 'ASIA');

--https://www.techonthenet.com/sqlite/not.php