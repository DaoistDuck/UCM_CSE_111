DROP TRIGGER IF EXISTS t41;
CREATE TRIGGER IF NOT EXISTS t41 AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = '2-HIGH'
    WHERE o_orderkey = OLD.l_orderkey;
END;

DELETE FROM lineitem
WHERE l_orderkey = (
SELECT DISTINCT l_orderkey
FROM lineitem, orders
WHERE o_orderkey = l_orderkey
AND strftime('%Y-%m',o_orderdate) = '1995-12');

SELECT COUNT(o_orderpriority)
FROM orders
WHERE o_orderdate BETWEEN '1995-10' AND '1995-12'
AND o_orderpriority = '2-HIGH';

-- SELECT COUNT(DISTINCT o_orderkey)
-- FROM orders, lineitem
-- WHERE strftime('%Y-%m',o_orderdate) = '1995-12'
-- AND o_orderkey = l_orderkey

--https://en.wikipedia.org/wiki/Trimester