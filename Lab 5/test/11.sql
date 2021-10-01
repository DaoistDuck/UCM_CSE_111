--SQLite

SELECT DISTINCT p1.p_name
FROM lineitem, orders, part as p1,
(
    SELECT p2.p_partkey, min(l_extendedprice*(1-l_discount)) as lowvalue
    FROM lineitem, orders,part as p2
    WHERE l_orderkey = o_orderkey AND l_partkey = p2.p_partkey
    AND strftime('%Y-%m-%d', o_orderdate) > '1996-10-02'
)as minvalueitem
WHERE l_orderkey = o_orderkey AND l_partkey = p1.p_partkey
AND strftime('%Y-%m-%d', o_orderdate) > '1996-10-02'
AND p1.p_partkey = minvalueitem.p_partkey;