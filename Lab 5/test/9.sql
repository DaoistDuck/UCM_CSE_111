--SQLite

SELECT p_name 
FROM part, supplier, nation, partsupp
WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey
AND s_nationkey = n_nationkey AND n_name= 'UNITED STATES'
-- got this by myself

-- the bottom bit I copied/moved variable names around from the code the TA provided
ORDER BY (ps_supplycost * ps_availqty) DESC
LIMIT (select count(distinct ps_partkey)/100
    FROM part, partsupp, supplier, nation
    WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey
    AND s_nationkey = n_nationkey AND n_name= 'UNITED STATES');
