--SQLite

SELECT cnation.n_name, count(distinct c_custkey), count(distinct s_suppkey)
FROM nation as cnation, region as cregion, nation as snation, region as sregion, customer, supplier
WHERE c_nationkey = cnation.n_nationkey AND cnation.n_regionkey = cregion.r_regionkey AND cregion.r_name = 'AFRICA'
AND s_nationkey = snation.n_nationkey AND snation.n_regionkey = sregion.r_regionkey AND sregion.r_name = 'AFRICA'
AND cnation.n_comment = snation.n_comment
GROUP BY cnation.n_name;