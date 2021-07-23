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

SELECT name, birth, CURDATE(),
       TIMESTAMPDIFF(YEAR,birth,CURDATE()) AS age
       FROM pet;
       
SELECT name, birth, MONTH(birth) FROM pet;


SELECT 1 IS NULL, 1 IS NOT NULL;


SELECT * FROM pet WHERE name LIKE 'b%';
	-- 	Which will match all the words starting with b

	SELECT * FROM pet WHERE name LIKE '%fy';
		-- which will match all the words ending with fy

	SELECT * FROM pet WHERE name LIKE '%w%';
	-- 	which will match all the words which has w in it

	SELECT * FROM pet WHERE name LIKE '_ _ _ _ _';
	-- 	which will match the exact number of time _ is given

	
	SELECT * FROM pet WHERE REGEXP_LIKE(name, '^b');
	-- which will match the words starting with b
	-- To make it case sensitive we can give
	SELECT * FROM pet WHERE REGEXP_LIKE(name, '^b' COLLATE utf8mb4_0900_as_cs);
	SELECT * FROM pet WHERE REGEXP_LIKE(name, BINARY '^b');
	SELECT * FROM pet WHERE REGEXP_LIKE(name, '^b', 'c');

	SELECT * FROM pet WHERE REGEXP_LIKE(name, 'fy$');
		-- which will match with the ending letter fy

	SELECT * FROM pet WHERE REGEXP_LIKE(name, 'w');
		-- which will match with words have contain w init

	SELECT * FROM pet WHERE REGEXP_LIKE(name, '^.....$');
	SELECT * FROM pet WHERE REGEXP_LIKE(name, '^.{5}$');
		-- which will match the the number of . and {n} n value char

SELECT COUNT(*) FROM pet;
-- Counting Rows

SELECT owner, COUNT(*) FROM pet GROUP BY owner;

SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;


-- CREATE INDEX

CREATE TABLE products (
			product_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
			product_name VARCHAR(100) NOT NULL,
			product_sku CHAR(10) NOT NULL,
			product_desc VARCHAR(500) NOT NULL,
			PRIMARY KEY (product_id),
			INDEX idx_name (product_name),
			INDEX idx_duo (product_name, product_sku)
		);

ALTER TABLE products
		ADD INDEX idx_sku (product_sku);

-- DROP INDEX idx_sku ON products

ALTER TABLE products
ADD UNIQUE idx_sku (product_sku);

CREATE FULLTEXT INDEX idx_text ON products (product_desc);

CREATE INDEX idx_sku_three ON products (product_sku(3));


-- CREATE TRIGGER

-- Bonus is we can drop the old trigger if we have any using
DROP TRIGGER IF EXISTS tr_ins_character;
DROP TRIGGER IF EXISTS tr_up_char;
 
CREATE TRIGGER tr_ins_character
	BEFORE INSERT ON characters
	FOR EACH ROW	-- This line is provided to perform action when bulk insert or ... is done
	SET NEW.character_name = UPPER(NEW.character_name);


	CREATE TRIGGER tr_up_char
	BEFORE UPDATE ON characters
	FOR EACH ROW
	SET NEW.character_name = LOWER(NEW.character_name);        
        
-- Creating a trigger is something like a middleware which gets triggered
-- 	when we do something else say as INSERT UPDATE DELETE  

-- CREATE VIEW

CREATE VIEW scifi AS 
SELECT m.movie_id, m.movie_title, g.genre_title
FROM movie AS m INNER JOIN genres AS g
WHERE genre_title = 'Sci-fi';

-- this view table is virtual table which is created for us each time using the above SQL

-- SUBQUERIES

SELECT *
	FROM movies
	WHERE year IN (1996, 1994, 1986);
-- Which we give us the results with year in these three

SELECT *
	FROM movies
	WHERE genre_id IN (SELECT genre_id FROM genres);
	-- this is some thing which is called as the subqueries 
	-- we can nest the subqueries using the IN inside the ( )
    
SELECT *
	FROM movies
	WHERE genre_id IN (SELECT genre_id FROM genres WHERE genre_title = 'Fantasy'); 
	-- this above SQL will take teh genre_id which as genre_tilte as fantasy

	SELECT * 
	FROM movies
	WHERE genre_id IN (SELECT genre_id FROM genres WHERE genre_title IN ('Fantasy', 'horror', 'Sci-Fi'));
	-- This is nested subquerie as we have IN inside an IN

-- LOCK AND UNLOCK TABLE STATEMENT
CREATE DATABASE locking

USE locking

CREATE TABLE products (p1 VARCHAR(5) NOT NULL PRIMARY KEY, v2 VARCHAR(5) NOT NULL)

CREATE user 'user_b'@'localhost'

GRANT ALL ON locking. to 'user_b'@'localhost'

-- READ --
LOCK TABLE products READ

-- WRITE --
LOCK TABLE products WRITE

-- UNLOCK --
UNLOCK TABLE

-- while in user_b we can 

USE locking

-- This cannot be done when write lock is kept on table product --
INSERT INTO products VALUES ('PEN','PENCIL')

-- This cannot be done when read lock is kept on table product --
SELECT * FROM products   




