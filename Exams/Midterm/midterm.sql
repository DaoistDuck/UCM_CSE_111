SELECT "1----------";
.headers on
--put your code here 

--Create Table for Classes
CREATE TABLE Classes(
    class CHAR(25) PRIMARY KEY NOT NULL,
    type CHAR(25) NOT NULL,
    country CHAR(25) NOT NULL,
    numGuns DECIMAL(2,0) NOT NULL,
    bore DECIMAL(2,0) NOT NULL,
    displacement DECIMAL(5,0) NOT NULL
);

--Create Table for Ships
CREATE TABLE Ships(
    name CHAR(25) PRIMARY KEY NOT NULL,
    class CHAR(25) NOT NULL,
    launched DATE NOT NULL
);

--Create Table for Battles
CREATE TABLE Battles(
    name CHAR(25) PRIMARY KEY NOT NULL,
    date DATE NOT NULL
);

--Create Table for Outcomes
CREATE TABLE Outcomes(
    ship CHAR(25)  NOT NULL,
    battle CHAR(25) NOT NULL,
    result CHAR(25) NOT NULL
);

;
.headers off

SELECT "2----------";
.headers on
--put your code here 

--Inserts for Classes
INSERT INTO Classes VALUES('Bismarck', 'bb' , 'Germany', 8, 15, 42000);
INSERT INTO Classes VALUES('Iowa', 'bb' , 'USA', 9, 16, 46000);
INSERT INTO Classes VALUES('Kongo', 'bc' , 'Japan', 8, 14, 32000);
INSERT INTO Classes VALUES('North Carolina', 'bb' , 'USA', 9, 16, 37000);
INSERT INTO Classes VALUES('Renown', 'bc' , 'Britain', 6, 15, 32000);
INSERT INTO Classes VALUES('Revenge', 'bb' , 'Britain', 8, 15, 29000);
INSERT INTO Classes VALUES('Tennessee', 'bb' , 'USA', 12, 14, 32000);
INSERT INTO Classes VALUES('Yamato', 'bb' , 'Japan', 9, 18, 65000);

--Inserts for Ships
INSERT INTO Ships VALUES('California','Tennessee', 1915);
INSERT INTO Ships VALUES('Haruna','Kongo', 1915);
INSERT INTO Ships VALUES('Hiei','Kongo', 1915);
INSERT INTO Ships VALUES('Iowa','Iowa', 1933);
INSERT INTO Ships VALUES('Kirishima','Kongo', 1915);
INSERT INTO Ships VALUES('Kongo','Kongo', 1913);
INSERT INTO Ships VALUES('Missouri','Iowa', 1935);
INSERT INTO Ships VALUES('Musashi','Yamato', 1942);
INSERT INTO Ships VALUES('New Jersey','Iowa', 1936);
INSERT INTO Ships VALUES('North Carolina','North Carolina', 1941);
INSERT INTO Ships VALUES('Ramillies','Revenge', 1917);
INSERT INTO Ships VALUES('Renown','Renown', 1916);
INSERT INTO Ships VALUES('Repulse','Renown', 1916);
INSERT INTO Ships VALUES('Resolution','Revenge', 1916);
INSERT INTO Ships VALUES('Revenge','Revenge', 1916);
INSERT INTO Ships VALUES('Royal Oak','Revenge', 1916);
INSERT INTO Ships VALUES('Royal Sovereign','Revenge', 1916);
INSERT INTO Ships VALUES('Tennessee','Tennessee', 1915);
INSERT INTO Ships VALUES('Washington','North Carolina', 1941);
INSERT INTO Ships VALUES('Wisconsin','Iowa', 1940);
INSERT INTO Ships VALUES('Yamato','Yamato', 1941);

--Inserts for Battles
INSERT INTO Battles VALUES('Denmark Strait', '1941-05-24');
INSERT INTO Battles VALUES('Guadalcanal', '1942-11-15');
INSERT INTO Battles VALUES('North Cape', '1943-12-26');
INSERT INTO Battles VALUES('Surigao Strait', '1944-10-25');

--Inserts for Outcomes
INSERT INTO Outcomes VALUES('California','Surigao Strait','ok');
INSERT INTO Outcomes VALUES('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO Outcomes VALUES('Resolution', 'Denmark Strait', 'ok');
INSERT INTO Outcomes VALUES('Wisconsin', 'Guadalcanal', 'damaged');
INSERT INTO Outcomes VALUES('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES('Washington', 'Guadalcanal', 'ok');
INSERT INTO Outcomes VALUES('New Jersey', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES('Yamato', 'Surigao Strait', 'sunk');
INSERT INTO Outcomes VALUES('Wisconsin', 'Surigao Strait', 'damaged');

;--takes a bit of time
.headers off

SELECT "3----------";
.headers on
--put your code here

SELECT Classes.country, COUNT(Ships.launched) as NumShips
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Ships.launched >= 1930
AND Ships.launched <= 1940
GROUP BY Classes.country;

;
.headers off

SELECT "4----------";
.headers on
--put your code here

INSERT INTO Outcomes(ship, battle, result)
    SELECT Ships.name, 'Denmark Strait', 'damaged'
    FROM Ships, Outcomes
    WHERE Ships.name NOT IN(SELECT Outcomes.ship FROM Outcomes WHERE Outcomes.battle = 'Denmark Strait')
    AND Ships.launched <= 1920
    GROUP BY Ships.name

;
.headers off

SELECT "5----------";
.headers on
--put your code here

SELECT Classes.country, COUNT(Outcomes.result) as DamagedShips
FROM Classes, Outcomes, Ships
WHERE Classes.class = Ships.class
AND Ships.name = Outcomes.ship
AND result = 'damaged'
GROUP BY Classes.country;

;
.headers off

SELECT "6----------";
.headers on
--put your code here

SELECT Classes.country AS country
FROM Classes, Outcomes, Ships
WHERE Classes.class = Ships.class
AND Ships.name = Outcomes.ship
AND Outcomes.result = 'damaged'
GROUP BY Classes.country
ORDER BY COUNT(Outcomes.result) ASC
LIMIT 2

;
.headers off

SELECT "7----------";
.headers on
--put your code here

DELETE FROM Outcomes
WHERE Outcomes.ship IN(
    SELECT Outcomes.ship
    FROM Outcomes, Classes, Ships
    WHERE Outcomes.ship = Ships.name
    AND Ships.class = Classes.class
    AND Outcomes.battle = 'Denmark Strait'
    GROUP BY Outcomes.ship
    HAVING Classes.country = 'Japan'
) AND Outcomes.battle IN(
    SELECT Outcomes.battle
    FROM Outcomes
    WHERE Outcomes.battle = 'Denmark Strait'
);

;
.headers off

SELECT "8----------";
.headers on
--put your code here

SELECT Outcomes.ship
FROM Outcomes
WHERE Outcomes.result = 'damaged' OR Outcomes.result = 'ok'
GROUP BY Outcomes.ship
HAVING COUNT(Outcomes.result) > 1;

;
.headers off

SELECT "9----------";
.headers on
--put your code here
WITH bbType AS(
SELECT country AS bbcountry, count(type) AS bb
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Classes.type = 'bb'
GROUP BY country
), bcType AS(
SELECT country AS bccountry, count(type) AS bc
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Classes.type = 'bc'
GROUP BY country
)
SELECT bbType.bbcountry as country, bbType.bb AS numBB, bcType.bc AS numBC
FROM bbType, bcType
WHERE bbType.bbcountry = bcType.bccountry
GROUP BY bbType.bbcountry;

;
.headers off

SELECT "10---------";
.headers on
--put your code here

UPDATE Classes SET numGuns = numGuns * 2
WHERE Classes.class IN(
    SELECT Classes.class
    FROM Classes, Ships
    WHERE Classes.class = Ships.class
    AND Ships.launched >= 1940
);

;
.headers off

SELECT "11---------";
.headers on
--put your code here

SELECT Classes.class
FROM Classes, Ships
WHERE Classes.class = Ships.class
GROUP BY Classes.class
HAVING COUNT(Ships.name) == 2

;
.headers off

SELECT "12---------";
.headers on
--put your code here

SELECT Classes.class
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Ships.name NOT IN (
    SELECT Outcomes.ship
    FROM Outcomes
    WHERE Outcomes.result = 'sunk'
)
GROUP BY Classes.class
HAVING COUNT(Ships.name) == 2

;
.headers off

SELECT "13---------";
.headers on
--put your code here

DELETE FROM Ships
WHERE name IN(
    SELECT ship
    FROM Outcomes
    WHERE Outcomes.result = 'sunk'
);

;
.headers off

SELECT "14---------";
.headers on
--put your code here

SELECT Classes.country, TOTAL(Classes.numGuns) AS totalNumGuns
FROM Classes, Ships
WHERE Classes.class = Ships.class
GROUP BY Classes.country

;
.headers off

SELECT "15---------";
.headers on
--put your code here

SELECT Classes.country, TOTAL(Classes.numGuns) - damagedNumGuns.numCount AS newTotalNumGuns
FROM Classes, Ships,(
SELECT Classes.country AS country, COUNT(result) AS numCount
FROM Classes
LEFT JOIN Ships ON Classes.class = Ships.class
LEFT JOIN Outcomes ON Outcomes.ship = Ships.name AND Outcomes.result = 'damaged'
GROUP BY Classes.country
) AS damagedNumGuns
WHERE Classes.class = Ships.class
AND Classes.country = damagedNumGuns.country
GROUP BY Classes.country

;
.headers off

SELECT "16---------";
.headers on
--put your code here

INSERT INTO Ships(name, class, launched)
    SELECT Classes.class, Classes.class, Ships.launched
    FROM Ships, Classes
    WHERE Classes.class NOT IN(SELECT Ships.class FROM Ships)
    AND Ships.launched = (SELECT min(Ships.launched) FROM Ships, Classes WHERE Ships.class = Classes.class)
    GROUP BY Classes.class

;
.headers off

SELECT "17---------";
.headers on
--put your code here

    WITH launched19111920 AS(
    SELECT Classes.country AS tmpcountry, COUNT(Ships.launched) AS count
    FROM Classes
    LEFT JOIN Ships ON Classes.class = Ships.class
    AND Ships.launched >= 1911
    AND Ships.launched <= 1920
    GROUP BY Classes.country
    ), launched19211930 AS(
    SELECT Classes.country AS tmpcountry, COUNT(Ships.launched) AS count
    FROM Classes
    LEFT JOIN Ships ON Classes.class = Ships.class
    AND Ships.launched >= 1921
    AND Ships.launched <= 1930
    GROUP BY Classes.country
    ), launched19311940 AS(
    SELECT Classes.country AS tmpcountry, COUNT(Ships.launched) AS count
    FROM Classes
    LEFT JOIN Ships ON Classes.class = Ships.class
    AND Ships.launched >= 1931
    AND Ships.launched <= 1940
    GROUP BY Classes.country
    ), launched19411950 AS(
    SELECT Classes.country AS tmpcountry, COUNT(Ships.launched) AS count
    FROM Classes
    LEFT JOIN Ships ON Classes.class = Ships.class
    AND Ships.launched >= 1941
    AND Ships.launched <= 1950
    GROUP BY Classes.country
    ) 
    SELECT launched19111920.tmpcountry AS country, launched19111920.count AS '1911-1920', launched19211930.count AS '1921-1930', launched19311940.count AS '1931-1940', launched19411950.count AS '1941-1950'
    FROM launched19111920, launched19211930, launched19311940, launched19411950
    WHERE launched19111920.tmpcountry = launched19211930.tmpcountry
    AND launched19211930.tmpcountry = launched19311940.tmpcountry
    AND launched19311940.tmpcountry = launched19411950.tmpcountry

;
.headers off
