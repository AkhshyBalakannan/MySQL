CREATE DATABASE document_example;
-- To create an database

USE document_example;
-- to use the database

CREATE TABLE pet(name VARCHAR(20), owner VARCHAR(20),
       species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);
-- to create an pets table with following columns

DESCRIBE pet;
-- To verify that your table was created the way you expected, use a DESCRIBE statement:


-- to insert the data from text file we use
SET GLOBAL local_infile=1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'pet.txt' INTO TABLE pet;

INSERT INTO pet
       VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);

INSERT INTO pet
       VALUES ('Fang','Benny','dog','m','1990-08-27',NULL);
	
INSERT INTO pet
       VALUES ('Buffy','Harold','dog','f','1989-05-13',NULL);

INSERT INTO pet
       VALUES ('Claws','Gwen','cat','m','1994-03-17',NULL);

INSERT INTO pet
       VALUES('Fluffy','Harold','cat','f','1993-02-04',NULL);
       
INSERT INTO pet
		VALUES('Bowser','Diane','dog','m','1979-08-31','1995-07-29');
        
INSERT INTO pet VALUES('Slim','Benny','snake','m','1996-04-29',NULL);

-- SELECT what_to_select
-- FROM which_table
-- WHERE conditions_to_satisfy;

SELECT * FROM pet;
-- prints all the data from table will not include the invisible table

-- to create column invisble from the * we give
-- CREATE TABLE t1 (i INT, j DATE INVISIBLE);
-- ALTER TABLE t1 ADD COLUMN k INT INVISIBLE;

DELETE FROM pet;
-- deletes all the data in pet table

-- turn off safe mode to update data
SET SQL_SAFE_UPDATES = 0;
UPDATE pet SET birth = '1989-08-31' WHERE name = 'Bowser';
-- Updates data from the table using where keyword
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM pet WHERE name = 'Bowser';
-- To select a particular row

SELECT * FROM pet WHERE birth >= '1998-1-1';
-- arth oper output can be obtained
SELECT * FROM pet WHERE species = 'dog' AND sex = 'f';
SELECT * FROM pet WHERE species = 'snake' OR species = 'bird';
SELECT * FROM pet WHERE (species = 'cat' AND sex = 'm')
       OR (species = 'dog' AND sex = 'f');
       
-- to select a particular column we give
SELECT name, birth FROM pet;

-- to remove duplicate ones we give DISTINCT
SELECT DISTINCT owner FROM pet;

-- we can also sort row using order by
SELECT name, birth FROM pet ORDER BY birth;

-- we can also change the order in desc default will be ascn
SELECT name, birth FROM pet ORDER BY birth DESC;

-- we can also calculate date 
-- the curdate is current date
SELECT name, birth, CURDATE(),
       TIMESTAMPDIFF(YEAR,birth,CURDATE()) AS age
       FROM pet;

-- we can mix and write sql 
SELECT name, birth, death,
       TIMESTAMPDIFF(YEAR,birth,death) AS age
       FROM pet WHERE death IS NOT NULL ORDER BY age;
       
SELECT name, birth FROM pet WHERE MONTH(birth) = 8;

-- we also have the date calculation
SELECT '2018-10-31' + INTERVAL 1 DAY;

-- if we give wrong date values it will produce warning
SELECT '2018-10-32' + INTERVAL 1 DAY;
-- this will return NULL
SHOW WARNINGS;
-- using this warning we can see the incorrect datetime value warning	

-- NULL data
SELECT 1 IS NULL, 1 IS NOT NULL;

-- this is pattern match where value% is to tell mysql its the starting value
SELECT * FROM pet WHERE name LIKE 'b%';

-- this is pattern match where %value is to tell mysql its the ending value
SELECT * FROM pet WHERE name LIKE '%fy';

-- this is to match any word which has w init
SELECT * FROM pet WHERE name LIKE '%w%';

-- This is to match the number underscore present
SELECT * FROM pet WHERE name LIKE '_____';

SELECT * FROM pet WHERE REGEXP_LIKE(name, '^b');
SELECT * FROM pet WHERE REGEXP_LIKE(name, 'fy$');
 SELECT * FROM pet WHERE REGEXP_LIKE(name, 'w');
 SELECT * FROM pet WHERE REGEXP_LIKE(name, '^.....$');
 SELECT * FROM pet WHERE REGEXP_LIKE(name, '^.{5}$');
 
 
 -- COUNTING FUNCTIONS
 SELECT COUNT(*) FROM pet;
 SELECT owner, COUNT(*) FROM pet GROUP BY owner;
 SELECT species, COUNT(*) FROM pet GROUP BY species;
 SELECT species, sex, COUNT(*) FROM pet
       WHERE sex IS NOT NULL
       GROUP BY species, sex;
       
-- While the sql mode is set to full order this group by will produce error
SET sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT owner, COUNT(*) FROM pet;

SET sql_mode = '';
SELECT owner, COUNT(*) FROM pet;


CREATE TABLE event (name VARCHAR(20), date DATE,
       type VARCHAR(15), remark VARCHAR(255));
       
INSERT INTO event VALUES('Fluffy','1995-05-15','litter','4 kittens,3 female, 1 male');
INSERT INTO event VALUES('Buffy','1993-06-23','litter','5 puppies, 2 female, 3 male');
INSERT INTO event VALUES('Bowser','1991-10-12','kennel');

SELECT pet.name,
       TIMESTAMPDIFF(YEAR,birth,date) AS age,
       remark
       FROM pet INNER JOIN event
         ON pet.name = event.name
       WHERE event.type = 'litter';


SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species
       FROM pet AS p1 INNER JOIN pet AS p2
         ON p1.species = p2.species
         AND p1.sex = 'f' AND p1.death IS NULL
         AND p2.sex = 'm' AND p2.death IS NULL;
	
-- to see the current database we give
SELECT DATABASE();	
SHOW TABLES;
DESCRIBE pet;
DESCRIBE event;

-- this AS statement is used to duplicate the table with column 
CREATE TABLE pet_newtable AS SELECT * FROM pet;
DESCRIBE pet_newtable;


-- To rename the table name we give rename table or alter table rename
RENAME TABLE pet_newtable TO pet_ntbl_updated;
ALTER TABLE pet_ntbl_updated RENAME pet_ntbl_upd;

-- to swap table we can give
RENAME TABLE old_table TO tmp_table,
             new_table TO old_table,
             tmp_table TO new_table;
             

-- we can also change table from one db to another db using rename 
RENAME TABLE current_db.tbl_name TO other_db.tbl_name;


-- TRUNCATE is the sequence of DROP TABLE and CREATE TABLE
CREATE TABLE dummy(i INT);
INSERT INTO dummy VALUES(1);
SELECT * FROM dummy;

TRUNCATE TABLE dummy; 


-- INDEXES
-- This  indexes are the column which mysql will remember in btree to search faster 

-- _rowid refers to the PRIMARY KEY column if there is a PRIMARY KEY consisting of a 
-- single integer column. If there is a PRIMARY KEY but it does not consist of a single 
-- integer column, _rowid cannot be used.

-- Otherwise, _rowid refers to the column in the first UNIQUE NOT NULL index if that index 
-- consists of a single integer column. If the first UNIQUE NOT NULL index does not consist 
-- of a single integer column, _rowid cannot be used.

CREATE TABLE customers (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    custinfo JSON,
    INDEX zips( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) )
    );
    
CREATE TABLE customers (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    custinfo JSON
    );

CREATE INDEX zips ON customers ( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) );



