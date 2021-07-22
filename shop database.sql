USE shop;
CREATE TABLE sales (purchase_date DATE, customer_id INT);
ALTER TABLE sales
ADD COLUMN product_good BOOLEAN;
ALTER TABLE sales
RENAME COLUMN purchase_date TO purchased_date;
INSERT INTO sales (purchased_date, product_good) VALUES ('2021-07-22', 1);
INSERT INTO sales VALUES ('2021-07-23', 2, 0);

-- SET SQL_SAFE_UPDATES = 0; 
-- WE CAN USE PRIMARY KEY INSTEAD OF ABOVE STATEMENT 
-- THIS IS TO STOP THE SAFE MODE WHICH SQL PROTECTS  
SET SQL_SAFE_UPDATES = 0;
UPDATE sales SET customer_id = 1 WHERE product_good = 1;
SET SQL_SAFE_UPDATES=1;

-- EVEN FOR DELETE WE NEED THE SQL SAFE DELETE = 0
DELETE FROM sales;

-- AS THE DATA ARE LOST WE ARE INSERTING NEW DATA
INSERT INTO sales VALUES ('2021-07-23', 1, 0);
INSERT INTO sales VALUES ('2021-07-23', 2, 0);

-- SAME AS DELETE THIS WILL ALSO DELETE THE TABLE 
TRUNCATE TABLE sales;

-- AS THE DATA ARE LOST WE ARE INSERTING NEW DATA
INSERT INTO sales VALUES ('2021-07-23', 1, 0);
INSERT INTO sales VALUES ('2021-07-23', 2, 0);

-- TO DELETE ONE ITEM FROM THE DATABASE WE USE THIS COMMAND
DELETE FROM sales
WHERE customer_id = 1;

CREATE TABLE customers (first_name CHAR, last_name CHAR, customer_id INT);

DROP TABLE customers;

CREATE TABLE customers (first_name VARCHAR(45), last_name VARCHAR(45), customer_id INT);

INSERT INTO customers VALUE ('A', 'B', 3);

SET SQL_SAFE_UPDATES = 0;
UPDATE customers
SET last_name = 'Johnson'
WHERE customer_id = 4;
-- TILL THIS STEP YOU DATA WOULD HAVE NOT STORED IN THE DATABASE 
-- BUT HERE WE HAVE APPLIED THE CHANGES 

-- TO SAVE IT TO THE DATABASE WE USE THIS COMMIT STATEMENT
COMMIT;

-- TO SEE THE DATA IN THE DB WE CAN SIMPLY GIVE THE BELOW COMMAND
SELECT * FROM customers;

-- TO STORE THE DATA FROM THE DB TO TXT FILE WE USE
-- BUT THIS HAS ERROR WHICH TELLS US THE SECURE-FILE-PRIV
-- Move your file to the directory specified by secure-file-priv.
-- Disable secure-file-priv. This must be removed from startup and cannot be modified dynamically. 
-- To do this check your MySQL start up parameters (depending on platform) and my.ini.
SELECT 8 FROM sales
INTO OUTFILE '/tmp/orders.txt';

-- THIS IS TO STORE THE DATA FROM THE TXT FILE TO THE DATABASE
LOAD DATA LOCAL INFILE 'pet.txt' INTO TABLE pet;

-- TO SELECT THE DATA FROM A SPECIFIC ROW
SELECT * FROM customers WHERE first_name = 'a';
SELECT * FROM customers WHERE customer_id >= 1;
SELECT * FROM customers WHERE first_name = 'A' AND last_name = 'B';
SELECT * FROM customers WHERE first_name = 'A' OR last_name = 'B';
SELECT * FROM customers WHERE (first_name = 'A' AND last_name = 'B') OR (first_name = 'A' AND last_name = 'B');

-- Selecting Particular Columns
SELECT first_name FROM customers;
SELECT first_name, last_name FROM customers;
SELECT first_name, last_name, customer_id FROM customers
       WHERE first_name = 'A' OR last_name = 'A';
       
-- Sorting Rows
SELECT first_name, last_name FROM customers ORDER BY customer_id;
SELECT first_name, last_name FROM customers ORDER BY customer_id DESC;

-- Date Calculations








