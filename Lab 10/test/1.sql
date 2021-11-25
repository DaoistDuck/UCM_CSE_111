DROP TRIGGER IF EXISTS t1;
CREATE TRIGGER IF NOT EXISTS t1 AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderdate = '2021-12-01'
    WHERE o_orderkey = NEW.o_orderkey;
END;

INSERT INTO orders
SELECT o_orderkey + 60000 , o_custkey, o_orderstatus, o_totalprice, o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment 
FROM orders
WHERE strftime('%Y-%m',o_orderdate) = '1996-12';

SELECT COUNT(o_orderkey)
FROM orders
WHERE strftime('%Y',o_orderdate) = '2021';