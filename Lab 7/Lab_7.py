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
    try:
        #2 warehouses created for every supplier
        #nations where warehouses located are those which have largest # of lineitem supplied by suppliers that are ordered by customers from that nation
        #in case of equality, nations sorted in alphabetical order and first 2 are selected
        #name of warehouse is obtained by concatenating supplier name with "___" and name of nation where warehouse is located
        #in order to determine capacity of warehouse, have to compute total size of parts (p_size) supplied by suppliers to customers in nation
        #then warehouse capacity is taken by double the maximum total part size across all nations
        #two warehouses owned by supplier have same capacity 
        #finally, w_warehousekey value is a set of increasing numbers that are unique across the tuples in table
        
        # Warehouse ID StartV
        idSql = """SELECT s_name
                    FROM supplier
                    """
        cur = _conn.cursor()
        cur.execute(idSql)
        rows = cur.fetchall()
        
        #[warehousekey, name, capactity, suppkey, nationkey]
        #[keyvalue, name, ]
        #list of python dictionarys to storage 
        #list = array
        #dictionary 2d array
        #contains key and value
        #hash map
        #hashes the key to find value

        for row in rows:
            sql = """INSERT INTO warehouse(w_warehousekey,w_name, w_capacity, w_suppkey, w_nationkey)
                    VALUES({},'hi',0,{},0)""".format(i, id)
            i = i + 1
            sql2 = """INSERT INTO warehouse(w_warehousekey,w_name, w_capacity, w_suppkey, w_nationkey)
                    VALUES({},'hi',0,{},0)""".format(i, id)
                    #can replace ? with {} with format
                    #w3 python string format
                    #string format method 
                    #^ TA Help
                    #put placeholder into python data structure
            i = i + 1
            id = id + 1
            _conn.execute(sql)
            _conn.execute(sql2)
        
        # WareHouse ID Finish^
        # WareHouse Nation Start V
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
                print(row2[0])
                print(row2[1])
                print(row2[2])
                sql3 = """ INTO warehouse(w_name, w_nationkey)
                    VALUES('{}___{}', {})""".format(row[0], row2[0], row2[2])
                #INSERT INTO does not change existing data
                #need to use Update 
                _conn.execute(sql3)
        
        #WareHouse Nation End ^

        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

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

# A lot of this code I used from the Python Code given to us by the Professor from Lecture 22 ODBC Python