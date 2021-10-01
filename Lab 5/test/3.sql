--SQLite

SELECT min(li1.l_discount)
FROM lineitem as li1, orders as o1, 
(

    SELECT avg(l_discount) as avg_line_item_discount
    FROM lineitem, orders
    WHERE l_orderkey = o_orderkey AND strftime('%Y-%m', o_orderdate) = '1996-10'

) as lineitem2
WHERE li1.l_orderkey = o1.o_orderkey AND strftime('%Y-%m', o1.o_orderdate) = '1996-10'
AND li1.l_discount > lineitem2.avg_line_item_discount
--subquery to find avg of all discounts
--cant do aggreiates, use subquery instead
--0.04