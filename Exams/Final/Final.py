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


def T1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T1")

    sql = """SELECT COUNT(DISTINCT o_orderkey) -- DISTINCT counts order only once
            FROM orders, lineitem AS l0, lineitem AS l1, supplier
            WHERE o_orderkey = l0.l_orderkey
            AND o_orderkey = l1.l_orderkey
            AND l0.l_suppkey = s_suppkey
            AND l1.l_suppkey = s_suppkey -- same supplier
            AND l0.l_partkey NOT IN(l1.l_partkey) -- two different parts as sep lineitems
            AND l1.l_partkey NOT IN(l0.l_partkey);"""
    cursor = _conn.cursor()
    cursor.execute(sql)
    rows = cursor.fetchall()
    with open("output/1.out", "w") as file:
        header = "{:>10}\n".format("orders")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:>10}".format(row[0])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def T2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T2")

    sql = """SELECT n_name, COUNT(DISTINCT o_orderkey)
            FROM nation, orders, supplier, lineitem AS l0, lineitem AS l1
            WHERE o_orderkey = l0.l_orderkey
            AND o_orderkey = l1.l_orderkey
            AND l0.l_suppkey = s_suppkey
            AND l1.l_suppkey = s_suppkey -- same supplier
            AND l0.l_linenumber NOT IN(l1.l_linenumber)
            AND l1.l_linenumber NOT IN(l0.l_linenumber) -- at least 2 lineitems provided by same supplier
            AND s_nationkey = n_nationkey -- cuz it needs to find suppliers that both l1 and l2 provided
            GROUP BY n_name;"""
    cursor = _conn.cursor()
    cursor.execute(sql)
    rows = cursor.fetchall()

    with open("output/2.out", "w") as file:
        header = "{:<40} {:>10}\n".format("nation", "orders")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:<40} {:>10}\n".format(row[0], row[1])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def T3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T3")
    total_item = 0
    sql = """"""
    with open("input/3.in", "r") as file:
        k = int(file.readline().strip())
        total_item = k
    # print(total_item)
    range2 = total_item
    sql += (
        """SELECT n_name, COUNT(DISTINCT o_orderkey)\nFROM nation, orders, supplier"""
    )
    for i in range(total_item):
        sql += """, lineitem AS l{}""".format(i)
    sql += """\nWHERE s_nationkey = n_nationkey"""
    for i in range(total_item):
        sql += """\nAND o_orderkey = l{}.l_orderkey""".format(i)
    for i in range(total_item):
        sql += """\nAND l{}.l_suppkey = s_suppkey""".format(i)
    if total_item == 1:
        pass
    else:
        for i in range(0, total_item):
            sql += """\nAND l{}.l_linenumber NOT IN(""".format(i)
            for j in range(0, range2):
                if i == j:
                    pass
                else:
                    # print(j)
                    if j == range2 - 1:
                        sql += """l{}.l_linenumber)""".format(j)
                    else:
                        sql += """l{}.l_linenumber,""".format(j)
    sql = sql[:-1]
    sql += """)"""
    sql += """\nGROUP BY n_name;"""
    # print(sql)
    cursor = _conn.cursor()
    cursor.execute(sql)
    rows = cursor.fetchall()

    with open("output/3.out", "w") as file:
        header = "{:<40} {:>10}\n".format("nation", "orders")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:<40} {:>10}\n".format(row[0], row[1])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def T4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T4")
    cursor = _conn.cursor()
    sql = """DROP TABLE IF EXISTS RegionItems;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """CREATE TABLE IF NOT EXISTS RegionItems(supReg, custReg, itemNo);"""
    cursor.execute(sql)
    _conn.commit()
    sql = """INSERT INTO RegionItems(supReg, custReg, itemNo)
                SELECT sup.r_name, cust.r_name, COUNT(l_linenumber)
                FROM supplier, nation as supnat, region as sup, nation as custnat, region as cust, orders, customer, lineitem
                WHERE c_nationkey = custnat.n_nationkey
                AND custnat.n_regionkey = cust.r_regionkey
                AND s_nationkey = supnat.n_nationkey
                AND supnat.n_regionkey = sup.r_regionkey
                AND c_custkey = o_custkey
                AND o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                GROUP BY sup.r_name, cust.r_name;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """SELECT * FROM RegionItems;"""
    cursor.execute(sql)
    rows = cursor.fetchall()
    with open("output/4.out", "w") as file:
        header = "{:<40} {:<40} {:>10}\n".format("supReg", "custReg", "items")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:<40} {:<40} {:>10}\n".format(row[0], row[1], row[2])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def T5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T5")
    cursor = _conn.cursor()
    nationname = "tmp"
    with open("input/5.in", "r") as file:
        nation = file.readline().strip()
        nationname = nation
    # print(nationname)
    sql = """DELETE FROM lineitem
            WHERE l_orderkey IN(
            SELECT l_orderkey
            FROM lineitem, supplier, nation
            WHERE l_suppkey = s_suppkey
            AND s_nationkey = n_nationkey
            AND n_name = '{}'
            )""".format(
        nationname
    )
    cursor.execute(sql)
    _conn.commit()

    sql = """DROP TABLE IF EXISTS RegionItems;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """CREATE TABLE IF NOT EXISTS RegionItems(supReg, custReg, itemNo);"""
    cursor.execute(sql)
    _conn.commit()
    sql = """INSERT INTO RegionItems(supReg, custReg, itemNo)
                SELECT sup.r_name, cust.r_name, COUNT(l_linenumber)
                FROM supplier, nation as supnat, region as sup, nation as custnat, region as cust, orders, customer, lineitem
                WHERE c_nationkey = custnat.n_nationkey
                AND custnat.n_regionkey = cust.r_regionkey
                AND s_nationkey = supnat.n_nationkey
                AND supnat.n_regionkey = sup.r_regionkey
                AND c_custkey = o_custkey
                AND o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                GROUP BY sup.r_name, cust.r_name;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """SELECT * FROM RegionItems;"""
    cursor.execute(sql)
    rows = cursor.fetchall()
    with open("output/5.out", "w") as file:
        header = "{:<40} {:<40} {:>10}\n".format("supReg", "custReg", "items")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:<40} {:<40} {:>10}\n".format(row[0], row[1], row[2])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def T6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("T6")
    cursor = _conn.cursor()
    oldnatname = "tmp"
    newnatname = "tmp"
    with open("input/6.in", "r") as file:
        oldNation = file.readline().strip()
        newNation = file.readline().strip()
        oldnatname = oldNation
        newnatname = newNation

    sql = """SELECT n1.n_nationkey, n2.n_nationkey
            FROM nation as n1, nation as n2
            WHERE n1.n_name = '{}' 
            AND n2.n_name = '{}';""".format(
        oldnatname, newnatname
    )
    cursor.execute(sql)
    rows = cursor.fetchall()
    # print(rows[0][0])
    oldnatkey = -1
    newnatkey = -1
    oldnatkey = rows[0][0]
    newnatkey = rows[0][1]
    sql = """UPDATE customer set c_nationkey = {}
            WHERE c_nationkey = {};
            """.format(
        newnatkey, oldnatkey
    )
    cursor.execute(sql)
    _conn.commit()

    sql = """DROP TABLE IF EXISTS RegionItems;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """CREATE TABLE IF NOT EXISTS RegionItems(supReg, custReg, itemNo);"""
    cursor.execute(sql)
    _conn.commit()
    sql = """INSERT INTO RegionItems(supReg, custReg, itemNo)
                SELECT sup.r_name, cust.r_name, COUNT(l_linenumber)
                FROM supplier, nation as supnat, region as sup, nation as custnat, region as cust, orders, customer, lineitem
                WHERE c_nationkey = custnat.n_nationkey
                AND custnat.n_regionkey = cust.r_regionkey
                AND s_nationkey = supnat.n_nationkey
                AND supnat.n_regionkey = sup.r_regionkey
                AND c_custkey = o_custkey
                AND o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                GROUP BY sup.r_name, cust.r_name;"""
    cursor.execute(sql)
    _conn.commit()

    sql = """SELECT * FROM RegionItems;"""
    cursor.execute(sql)
    rows = cursor.fetchall()

    with open("output/6.out", "w") as file:
        header = "{:<40} {:<40} {:>10}\n".format("supReg", "custReg", "items")
        print(header)
        file.write(header)
        for row in rows:
            data = "{:<40} {:<40} {:>10}\n".format(row[0], row[1], row[2])
            print(data)
            file.write(data)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        T1(conn)
        T2(conn)
        T3(conn)
        T4(conn)
        T5(conn)
        T6(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()
