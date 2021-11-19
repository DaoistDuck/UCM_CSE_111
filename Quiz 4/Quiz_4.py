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


def createPriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create PriceRange")

    try:
        sql = """DROP VIEW IF EXISTS PriceRange;"""
        _conn.execute(sql)

        sql = """CREATE VIEW IF NOT EXISTS PriceRange(maker, type, minPrice, maxPrice) AS
                    SELECT Product.maker, Product.type, MIN(PC.price), MAX(PC.price)
                    FROM Product, PC
                    WHERE Product.model = PC.model
                    GROUP BY Product.maker
                    UNION
                    SELECT Product.maker, Product.type, MIN(Laptop.price), MAX(Laptop.price)
                    FROM Product, Laptop
                    WHERE Product.model = Laptop.model
                    GROUP BY Product.maker
                    UNION
                    SELECT Product.maker, Product.type, MIN(Printer.price), MAX(Printer.price)
                    FROM Product, Printer
                    WHERE Product.model = Printer.model
                    GROUP BY Product.maker;
                """
        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def printPriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Print PriceRange")
    try:
        sql = """SELECT PriceRange.maker, PriceRange.type, PriceRange.minPrice, PriceRange.maxPrice
                FROM PriceRange
                ORDER BY maker ASC, type ASC;"""

        cursor = _conn.cursor()
        cursor.execute(sql)

        l = '{:<10} {:<20} {:>20} {:>20}'.format(
            "maker", "product", "minPrice", "maxPrice")
        print(l)

        rows = cursor.fetchall()

        for row in rows:
            m = '{:<10} {:<20} {:>20} {:>20}'.format(
                row[0], row[1], row[2], row[3])
            print(m)

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def insertPC(_conn, _maker, _model, _speed, _ram, _hd, _price):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Insert PC ({}, {}, {}, {}, {}, {})'.format(
        _maker, _model, _speed, _ram, _hd, _price)
    print(l)
    try:
        sql = """DELETE FROM PC 
                WHERE PC.model = {};""".format(_model)
        _conn.execute(sql)

        sql = """INSERT INTO PC VALUES(?,?,?,?,?);"""
        args = [_model, _speed, _ram, _hd, _price]
        _conn.execute(sql, args)

        sql = """DELETE FROM Product
                WHERE Product.model = {};""".format(_model)
        _conn.execute(sql)

        sql = """INSERT INTO PRODUCT VALUES(?,?,?);"""
        args = [_maker, _model, 'pc']
        _conn.execute(sql, args)

        _conn.commit()
        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def updatePrinter(_conn, _model, _price):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Update Printer ({}, {})'.format(_model, _price)
    print(l)

    try:
        sql = """UPDATE Printer SET price = {} 
                WHERE Printer.model = {};""".format(_price, _model)
        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def deleteLaptop(_conn, _model):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Delete Laptop ({})'.format(_model)
    print(l)
    try:
        sql = """DELETE FROM Laptop WHERE Laptop.model = {};""".format(_model)
        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"data.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        createPriceRange(conn)
        printPriceRange(conn)

        file = open('input.in', 'r')
        lines = file.readlines()
        for line in lines:
            print(line.strip())

            tok = line.strip().split(' ')
            if tok[0] == 'I':
                insertPC(conn, tok[2], tok[3], tok[4], tok[5], tok[6], tok[7])
            elif tok[0] == 'U':
                updatePrinter(conn, tok[2], tok[3])
            elif tok[0] == 'D':
                deleteLaptop(conn, tok[2])

            printPriceRange(conn)

        file.close()

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
