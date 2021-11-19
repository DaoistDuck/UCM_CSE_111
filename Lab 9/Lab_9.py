import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn


def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def dropViews(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Dropping All Views")

    try:
        sql = """DROP VIEW IF EXISTS Customer_Info;"""
        _conn.execute(sql)

        sql = """DROP VIEW IF EXISTS Supplier_Info;"""
        _conn.execute(sql)

        sql = """DROP VIEW IF EXISTS Orders_Info;"""
        _conn.execute(sql)

        sql = """DROP VIEW IF EXISTS Min_Max_Discount;"""
        _conn.execute(sql)

        sql = """DROP VIEW IF EXISTS Customer_Positive_Balance;"""
        _conn.execute(sql)

        sql = """DROP VIEW IF EXISTS Supplier_Negative_Balance;"""
        _conn.execute(sql)
        print("success")

    except Error as e:
        print(e)


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    try:
        sql = """CREATE VIEW IF NOT EXISTS Customer_Info(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS
                SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name , r_name
                FROM customer, nation, region
                WHERE c_nationkey = n_nationkey AND n_regionkey = r_regionkey;"""

        _conn.execute(sql)
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    try:
        sql = """CREATE VIEW IF NOT EXISTS Supplier_Info(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
                SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
                FROM supplier, nation, region
                WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey;"""

        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")

    try:
        sql = """CREATE VIEW IF NOT EXISTS Orders_Info(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS
                SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
                FROM orders;"""

        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")

    try:
        sql = """CREATE VIEW IF NOT EXISTS Min_Max_Discount(p_type, min_discount, max_discount) AS
                SELECT p_type, min(l_discount), max(l_discount)
                FROM part, lineitem
                WHERE p_partkey = l_partkey
                GROUP BY p_type;"""

        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V151")

    try:
        sql = """CREATE VIEW IF NOT EXISTS Customer_Positive_Balance(c_custkey, c_name, c_nationkey, c_acctbal) AS
                SELECT c_custkey, c_name, c_nationkey, c_acctbal
                FROM customer
                WHERE c_acctbal > 0;"""

        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")

    try:
        sql = """CREATE VIEW IF NOT EXISTS Supplier_Negative_Balance(s_suppkey, s_name, s_nationkey, s_acctbal) AS
                SELECT s_suppkey, s_name, s_nationkey, s_acctbal
                FROM supplier
                WHERE s_acctbal < 0;"""

        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    Q1Output = open("output/1.out", "w")

    try:
        sql = """SELECT Customer_Info.c_name, sum(o_totalprice)
                FROM Customer_Info, orders
                WHERE Customer_Info.c_custkey = o_custkey
                AND Customer_Info.c_nation = 'FRANCE'
                AND o_orderdate like '1995-__-__'
                group by Customer_Info.c_name;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<10}|{:<10}".format(row[0], row[1])
            print(data)
            Q1Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1temp(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1temp")

    Q1Output = open("output/1temp.out", "w")

    try:
        sql = """SELECT *
                FROM Customer_Info;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<2}|{:<10}|{:<10}|{:<10}|{:<5}|{:<5}|{:<10}|{:<5}|{:<10}".format(
                row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]
            )
            print(data)
            Q1Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    Q2Output = open("output/2.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_region, count(*)
                FROM Supplier_Info
                GROUP BY Supplier_Info.s_region;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<12}|{:<10}".format(row[0], row[1])
            print(data)
            Q2Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    Q3Output = open("output/3.out", "w")

    try:
        sql = """SELECT Customer_Info.c_nation, count(*)
                FROM Customer_Info, orders
                WHERE Customer_Info.c_custkey = o_custkey
                AND Customer_Info.c_region = 'AMERICA'
                GROUP BY Customer_Info.c_nation;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<10}".format(row[0], row[1])
            print(data)
            Q3Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    Q4Output = open("output/4.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_name, count(ps_partkey)
                FROM Supplier_Info, partsupp, part
                WHERE p_partkey = ps_partkey
                AND ps_suppkey = Supplier_Info.s_suppkey
                AND Supplier_Info.s_nation = 'CANADA'
                AND p_size < 20
                GROUP BY Supplier_Info.s_name;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<10}".format(row[0], row[1])
            print(data)
            Q4Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    Q5Output = open("output/5.out", "w")

    try:
        sql = """SELECT Customer_Info.c_name, count(*)
                FROM Customer_Info, Orders_Info
                WHERE Orders_Info.o_custkey = Customer_Info.c_custkey
                AND Customer_Info.c_nation = 'GERMANY'
                AND Orders_Info.o_orderyear like '1993-__-__'
                GROUP BY Customer_Info.c_name;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<10}".format(row[0], row[1])
            print(data)
            Q5Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    Q6Output = open("output/6.out", "w")

    try:
        sql = """SELECT s_name, Orders_Info.o_orderpriority, count(distinct ps_partkey)
                FROM partsupp, Orders_Info, lineitem, supplier, nation
                WHERE l_orderkey = Orders_Info.o_orderkey
                AND l_partkey = ps_partkey
                AND l_suppkey = ps_suppkey
                AND ps_suppkey = s_suppkey
                AND s_nationkey = n_nationkey
                AND n_name = 'CANADA'
                GROUP BY s_name, Orders_Info.o_orderpriority;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<15}|{:<10}".format(row[0], row[1], row[2])
            print(data)
            Q6Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    Q7Output = open("output/7.out", "w")

    try:
        sql = """SELECT Customer_Info.c_nation, Orders_Info.o_orderstatus, count(*)
                FROM Customer_Info, Orders_Info
                WHERE Customer_Info.c_custkey = Orders_Info.o_custkey
                AND Customer_Info.c_region = 'AMERICA'
                GROUP BY Customer_Info.c_nation, Orders_Info.o_orderstatus;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<13}|{:<1}|{:<5}".format(row[0], row[1], row[2])
            print(data)
            Q7Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    Q8Output = open("output/8.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_nation, count(distinct l_orderkey) as co
                FROM Supplier_Info, Orders_Info, lineitem
                WHERE Orders_Info.o_orderkey = l_orderkey
                AND l_suppkey = Supplier_Info.s_suppkey
                AND Orders_Info.o_orderstatus = 'F'
                AND Orders_Info.o_orderyear like '1995-__-__'
                GROUP BY Supplier_Info.s_nation
                HAVING co > 50;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<10}".format(row[0], row[1])
            print(data)
            Q8Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    Q9Output = open("output/9.out", "w")

    try:
        sql = """SELECT count(distinct Orders_Info.o_clerk)
                FROM Supplier_Info, Orders_Info, lineitem
                WHERE Orders_Info.o_orderkey = l_orderkey
                AND l_suppkey = Supplier_Info.s_suppkey
                AND Supplier_Info.s_nation = 'UNITED STATES';"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<10}".format(row[0])
            print(data)
            Q9Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    Q10Output = open("output/10.out", "w")

    try:
        sql = """SELECT Min_Max_Discount.p_type, Min_Max_Discount.min_discount, Min_Max_Discount.max_discount
                FROM Min_Max_Discount
                WHERE Min_Max_Discount.p_type like '%ECONOMY%'
                AND Min_Max_Discount.p_type like '%COPPER%'
                group by Min_Max_Discount.p_type;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<25}|{:<1}|{:<10}".format(row[0], row[1], row[2])
            print(data)
            Q10Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    Q11Output = open("output/11.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_region, Supplier_Info.s_name, Supplier_Info.s_acctbal
                FROM Supplier_Info
                WHERE Supplier_Info.s_acctbal = (SELECT MAX(Supplier_Info2.s_acctbal) FROM Supplier_Info as Supplier_Info2 WHERE Supplier_Info2.s_region = Supplier_Info.s_region);"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<12}|{:<10}|{:<10}".format(row[0], row[1], row[2])
            print(data)
            Q11Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    Q12Output = open("output/12.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_nation, max(Supplier_Info.s_acctbal) as mb
                FROM Supplier_Info
                GROUP BY Supplier_Info.s_nation
                HAVING mb > 9000;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<15}|{:<10}".format(row[0], row[1])
            print(data)
            Q12Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")

    Q13Output = open("output/13.out", "w")

    try:
        sql = """SELECT COUNT(*)
                FROM Customer_Info, Supplier_Info, orders, lineitem
                WHERE o_orderkey = l_orderkey
                AND o_custkey = Customer_Info.c_custkey
                AND l_suppkey = Supplier_Info.s_suppkey
                AND Supplier_Info.s_region = 'AFRICA'
                AND Customer_Info.c_nation = 'UNITED STATES';"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<10}".format(row[0])
            print(data)
            Q13Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    Q14Output = open("output/14.out", "w")

    try:
        sql = """SELECT Supplier_Info.s_region, Customer_Info.c_region, max(o_totalprice)
                FROM lineitem, Supplier_Info, orders, Customer_Info
                WHERE l_suppkey = Supplier_Info.s_suppkey
                AND l_orderkey = o_orderkey
                AND o_custkey = Customer_Info.c_custkey
                GROUP BY Supplier_Info.s_region, Customer_Info.c_region;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<12}|{:<12}|{:<10}".format(row[0], row[1], row[2])
            print(data)
            Q14Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    Q15Output = open("output/15.out", "w")

    try:
        sql = """SELECT COUNT(DISTINCT l_orderkey)
                FROM lineitem, Supplier_Negative_Balance, orders, Customer_Positive_Balance
                WHERE l_suppkey = Supplier_Negative_Balance.s_suppkey
                AND l_orderkey = o_orderkey
                AND o_custkey = Customer_Positive_Balance.c_custkey;"""

        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            data = "{:<12}".format(row[0])
            print(data)
            Q15Output.write(data + "\n")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropViews(conn)
        create_View1(conn)
        Q1(conn)
        Q1temp(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()
