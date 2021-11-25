DROP TRIGGER IF EXISTS t3;
CREATE TRIGGER IF NOT EXISTS t3 AFTER UPDATE ON customer
BEGIN
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE NEW.c_acctbal > 0
    AND c_custkey = NEW.c_custkey;
END;

UPDATE customer SET c_acctbal = 100
WHERE c_nationkey IN (SELECT n_nationkey FROM nation WHERE n_name = 'UNITED STATES');

SELECT COUNT(c_custkey)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey
AND n_regionkey = r_regionkey 
AND r_name = 'AMERICA'
AND c_acctbal < 0;