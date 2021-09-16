-- SQLite

select strftime('%Y-%m', l_receiptdate) , count(l_linenumber)
from lineitem, customer, orders
where l_orderkey = o_orderkey AND o_custkey = c_custkey AND strftime('%Y', l_receiptdate) = '1993' AND c_custkey = 000000010
group by strftime('%m', l_receiptdate);

-- used this website to get only the numbers I wanted showing for the date https://stackoverflow.com/questions/58824402/how-to-search-for-a-date-by-year-in-sqlite-database-using-python