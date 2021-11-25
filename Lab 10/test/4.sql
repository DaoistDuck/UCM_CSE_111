DROP TRIGGER IF EXISTS t41;
CREATE TRIGGER IF NOT EXISTS t41 AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey = OLD.l_orderkey;
END;

DROP TRIGGER IF EXISTS t42;
CREATE TRIGGER IF NOT EXISTS t42 AFTER INSERT ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey = NEW.l_orderkey;
END;

DELETE FROM lineitem
WHERE l_orderkey IN (
SELECT l_orderkey
FROM lineitem, orders
WHERE strftime('%Y-%m',o_orderdate) = '1995-12'
AND l_orderkey = o_orderkey);

SELECT COUNT(o_orderkey)
FROM orders
WHERE strftime('%Y-%m',o_orderdate) BETWEEN '1995-10' AND '1995-12'
AND o_orderpriority = 'HIGH';

--https://en.wikipedia.org/wiki/Trimester