PRAGMA foreign_keys = on;

SELECT "1----------";
.headers on
--put your code here

DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Ships;
DROP TABLE IF EXISTS Battles;
DROP TABLE IF EXISTS Outcomes;

-- The base of my code is taken from my CSE 111 Midterm SQLite file
--Create Table for Classes
CREATE TABLE IF NOT EXISTS Classes(
    class CHAR(25) PRIMARY KEY,
    type CHAR(25),
    country CHAR(25) NOT NULL,
    numGuns DECIMAL(2,0),
    bore DECIMAL(2,0),
    displacement DECIMAL(5,0)
    CHECK (type IN('bb', 'bc'))
);
-- List of constraints for classes
--There are no two tuples in Classes with the same class value
----Since class is a primary key, it is unique and there can't be two classes with the same value
--The possible values for type in Classes are {bb,bc}.
----Added a check type to see what type is being inserted and making sure only bb and bc are allowed
--The value of country in Classes cannot be NULL
----Just added the NOT NULL command in the country line

--Create Table for Ships
CREATE TABLE IF NOT EXISTS Ships(
    name CHAR(25) PRIMARY KEY,
    class CHAR(25) REFERENCES Classes(class) ON DELETE SET NULL ON UPDATE SET NULL,
    launched DATE 
);
-- List of constraints for Ships
--There are no two Ships with the same name
----Since name is a primary key, it is unique and there can't be two names with the same value
-- There is a referential integrity constraint from Ships.class to Classes.class that is handled by SET NULL operations
---- I believe I do the reference then do the ON DELETE operation name on UPDATE operation name in our case, operation name is SET NULL

--Create Table for Battles
CREATE TABLE IF NOT EXISTS Battles(
    name CHAR(25) PRIMARY KEY,
    date DATE 
);
-- List of constraints for Battles
---- None that is explicit to Battles was listed on the pdf

--Create Table for Outcomes
CREATE TABLE IF NOT EXISTS Outcomes(
    ship CHAR(25),
    battle CHAR(25),
    result CHAR(25),
    FOREIGN KEY (ship) REFERENCES Ships(name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (battle) REFERENCES Battles(name) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (result IN('ok', 'sunk', 'damaged'))
);
-- List of constraints for Outcomes
-- There is a referential integrity constraint from Outcomes.ship to Ships.name that is handled by CASCADE operations.
---- I believe I do the reference then do the ON DELETE operation name on UPDATE operation name in our case, operation name is CASCADE
-- There is a referential integrity constraint from Outcomes.battle to Battles.name that is handled by CASCADE operations.
---- I believe I do the reference then do the ON DELETE operation name on UPDATE operation name in our case, operation name is CASCADE
--The possible values for result in Outcomes are {ok, sunk, damaged}
---- I added a check to make sure that what is being inserted is ok, sunk, or damaged
;
.headers off

SELECT "2----------";
.headers on
--put your code here

-- Took my inserts from my CSE 111 Midterm
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

select * from Classes;
select * from Ships;
select * from Battles;
select * from Outcomes;
.headers off

SELECT "3----------";
.headers on
--put your code here

DELETE FROM Classes
WHERE Classes.class IN(
    SELECT Classes.class
    FROM  Classes
    WHERE Classes.displacement < 30000
    OR Classes.numGuns < 8
);

;

select * from Classes;
select * from Ships;
.headers off

SELECT "4----------";
.headers on
--put your code here
DELETE FROM Battles
WHERE Battles.name IN(
    SELECT Battles.name 
    FROM Battles
    WHERE Battles.name = 'Guadalcanal'
);

;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "5----------";
.headers on
--put your code here
UPDATE Battles SET name = 'Strait of Surigao'
WHERE Battles.name IN(
    SELECT Battles.name 
    FROM Battles
    WHERE Battles.name = 'Surigao Strait'
);
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "6----------";
.headers on
--put your code here
DELETE FROM Ships
WHERE Ships.name IN(
    SELECT Ships.name
    FROM Ships
    WHERE Ships.class IS NULL
);
;

select * from Ships;
select * from Outcomes;
.headers off
