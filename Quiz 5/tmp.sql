SELECT class
FROM Classes
WHERE displacement < 30000
OR numGuns < 8;

-- SELECT class
-- FROM Classes
-- WHERE numGuns < 8

SELECT name
FROM Ships
WHERE class IS NULL;



