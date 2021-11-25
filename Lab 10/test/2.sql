DROP TRIGGER IF EXISTS t2;
CREATE TRIGGER IF NOT EXISTS t2 AFTER UPDATE ON customer
BEGIN
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE NEW.c_acctbal < 0
    AND c_custkey = NEW.c_custkey;
END;

UPDATE customer SET c_acctbal = -100
WHERE c_nationkey IN (SELECT n_nationkey FROM nation, region WHERE n_regionkey = r_regionkey AND r_name = 'AMERICA');

SELECT COUNT(c_custkey)
FROM customer, nation
WHERE c_nationkey = n_nationkey
AND n_name = 'CANADA';