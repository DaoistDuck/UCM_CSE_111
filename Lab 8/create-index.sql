--drop doesnt need the ON argue
--use expert and make idx statement

CREATE INDEX IF NOT EXISTS customer_idx_c_name ON customer(c_name);
