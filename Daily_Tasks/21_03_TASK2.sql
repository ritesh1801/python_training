CREATE DATABASE EmployeeRecords

Alter Database EmployeeRecords
Modify Name = HR_Records;

Use master
ALTER DATABASE HR_Database SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
Drop Database HR_Records

--INT: A numeric data type used to store integers, example: for storing customer IDs, quantities.
--VARCHAR: A variable-length string used to store text, example: names, email addresses.
--DATE: Stores date values, example birthdates, join dates.
--DATETIME: Stores both date and time values, example order dates, transaction timestamps.
--DECIMAL: Stores fixed-point numbers, example: prices, financial figures).

Create Table Customer(
CustomerID INT Primary Key,
FullName Varchar(50),
Email Varchar(50),
DateJoined Datetime
);


Alter Table Customer
Add Address Varchar(50);

Exec sp_rename Customer,ClientDetails


ALTER DATABASE test SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP TABLE ClientDetails;

Create Table Customers(
CustomerID INT Primary Key, 
FullName Varchar(50), 
Email Varchar(50), 
Phone Varchar(20), 
DateJoined datetime
);
INSERT INTO Customers (CustomerID, FullName, Email, Phone, DateJoined)
VALUES
(1, 'A', 'A1@gmail.com', '1234568904', '2021-01-15'),
(2, 'B', 'B2@gmail.com', '9876543210', '2020-08-25'),
(3, 'B', 'C3@gmail.com', '5551235675', '2019-05-30'),
(4, 'D', 'D4@gmail.com', '4445556666', '2022-03-12'),
(5, 'E', 'E5@gmail.com', '3337778888', '2020-10-10');

UPDATE Customers
SET Email = 'newemail@gmail.com'
WHERE CustomerID = 3;

DELETE FROM Customers
WHERE CustomerID = 5;

INSERT INTO Customers (CustomerID, FullName, Email, Phone, DateJoined)
VALUES
(6, 'F', 'F7@gmail.com', '1236547890', '2021-01-15'),
(7, 'G', 'G8@gmail.com', '9876543210', '2020-08-25'),

Select FullName,Email
from Customers

Select * from Customers
Where datejoined > 2020-01-01

Select * from Customers
Where FullName Like 'J%';

Select * from Customers
Where Phone is Null

Select * from Customers
Where CustomerID in(1,3,7)

SELECT * 
FROM Customers
WHERE City = 'New York' OR DateJoined < '2019-06-01';


Select * from Customers
Where Datejoined  Between '2018-01-01' AND '2023-12-31'

Select 
  CustomerID as ID,
  FullName as Name,
  Email as Mail,
  Phone as Contact_Number,
  Datejoined as FirstVisited
from Customers as 

Select * from Customers
 Where CustomerID < 4 AND DateJoined <2021-12-31

 SELECT * FROM Customers WHERE DateJoined > '2020-01-01';




