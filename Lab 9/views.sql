`-- SQLite
.schema
--1 view
DROP VIEW IF EXISTS Customer_Info;
CREATE VIEW IF NOT EXISTS Customer_Info(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS
SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name , r_name
FROM customer, nation, region
WHERE c_nationkey = n_nationkey AND n_regionkey = r_regionkey;

--2 view
DROP VIEW IF EXISTS Supplier_Info;
CREATE VIEW IF NOT EXISTS Supplier_Info(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
FROM supplier, nation, region
WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey;

--5 view
DROP VIEW IF EXISTS Orders_Info;
CREATE VIEW IF NOT EXISTS Orders_Info(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS
SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
FROM orders;

--10 view
DROP VIEW IF EXISTS Min_Max_Discount;
CREATE VIEW IF NOT EXISTS Min_Max_Discount(p_type, min_discount, max_discount) AS
SELECT p_type, min(l_discount), max(l_discount)
FROM part, lineitem
WHERE p_partkey = l_partkey
GROUP BY p_type;

--151 view
DROP VIEW IF EXISTS Customer_Positive_Balance;
CREATE VIEW IF NOT EXISTS Customer_Positive_Balance(c_custkey, c_name, c_nationkey, c_acctbal) AS
SELECT c_custkey, c_name, c_nationkey, c_acctbal
FROM customer
WHERE c_acctbal > 0;

--152 view
DROP VIEW IF EXISTS Supplier_Negative_Balance;
CREATE VIEW IF NOT EXISTS Supplier_Negative_Balance(s_suppkey, s_name, s_nationkey, s_acctbal) AS
SELECT s_suppkey, s_name, s_nationkey, s_acctbal
FROM supplier
WHERE s_acctbal < 0;

--1 sql
-- select c_name, sum(o_totalprice)
-- from orders, customer, nation
-- where o_custkey = c_custkey and
-- 	n_nationkey = c_nationkey and
-- 	n_name = 'FRANCE' AND
-- 	o_orderdate like '1995-__-__'
-- group by c_name;

--1 view sql v1
-- SELECT Customer_Info.c_name, sum(o_totalprice)
-- FROM Customer_Info, orders
-- WHERE Customer_Info.c_custkey = o_custkey
-- AND Customer_Info.c_nation = 'FRANCE' 
-- AND	o_orderdate like '1995-__-__'
-- group by Customer_Info.c_name;

--2 sql
-- select r_name, count(*)
-- from supplier, nation, region
-- where s_nationkey = n_nationkey
--     and n_regionkey = r_regionkey
-- group by r_name;

-- 2 view sql v2
-- SELECT Supplier_Info.s_region, count(*)
-- FROM Supplier_Info
-- GROUP BY Supplier_Info.s_region;

-- --3 sql
-- select n_name, count(*)
-- from orders, nation, region, customer
-- where c_custkey = o_custkey
--     and c_nationkey = n_nationkey
--     and n_regionkey = r_regionkey
--     and r_name='AMERICA'
-- group by n_name;

-- --3 view sql v1
-- SELECT Customer_Info.c_nation, count(*)
-- FROM Customer_Info, orders
-- WHERE Customer_Info.c_custkey = o_custkey
-- AND Customer_Info.c_region = 'AMERICA'
-- GROUP BY Customer_Info.c_nation;

-- --4 sql
-- select s_name, count(ps_partkey)
-- from partsupp, supplier, nation, part
-- where p_partkey = ps_partkey
--     and ps_suppkey = s_suppkey
--     and s_nationkey = n_nationkey
--     and n_name = 'CANADA'
--     and p_size < 20
-- group by s_name;

-- --4 view sql v2
-- SELECT Supplier_Info.s_name, count(ps_partkey)
-- FROM Supplier_Info, partsupp, part 
-- WHERE p_partkey = ps_partkey 
-- AND ps_suppkey = Supplier_Info.s_suppkey
-- AND Supplier_Info.s_nation = 'CANADA'
-- AND p_size < 20
-- GROUP BY Supplier_Info.s_name;


-- --5 sql
-- select c_name, count(*)
-- from orders, customer, nation
-- where o_custkey = c_custkey
--     and c_nationkey = n_nationkey
--     and n_name = 'GERMANY'
--     and o_orderdate like '1993-__-__'
-- group by c_name;

--5 view sql v1, v5
-- SELECT Customer_Info.c_name, count(*)
-- FROM Customer_Info, Orders_Info
-- WHERE Orders_Info.o_custkey = Customer_Info.c_custkey
-- AND Customer_Info.c_nation = 'GERMANY'
-- AND Orders_Info.o_orderyear like '1993-__-__'
-- GROUP BY Customer_Info.c_name;

--6 sql
-- select s_name, o_orderpriority, count(distinct ps_partkey)
-- from partsupp, orders, lineitem, supplier, nation
-- where l_orderkey = o_orderkey
--     and l_partkey = ps_partkey
--     and l_suppkey = ps_suppkey
--     and ps_suppkey = s_suppkey
--     and s_nationkey = n_nationkey
--     and n_name = 'CANADA'
-- group by s_name, o_orderpriority;

--6 view sql v5
-- SELECT s_name, Orders_Info.o_orderpriority, count(distinct ps_partkey)
-- FROM partsupp, Orders_Info, lineitem, supplier, nation
-- WHERE l_orderkey = Orders_Info.o_orderkey
-- AND l_partkey = ps_partkey
-- AND l_suppkey = ps_suppkey
-- AND ps_suppkey = s_suppkey
-- AND s_nationkey = n_nationkey
-- AND n_name = 'CANADA'
-- GROUP BY s_name, Orders_Info.o_orderpriority;

--7 sql
-- select n_name, o_orderstatus, count(*)
-- from orders, customer, nation, region
-- where o_custkey = c_custkey
--     and c_nationkey = n_nationkey
--     and n_regionkey = r_regionkey
--     and r_name='AMERICA'
-- group by n_name, o_orderstatus;

-- 7 view sql v1,v5
-- SELECT Customer_Info.c_nation, Orders_Info.o_orderstatus, count(*)
-- FROM Customer_Info, Orders_Info
-- WHERE Customer_Info.c_custkey = Orders_Info.o_custkey
-- AND Customer_Info.c_region = 'AMERICA'
-- GROUP BY Customer_Info.c_nation, Orders_Info.o_orderstatus;

-- 8 sql
-- select n_name, count(distinct l_orderkey) as co
-- from orders, nation, supplier, lineitem
-- where o_orderkey = l_orderkey
--     and l_suppkey = s_suppkey
--     and s_nationkey = n_nationkey
--     and o_orderstatus = 'F'
--     and o_orderdate like '1995-__-__'
-- group by n_name
-- having co > 50;

--8 view sql v2,v5
-- SELECT Supplier_Info.s_nation, count(distinct l_orderkey) as co 
-- FROM Supplier_Info, Orders_Info, lineitem
-- WHERE Orders_Info.o_orderkey = l_orderkey
-- AND l_suppkey = Supplier_Info.s_suppkey
-- AND Orders_Info.o_orderstatus = 'F'
-- AND Orders_Info.o_orderyear like '1995-__-__'
-- GROUP BY Supplier_Info.s_nation
-- HAVING co > 50;

--9 sql
-- select count(distinct o_clerk)
-- from orders, supplier, nation, lineitem
-- where o_orderkey = l_orderkey
--     and l_suppkey = s_suppkey
--     and s_nationkey = n_nationkey
--     and n_name = 'UNITED STATES';

-- 9 view sql v2 v5
-- SELECT count(distinct Orders_Info.o_clerk)
-- FROM Supplier_Info, Orders_Info, lineitem
-- WHERE Orders_Info.o_orderkey = l_orderkey
-- AND l_suppkey = Supplier_Info.s_suppkey
-- AND Supplier_Info.s_nation = 'UNITED STATES';

-- --10 sql
-- select p_type, min(l_discount), max(l_discount)
-- from lineitem, part
-- where l_partkey = p_partkey
--     -- and p_type like '%ECONOMY%'
--     -- and p_type like '%COPPER%'
-- group by p_type;

-- --10 view sql v10
SELECT Min_Max_Discount.p_type, Min_Max_Discount.min_discount,Min_Max_Discount.max_discount
FROM Min_Max_Discount
WHERE Min_Max_Discount.p_type like '%COPPER%'
AND Min_Max_Discount.p_type like '%ECONOMY%'
GROUP BY Min_Max_Discount.p_type;


--11 sql
-- select r.r_name, s.s_name, s.s_acctbal
-- from supplier s, nation n, region r
-- where s.s_nationkey = n.n_nationkey
--         and n.n_regionkey = r.r_regionkey
--         and s.s_acctbal = (select max(s1.s_acctbal)
-- 							from supplier s1, nation n1, region r1
-- 							where s1.s_nationkey = n1.n_nationkey
-- 								and n1.n_regionkey = r1.r_regionkey
-- 								and r.r_regionkey = r1.r_regionkey
-- 						);

--11 view sql v2
-- SELECT Supplier_Info.s_region, Supplier_Info.s_name, Supplier_Info.s_acctbal
-- FROM Supplier_Info
-- WHERE Supplier_Info.s_acctbal = (SELECT MAX(Supplier_Info2.s_acctbal) FROM Supplier_Info as Supplier_Info2 WHERE Supplier_Info2.s_region = Supplier_Info.s_region);

--12 sql
-- select n_name, max(s_acctbal) as mb
-- from supplier, nation
-- where s_nationkey = n_nationkey
-- group by n_name
-- having mb > 9000;

--12 view sql v2
-- SELECT Supplier_Info.s_nation, max(Supplier_Info.s_acctbal) as mb
-- FROM Supplier_Info
-- GROUP BY Supplier_Info.s_nation
-- HAVING mb > 9000;

--13 sql 
-- select count(*)
-- from orders, lineitem, customer, supplier, nation n1, region, nation n2
-- where o_orderkey = l_orderkey
--     and o_custkey = c_custkey
--     and l_suppkey = s_suppkey
--     and s_nationkey = n1.n_nationkey
--     and n1.n_regionkey = r_regionkey
--     and c_nationkey = n2.n_nationkey
--     and r_name = 'AFRICA'
--     and n2.n_name = 'UNITED STATES';

--13 view sql v1 v2
-- SELECT COUNT(*)
-- FROM Customer_Info, Supplier_Info, orders, lineitem
-- WHERE o_orderkey = l_orderkey
-- AND o_custkey = Customer_Info.c_custkey
-- AND l_suppkey = Supplier_Info.s_suppkey
-- AND Supplier_Info.s_region = 'AFRICA'
-- AND Customer_Info.c_nation = 'UNITED STATES';

--14 sql
-- select r1.r_name as suppRegion, r2.r_name as custRegion, max(o_totalprice)
-- from lineitem, supplier, orders, customer, nation n1, region r1, nation n2, region r2
-- where l_suppkey = s_suppkey
--     and s_nationkey = n1.n_nationkey
--     and n1.n_regionkey = r1.r_regionkey
--     and l_orderkey = o_orderkey
--     and o_custkey = c_custkey
--     and c_nationkey = n2.n_nationkey
--     and n2.n_regionkey = r2.r_regionkey
-- group by r1.r_name, r2.r_name;

--14 view sql v1,v2
-- SELECT Supplier_Info.s_region, Customer_Info.c_region, max(o_totalprice)
-- FROM lineitem, Supplier_Info, orders, Customer_Info
-- WHERE l_suppkey = Supplier_Info.s_suppkey
-- AND l_orderkey = o_orderkey
-- AND o_custkey = Customer_Info.c_custkey
-- GROUP BY Supplier_Info.s_region, Customer_Info.c_region;

--15 sql
-- select count(distinct l_orderkey)
-- from lineitem, supplier, orders, customer
-- where l_suppkey = s_suppkey
--     and l_orderkey = o_orderkey
--     and o_custkey = c_custkey
--     and c_acctbal > 0
--     and s_acctbal < 0;

--15 view sql v151, v152
-- SELECT COUNT(DISTINCT l_orderkey)
-- FROM lineitem, Supplier_Negative_Balance, orders, Customer_Positive_Balance
-- WHERE l_suppkey = Supplier_Negative_Balance.s_suppkey 
-- AND l_orderkey = o_orderkey
-- AND o_custkey = Customer_Positive_Balance.c_custkey;
