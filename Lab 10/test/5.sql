DROP TRIGGER IF EXISTS t5;
CREATE TRIGGER IF NOT EXISTS t5 AFTER DELETE ON part
FOR EACH ROW
BEGIN
    DELETE FROM partsupp WHERE ps_partkey = OLD.p_partkey;
    DELETE FROM lineitem WHERE l_partkey = OLD.p_partkey;
END;

DELETE FROM part
WHERE p_partkey IN (
SELECT ps_partkey
FROM partsupp, supplier, nation WHERE ps_suppkey = s_suppkey
AND s_nationkey = n_nationkey
AND n_name IN('UNITED STATES', 'CANADA'));
--https://www.sqlitetutorial.net/sqlite-in/

SELECT n_name, COUNT(ps_partkey) as numPart
FROM supplier, nation, region, partsupp
WHERE ps_suppkey = s_suppkey
AND s_nationkey = n_nationkey
AND n_regionkey = r_regionkey 
AND r_name = 'AMERICA'
GROUP BY n_name
ORDER BY numPart DESC;
--this will take a while