--SQLlite
.headers on
SELECT w_warehousekey AS wId, w_name AS wName, w_capacity AS wCap, w_suppkey AS sId, w_nationkey AS nId
FROM warehouse
GROUP BY w_warehousekey;