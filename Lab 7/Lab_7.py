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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    try:
        sql = """CREATE TABLE warehouse(
                    w_warehousekey DECIMAL(9,0) NOT NULL,
                    w_name CHAR(100) NOT NULL,
                    w_capacity DECIMAL(6,0) NOT NULL,
                    w_suppkey DECIMAL(9,0) NOT NULL,
                    w_nationkey DECIMAL(2,0) NOT NULL)"""
        _conn.execute(sql)

        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    try:
        sql = "DROP TABLE warehouse"
        _conn.execute(sql)

        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    i = 1
    id = 1
    tmpPopTableHolder = {'w_warehousekey': 1, 'w_name': 'tmp1',
                         'w_capacity': 1, 'w_suppkey': 1, 'w_nationkey': 1}
    listTmpPopTableHolder = []
    listTmpCapacity = []
    tmp200List = []
    try:

        # Warehouse ID StartV
        idSql = """SELECT s_name
                    FROM supplier
                    """
        cur = _conn.cursor()
        cur.execute(idSql)
        rows = cur.fetchall()

        for row in rows:
            tmpPopTableHolder.update({"w_warehousekey": i, 'w_suppkey': id})
            tmpPopTableHolder_copy = tmpPopTableHolder.copy()
            # print(tmpPopTableHolder)
            listTmpPopTableHolder.append(tmpPopTableHolder_copy)
            i = i + 1
            tmpPopTableHolder.update({"w_warehousekey": i, 'w_suppkey': id})
            tmpPopTableHolder_copy = tmpPopTableHolder.copy()
            listTmpPopTableHolder.append(tmpPopTableHolder_copy)

            i = i + 1
            id = id + 1
        # WareHouse ID Finish^
        # WareHouse Nation Start V
        id = 0
        for row in rows:
            nameSql = """SELECT n_name, count(l_linenumber) as totalNum, n_nationkey
                        FROM supplier, lineitem, customer, orders, nation
                        WHERE c_nationkey = n_nationkey
                        AND c_custkey = o_custkey
                        AND o_orderkey = l_orderkey
                        AND s_suppkey = l_suppkey
                        AND s_name = '{}'
                        GROUP BY n_name
                        ORDER BY totalNum DESC, n_name ASC
                        LIMIT 2
                        """.format(row[0])
            cur2 = _conn.cursor()
            cur2.execute(nameSql)
            rows2 = cur2.fetchall()
            for row2 in rows2:
                listTmpPopTableHolder[id].update(
                    {'w_name': row[0] + '___' + row2[0], 'w_nationkey': row2[2]})
                tmp200List.append(id)
                id = id + 1
        # WareHouse Nation End ^
        # WareHouse Capacity Begins V
        for row in rows:
            capacitySql = """WITH nTotal AS(
                            SELECT n_name,  s_name, SUM(p_size) as totalSize
                            FROM part, supplier, customer, nation, lineitem, orders
                            WHERE c_nationkey = n_nationkey
                            AND c_custkey = o_custkey
                            AND o_orderkey = l_orderkey
                            AND s_suppkey = l_suppkey
                            AND p_partkey = l_partkey
                            AND s_name = '{}'
                            GROUP BY n_name, s_name
                            )
                            SELECT max(nTotal.totalSize) * 2 AS DoubleMaxTotalPartSize
                            FROM nTotal;
                        """.format(row[0])
            cur3 = _conn.cursor()
            cur3.execute(capacitySql)
            rows3 = cur3.fetchall()
            for row3 in rows3:
                listTmpCapacity.append(row3[0])

        id = 0
        for x in listTmpCapacity:
            listTmpPopTableHolder[id].update({'w_capacity': x})
            listTmpPopTableHolder[id+1].update({'w_capacity': x})
            id = id + 2
        # WareHouse Capacity Ends ^
        # Inserting Data Into warehouse Table Begins V

        for x in tmp200List:
            sql = "INSERT INTO warehouse VALUES(?,?,?,?,?)"
            args = [listTmpPopTableHolder[x]['w_warehousekey'], listTmpPopTableHolder[x]['w_name'],
                    listTmpPopTableHolder[x]['w_capacity'], listTmpPopTableHolder[x]['w_suppkey'], listTmpPopTableHolder[x]['w_nationkey']]
            _conn.execute(sql, args)

        # Inserting Data Into warehouse Table Ends ^

        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    Q1Output = open("output/1.out", "w")
    Q1Write = open("output/1.out", "w")

    try:
        sql = """SELECT w_warehousekey AS wId, w_name AS wName, w_capacity AS wCap, w_suppkey AS sId, w_nationkey AS nId
                FROM warehouse
                GROUP BY w_warehousekey;"""
        cursor = _conn.cursor()
        cursor.execute(sql)
        header = '{:>10} {:<40} {:<17} {:<10} {:<10}'.format(
            "wId", "wName", "wCap", "sId", "nId")
        print(header)
        Q1Write.write(header + '\n')
        rows = cursor.fetchall()
        for row in rows:
            data = '{:>10} {:<40} {:<10} {:>10} {:>10}'.format(
                row[0], row[1], row[2], row[3], row[4])
            print(data)
            Q1Write.write(data + '\n')

    except Error as e:
        _conn.rollback()
        print(e)

    Q1Write.close()
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    Q2Output = open("output/2.out", "w")
    Q2Write = open("output/2.out", "w")

    try:
        sql = """SELECT n_name, COUNT(w_warehousekey), SUM(w_capacity)
                    FROM nation, warehouse
                    WHERE w_nationkey = n_nationkey
                    GROUP BY n_name
                    ORDER BY COUNT(w_warehousekey) DESC, n_name ASC"""
        cursor = _conn.cursor()
        cursor.execute(sql)
        header = '{:<20} {:>10} {:>10}'.format(
            "nation", "numW", "totCap")
        print(header)
        Q2Write.write(header + '\n')
        rows = cursor.fetchall()
        for row in rows:
            data = '{:<20} {:>10} {:>10}'.format(
                row[0], row[1], row[2])
            print(data)
            Q2Write.write(data + '\n')

    except Error as e:
        _conn.rollback()
        print(e)

    Q2Write.close()

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    Q3Output = open("output/3.out", "w")
    Q3Write = open("output/3.out", "w")

    input = open("input/3.in", "r")
    dataList = input.read().splitlines()

    try:
        sql = """SELECT s_name, n2.n_name, w_name
                    FROM supplier, nation as n1, warehouse, nation as n2
                    WHERE w_nationkey = n1.n_nationkey
                    AND n1.n_name = '{}'
                    AND s_suppkey = w_suppkey
                    AND s_nationkey = n2.n_nationkey
                    GROUP BY s_name
                    ORDER BY s_name ASC""".format(dataList[0])
        cursor = _conn.cursor()
        cursor.execute(sql)
        header = '{:<20} {:<20} {:<10}'.format(
            'supplier', 'nation', 'warehouse')
        print(header)
        Q3Write.write(header + '\n')
        rows = cursor.fetchall()
        for row in rows:
            data = '{:<20} {:<20} {:<10}'.format(
                row[0], row[1], row[2])
            print(data)
            Q3Write.write(data + '\n')
    except Error as e:
        _conn.rollback()
        print(e)

    Q3Write.close()

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    Q4Output = open("output/4.out", "w")
    Q4Write = open("output/4.out", "w")

    input = open("input/4.in", "r")
    dataList = input.read().splitlines()

    try:
        sql = """SELECT w_name, w_capacity
                    FROM warehouse, nation, region
                    WHERE w_nationkey = n_nationkey
                    AND n_regionkey = r_regionkey
                    AND r_name = '{}'
                    AND w_capacity > {}
                    GROUP BY w_name
                    ORDER BY w_capacity DESC""".format(dataList[0], dataList[1])
        cursor = _conn.cursor()
        cursor.execute(sql)
        header = '{:<10} {:>30}'.format(
            'warehouse', 'capacity',)
        print(header)
        Q4Write.write(header + '\n')
        rows = cursor.fetchall()
        for row in rows:
            data = '{:<36} {:<20}'.format(
                row[0], row[1])
            print(data)
            Q4Write.write(data + '\n')
    except Error as e:
        _conn.rollback()
        print(e)

    Q4Write.close()

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    Q5Output = open("output/5.out", "w")
    Q5Write = open("output/5.out", "w")

    input = open("input/5.in", "r")
    dataList = input.read().splitlines()

    try:
        sql = """WITH regionTotalCapacity AS(
                    SELECT r_name as name, SUM(w_capacity) as sumCap
                    FROM supplier, nation as n1, warehouse, nation as n2, region
                    WHERE w_nationkey = n1.n_nationkey
                    AND n2.n_name = '{}'
                    AND s_suppkey = w_suppkey
                    AND s_nationkey = n2.n_nationkey
                    AND n1.n_regionkey = r_regionkey
                    GROUP BY r_name
                    )
                    SELECT r_name, CASE WHEN regionTotalCapacity.sumCap > 0 THEN regionTotalCapacity.sumCap ELSE 0 END
                    FROM region
                    LEFT JOIN regionTotalCapacity ON r_name = regionTotalCapacity.name
                    GROUP BY r_name
                    ORDER BY r_name ASC""".format(dataList[0])
        cursor = _conn.cursor()
        cursor.execute(sql)
        header = '{:<15} {:>10}'.format(
            'region', 'capacity',)
        print(header)
        Q5Write.write(header + '\n')
        rows = cursor.fetchall()
        for row in rows:
            data = '{:<15} {:>10}'.format(
                row[0], row[1])
            print(data)
            Q5Write.write(data + '\n')
    except Error as e:
        _conn.rollback()
        print(e)

    Q5Write.close()

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()

# A lot of this code I used from the Python Code named SQLite.py given to us by the Professor from Lecture 22 ODBC Python
# [warehousekey, name, capactity, suppkey, nationkey]
# [keyvalue, name, ]
# list of python dictionarys to storage
# list = array
# dictionary 2d array
# contains key and value
# hash map
# hashes the key to find value
# can replace ? with {} with format
# w3 python string format
# string format method
# ^ TA Help
# put placeholder into python data structure
# https://www.w3schools.com/python/ref_string_format.asp
# https://www.kite.com/python/answers/how-to-update-a-dictionary-in-python
# https://www.kite.com/python/answers/how-to-append-a-dictionary-to-a-list-in-python
# https://www.pluralsight.com/guides/manipulating-lists-dictionaries-python
# https://www.geeksforgeeks.org/how-to-read-from-a-file-in-python/
# https://stackoverflow.com/questions/12330522/how-to-read-a-file-without-newlines
# https://www.w3schools.com/python/python_file_write.asp
