--SQLite
-- DROP VIEW PriceRange;
-- CREATE VIEW PriceRange(maker, type, minPrice, maxPrice) AS
--     SELECT Product.maker, Product.type, MIN(PC.price), MAX(PC.price)
--     FROM Product, PC
--     WHERE Product.model = PC.model
--     GROUP BY Product.maker
--     UNION
--     SELECT Product.maker, Product.type, MIN(Laptop.price), MAX(Laptop.price)
--     FROM Product, Laptop
--     WHERE Product.model = Laptop.model
--     GROUP BY Product.maker
--     UNION
--     SELECT Product.maker, Product.type, MIN(Printer.price), MAX(Printer.price)
--     FROM Product, Printer
--     WHERE Product.model = Printer.model
--     GROUP BY Product.maker;

-- SELECT Product.maker, Product.type, MIN(PC.price), MAX(PC.price)
-- FROM Product, PC
-- WHERE Product.model = PC.model
-- GROUP BY Product.maker
-- UNION
-- SELECT Product.maker, Product.type, MIN(Laptop.price), MAX(Laptop.price)
-- FROM Product, Laptop
-- WHERE Product.model = Laptop.model
-- GROUP BY Product.maker
-- UNION
-- SELECT Product.maker, Product.type, MIN(Printer.price), MAX(Printer.price)
-- FROM Product, Printer
-- WHERE Product.model = Printer.model
-- GROUP BY Product.maker;

SELECT Product.maker, Product.type, MIN(price), MAX(price)
FROM Product
LEFT JOIN PC on Product.model = PC.model
LEFT JOIN Laptop on Product.model = Laptop.model
GROUP BY Product.maker;

-- SELECT *
-- FROM PriceRange
-- ORDER BY maker ASC, type ASC;

-- UPDATE Printer SET price = 100 
-- WHERE Printer.model = 3001