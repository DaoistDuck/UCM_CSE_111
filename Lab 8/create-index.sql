--drop doesnt need the ON argue
--use expert and make idx statement
DROP INDEX IF EXISTS customer_idx_c_name;--1
--2 did not require index
DROP INDEX IF EXISTS lineitem_idx_l_returnflag_l_receiptdate;--2
--4 did not require index
DROP INDEX IF EXISTS customer_idx_c_mktsegment;
DROP INDEX IF EXISTS nation_idx_n_nationkey_n_name;--6
DROP INDEX IF EXISTS customer_idx_c_custkey;--6
DROP INDEX IF EXISTS orders_idx_o_orderdate;--6
DROP INDEX IF EXISTS customer_idx_c_mktsegment;
DROP INDEX IF EXISTS lineitem_idx_l_orderkey;--7
DROP INDEX IF EXISTS orders_idx_o_custkey_o_orderkey;--7
DROP INDEX IF EXISTS customer_idx_c_name_c_custkey;--7
DROP INDEX IF EXISTS supplier_idx_s_nationkey_s_acctbal;--8
DROP INDEX IF EXISTS nation_idx_n_regionkey_n_nationkey;--8
DROP INDEX IF EXISTS region_idx_r_name_r_regionkey;--8
DROP INDEX IF EXISTS nation_idx_n_name;--9
DROP INDEX IF EXISTS orders_idx_o_custkey_o_orderdate;--10
DROP INDEX IF EXISTS orders_idx_o_orderkey;--11
DROP INDEX IF EXISTS lineitem_idx_l_discount;--11
DROP INDEX IF EXISTS region_idx_r_regionkey_r_name;--12
DROP INDEX IF EXISTS orders_idx_o_orderstatus;--12
--13 no new indexes
DROP INDEX IF EXISTS orders_idx_o_orderpriority_o_orderdate;--14
DROP INDEX IF EXISTS lineitem_idx_l_orderkey_l_suppkey;--15
DROP INDEX IF EXISTS supplier_idx_s_nationkey_s_suppkey;--15
DROP INDEX IF EXISTS orders_idx_o_orderpriority_o_orderkey;--15


CREATE INDEX IF NOT EXISTS customer_idx_c_name ON customer(c_name); --1
--2 no index needed
CREATE INDEX IF NOT EXISTS lineitem_idx_l_returnflag_l_receiptdate ON lineitem(l_returnflag, l_receiptdate);--3
-- --4 did not require an index
CREATE INDEX IF NOT EXISTS customer_idx_c_mktsegment ON customer(c_mktsegment);--5
CREATE INDEX IF NOT EXISTS nation_idx_n_nationkey_n_name ON nation(n_nationkey, n_name);--6
CREATE INDEX IF NOT EXISTS customer_idx_c_custkey ON customer(c_custkey);--6
CREATE INDEX IF NOT EXISTS orders_idx_o_orderdate ON orders(o_orderdate);--6
CREATE INDEX IF NOT EXISTS lineitem_idx_l_orderkey ON lineitem(l_orderkey);--7
CREATE INDEX IF NOT EXISTS orders_idx_o_custkey_o_orderkey ON orders(o_custkey, o_orderkey);--7
CREATE INDEX IF NOT EXISTS customer_idx_c_name_c_custkey ON customer(c_name, c_custkey);--7
CREATE INDEX IF NOT EXISTS supplier_idx_s_nationkey_s_acctbal ON supplier(s_nationkey, s_acctbal);--8
CREATE INDEX IF NOT EXISTS nation_idx_n_regionkey_n_nationkey ON nation(n_regionkey, n_nationkey);--8
CREATE INDEX IF NOT EXISTS region_idx_r_name_r_regionkey ON region(r_name, r_regionkey);--8
CREATE INDEX IF NOT EXISTS nation_idx_n_name ON nation(n_name);--9
CREATE INDEX IF NOT EXISTS orders_idx_o_custkey_o_orderdate ON orders(o_custkey, o_orderdate);--10
CREATE INDEX IF NOT EXISTS customer_idx_c_nationkey_c_custkey ON customer(c_nationkey, c_custkey);--10
CREATE INDEX IF NOT EXISTS orders_idx_o_orderkey ON orders(o_orderkey);--11
CREATE INDEX IF NOT EXISTS lineitem_idx_l_discount ON lineitem(l_discount);--11
CREATE INDEX IF NOT EXISTS region_idx_r_regionkey_r_name ON region(r_regionkey, r_name);--12
CREATE INDEX IF NOT EXISTS orders_idx_o_orderstatus ON orders(o_orderstatus);--12
--13 no new indexes
CREATE INDEX IF NOT EXISTS orders_idx_o_orderpriority_o_orderdate ON orders(o_orderpriority, o_orderdate);--14
CREATE INDEX IF NOT EXISTS lineitem_idx_l_orderkey_l_suppkey ON lineitem(l_orderkey, l_suppkey);--15
CREATE INDEX IF NOT EXISTS supplier_idx_s_nationkey_s_suppkey ON supplier(s_nationkey, s_suppkey);--15
CREATE INDEX IF NOT EXISTS orders_idx_o_orderpriority_o_orderkey ON orders(o_orderpriority, o_orderkey);--15