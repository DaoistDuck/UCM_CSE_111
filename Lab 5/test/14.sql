--SQLite

SELECT supregion.r_name, cusregion.r_name, strftime('%Y', l_shipdate), total((l_extendedprice*(1-l_discount)))
FROM region as supregion, nation as supnation, region as cusregion, nation as cusnation, supplier, customer, lineitem, orders
WHERE c_nationkey = cusnation.n_nationkey AND cusnation.n_regionkey = cusregion.r_regionkey
AND s_nationkey = supnation.n_nationkey AND supnation.n_regionkey = supregion.r_regionkey
AND s_suppkey = l_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey
AND strftime('%Y', l_shipdate) BETWEEN '1996' AND '1997'
GROUP BY supregion.r_name, cusregion.r_name,strftime('%Y', l_shipdate);