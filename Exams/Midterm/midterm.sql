SELECT "1----------";
.headers on
--put your code here I looked at Lab 1 and modified the code

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
--put your code here The code I modified from was from 12-modification.sql

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
INSERT INTO Battles VALUES('Denmark Strait', '1914-05-24');
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
    FROM Ships
    WHERE Ships.launched <= 1920;

DELETE FROM Outcomes
WHERE ship IN (
    SELECT ship
    FROM Outcomes
    WHERE Outcomes.battle = 'Denmark Strait'
    GROUP BY Outcomes.ship
    HAVING COUNT(Outcomes.ship) > 1
);

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
--put your code here go back to see if i make code better

SELECT Classes.country as country , COUNT(result) as numCount
FROM Classes, Outcomes, Ships
WHERE Classes.class = Ships.class
AND Ships.name = Outcomes.ship
AND result = 'damaged'
GROUP BY Classes.country
ORDER BY numCount ASC
LIMIT 2;

;
.headers off

SELECT "7----------";
.headers on
--put your code here

DELETE FROM Outcomes
WHERE ship IN(
    SELECT ship
    FROM Outcomes, Classes, Ships
    WHERE Outcomes.ship = Ships.name
    AND Ships.class = Classes.class
    AND Outcomes.battle = 'Denmark Strait'
    GROUP BY Outcomes.ship
    HAVING Classes.country = 'Japan'
) AND battle IN(
    SELECT battle
    FROM Outcomes
    WHERE Outcomes.battle = 'Denmark Strait'
);

;
.headers off

SELECT "8----------";
.headers on
--put your code here

SELECT ship
FROM Outcomes
WHERE Outcomes.result = 'damaged'
GROUP BY Outcomes.ship
HAVING COUNT(Outcomes.result) > 1;

;
.headers off

SELECT "9----------";
.headers on
--put your code here

SELECT bcType.bccountry, bbType.bb, bcType.bc
FROM 
(
SELECT country as bbcountry, count(type) as bb
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Classes.type = 'bb'
GROUP BY country
) as bbType ,
(
SELECT country as bccountry, count(type) as bc
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Classes.type = 'bc'
GROUP BY country
) as bcType
WHERE bcType.bccountry = bbType.bbcountry
GROUP BY bcType.bccountry;

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
    AND Ships.launched > 1940
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
HAVING COUNT(Classes.class) == 2

;
.headers off

SELECT "12---------";
.headers on
--put your code here

SELECT Classes.class
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND Ships.name NOT IN (
    SELECT ship
    FROM Outcomes
    WHERE Outcomes.result = 'sunk'
)
GROUP BY Classes.class
HAVING COUNT(Classes.class) == 2

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

SELECT country, total(numGuns)
FROM Classes, Ships
WHERE Classes.class = Ships.class
GROUP BY country

;
.headers off

SELECT "15---------";
.headers on
--put your code here

SELECT Classes.country, total(numGuns) - newNumGuns.numCount
FROM Classes, Ships, (
SELECT country, COUNT(result) as numCount
FROM Classes, Ships, Outcomes
WHERE Classes.class = Ships.class
AND Ships.name = Outcomes.ship
AND Outcomes.result = 'damaged'
GROUP BY country
) as newNumGuns
WHERE Classes.class = Ships.class
AND Classes.country = newNumGuns.country
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


    SELECT country, COUNT(launched)
    FROM Ships, Classes
    WHERE Ships.class = Classes.class
    AND launched >= 1921
    AND launched <= 1930
    GROUP BY country
    


;
.headers off
