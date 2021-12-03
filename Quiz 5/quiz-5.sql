PRAGMA foreign_keys = on;

SELECT "1----------";
.headers on
--put your code here

-- The base of my code is taken from my CSE 111 Midterm SQLite file
--Create Table for Classes
CREATE TABLE Classes(
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
----Added a check type to see
--The value of country in Classes cannot be NULL
----Just added the NOT NULL command in the country line

--Create Table for Ships
CREATE TABLE Ships(
    name CHAR(25) PRIMARY KEY,
    class CHAR(25),
    launched DATE 
);

--Create Table for Battles
CREATE TABLE Battles(
    name CHAR(25) PRIMARY KEY,
    date DATE 
);

--Create Table for Outcomes
CREATE TABLE Outcomes(
    FOREIGN KEY (ship) CHAR(25) REFERENCES Ships(name),
    FOREIGN KEY (battle) CHAR(25) REFERENCES Battles(name),
    result CHAR(25)
);

;
.headers off

SELECT "2----------";
.headers on
--put your code here
;

select * from Classes;
select * from Ships;
select * from Battles;
select * from Outcomes;
.headers off

SELECT "3----------";
.headers on
--put your code here
;

select * from Classes;
select * from Ships;
.headers off

SELECT "4----------";
.headers on
--put your code here
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "5----------";
.headers on
--put your code here
;

select * from Battles;
select * from Outcomes;
.headers off

SELECT "6----------";
.headers on
--put your code here
;

select * from Ships;
select * from Outcomes;
.headers off
