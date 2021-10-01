--SQLite

WITH totalrevenue as 
(
    SELECT sum((l_extendedprice * (1 - l_discount))) as total
    FROM region as totalcusregion, nation as totalsupnation, nation as totalcusnation, customer, supplier, lineitem, orders
    WHERE c_nationkey = totalcusnation.n_nationkey AND totalcusnation.n_regionkey = totalcusregion.r_regionkey AND totalcusregion.r_name = 'ASIA'
    AND s_nationkey = totalsupnation.n_nationkey
    AND s_suppkey = l_suppkey AND c_custkey = o_custkey AND o_orderkey = l_orderkey
    AND strftime('%Y', l_shipdate) = '1997'
)



SELECT round((sum((unlineitem.l_extendedprice * (1 - unlineitem.l_discount))) / totalrevenue.total), 17) -- on my system, it had a rounding issue so i just used the round function in sqlite to fix it
--SELECT sum((unlineitem.l_extendedprice * (1 - unlineitem.l_discount))) / totalrevenue.total
FROM region as cusregion, nation as cusnation, nation as supnation, customer as asiacustomer, supplier as unsupplier, lineitem as unlineitem, orders as asiaorders
,totalrevenue


WHERE asiacustomer.c_nationkey = cusnation.n_nationkey AND cusnation.n_regionkey = cusregion.r_regionkey AND cusregion.r_name = 'ASIA'
AND unsupplier.s_nationkey = supnation.n_nationkey AND supnation.n_name = 'UNITED STATES'
AND unsupplier.s_suppkey = unlineitem.l_suppkey AND asiacustomer.c_custkey = asiaorders.o_custkey AND asiaorders.o_orderkey = unlineitem.l_orderkey
AND strftime('%Y', unlineitem.l_shipdate) = '1997'


-- http://www.silota.com/docs/recipes/sql-percentage-total.html
