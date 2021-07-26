-- CREATE DATABASE foreignKey;
-- use foreignKey;

-- CREATE TABLE Customers
-- (ID INT PRIMARY KEY , 
--  CustomerName VARCHAR(50), 
--  CustomerAge  SMALLINT, 
--  CustomerCountry  VARCHAR(50)
-- );

INSERT foreignkey.customers (ID,CustomerName,CustomerAge,CustomerCountry) VALUES (1,'Salvador',23,'Brazil ');
INSERT foreignkey.customers (ID,CustomerName,CustomerAge,CustomerCountry) VALUES (2,'Lawrence',60,'China ');
INSERT foreignkey.customers (ID,CustomerName,CustomerAge,CustomerCountry) VALUES(3,'Ernest',38,'India');

show tables;

CREATE TABLE CustomerOrders
(ID INT PRIMARY KEY ,
 OrderDate DATETIME, 
 CustomerID INT,
 FOREIGN KEY (CustomerID) REFERENCES Customers(ID) ON DELETE CASCADE  ON UPDATE CASCADE, 
 Amout BIGINT
);

DROP TABLE CustomerOrders;
INSERT INTO foreignkey.CustomerOrders(ID,OrderDate,CustomerID,Amout) VALUES (1,NOW(),1,968.45);
INSERT INTO foreignkey.CustomerOrders(ID,OrderDate,CustomerID,Amout) VALUES (2,NOW(),2,898.36);
INSERT INTO foreignkey.CustomerOrders(ID,OrderDate,CustomerID,Amout) VALUES (3,NOW(),3,47.01);



SELECT * FROM CustomerOrders;

-- This will return an error because no foreign key 4 is not present
INSERT INTO foreignKey.CustomerOrders(ID,OrderDate,CustomerID,Amout) 
VALUES (4,NOW() ,3,968.45);

SET sql_mode = '';
SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
SELECT customerName FROM customers;
-- This below line will fetch error because of update or delete foreign key
UPDATE foreignKey.Customers SET ID = 4 WHERE CustomerAge = 60;

SELECT * FROM customerorders;

SELECT * FROM customers JOIN customerorders ON customers.id = customerorders.ID;
SELECT * FROM customers FULL JOIN customerorders;
SELECT * FROM customers CROSS JOIN customerorders ON customers.id = customerorders.ID;
SELECT * FROM customers JOIN customerorders ON customers.id = customerorders.ID;
SELECT * FROM customers LEFT JOIN customerorders ON customers.id = customerorders.ID;
SELECT * FROM customers RIGHT JOIN customerorders ON customers.id = customerorders.ID;
SELECT * FROM customers;


CREATE DATABASE schooldb;
        
USE schooldb;
CREATE TABLE student
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    DOB datetime NOT NULL,
    total_score INT NOT NULL,
    city VARCHAR(50) NOT NULL
 );
 
USE schooldb;
-- EXECUTE sp_helpindex ;

INSERT INTO student
 
VALUES  
(12, 'Kate', 'Female', '03-JAN-1985', 500, 'Liverpool'),
(2, 'Jon', 'Male', '02-FEB-1974', 545, 'Manchester'),
(9, 'Wise', 'Male', '11-NOV-1987', 499, 'Manchester'), 
(3, 'Sara', 'Female', '07-MAR-1988', 600, 'Leeds'), 
(1, 'Jolly', 'Female', '12-JUN-1989', 500, 'London'),
(4, 'Laura', 'Female', '22-DEC-1981', 400, 'Liverpool'),
(7, 'Joseph', 'Male', '09-APR-1982', 643, 'London'),  
(5, 'Alan', 'Male', '29-JUL-1993', 500, 'London'), 
(8, 'Mice', 'Male', '16-AUG-1974', 543, 'Liverpool'),
(10, 'Elis', 'Female', '28-OCT-1990', 400, 'Leeds');

SELECT * FROM student;

-- The below statement will cause error and so we need to rewrite the code as
CREATE PROCEDURE dorepeat(p1 INT)
BEGIN
  SET @x = 0;
  REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
END;

delimiter //
CREATE PROCEDURE dorepeat(p1 INT)
BEGIN
  SET @x = 0;
  REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
END;dorepeat
delimiter ;

CALL dorepeat(1000);

SELECT @x;
