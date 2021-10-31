def main():
    placeHolder = {'w_warehousekey', 'w_name',
                   'w_capacity', 'w_suppkey', 'w_nationkey'}

    placeHolder2 = {'w_warehousekey': 2, 'w_name': 'tmp2',
                    'w_capacity': 2, 'w_suppkey': 2, 'w_nationkey': 2}

    print(placeHolder)
    listPlaceholders = []
    listPlaceholders.append(placeHolder)
    listPlaceholders.append(placeHolder2)

    print(listPlaceholders[1]['w_warehousekey'])


if __name__ == '__main__':
    main()
