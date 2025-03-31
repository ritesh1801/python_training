CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES
(1, 'Akash', 'India'),
(2, 'Jack Ma', 'China'),
(3, 'Kakashi Hatake', 'Japan'),
(4, 'Maria Lee', 'USA');

INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES
(6, 'Jack Ma', 'China'),
(7, 'Kakashi Hatake', 'Japan'),
(8, 'Taro Yamada', 'Japan'),
(9, 'Emma Brown', 'UK'),
(10, 'Liu Wei', 'China'),
(11, 'Michael Johnson', 'USA'),
(12, 'Sara Williams', 'Canada'),
(13, 'Liam Anderson', 'Australia'),
(14, 'Olivia Martinez', 'USA'),
(15, 'Noah Harris', 'UK'),
(16, 'Sophia Kim', 'South Korea'),
(17, 'Mia Davis', 'Canada'),
(18, 'James Lee', 'USA'),
(19, 'Daniel Chen', 'China'),
(20, 'Ella Wilson', 'UK');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2025-03-01', 150.50),
(102, 2, '2025-03-05', 200.75),
(103, 4, '2025-03-08', 120.00),
(104, 3, '2025-03-12', 500.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(109, 6, '2025-03-12', 500.00),
(110, 7, '2025-03-15', 300.00),
(111, 8, '2025-03-17', 100.00),
(112, 9, '2025-03-20', 250.00),
(113, 10, '2025-03-22', 350.00),
(114, 11, '2025-03-25', 150.00),
(115, 12, '2025-03-28', 400.00),
(116, 13, '2025-03-30', 50.00),
(117, 14, '2025-04-02', 200.00),
(118, 15, '2025-04-05', 100.00),
(119, 16, '2025-04-08', 600.00),
(120, 17, '2025-04-10', 350.00);


SELECT CustomerID FROM Customers;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 800.00),
(2, 'Smartphone', 500.00),
(3, 'Headphones', 50.00);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 101, 1, 1),
(2, 102, 2, 2),
(3, 103, 3, 5),
(4, 104, 1, 2);


select Customers.CustomerID, Customers.CustomerName, Customers.Country,Orders.OrderID
from Customers
Inner join Orders ON Customers.CustomerID = Orders.CustomerID

Select Customers.CustomerID, Customers.CustomerName,Orders.OrderID
from Customers
left join Orders On Customers.CustomerID = Orders.CustomerID

SELECT Orders.CustomerID, Customers.CustomerName,Orders.OrderID
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT * 
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

Select Customers.*, Orders.* 
from Customers 
cross join Orders 

Select C1.*, C2.* 
from Customers C1
Inner Join Customers C2 On C1.CustomerID = C2.CustomerID; 

select Customers.CustomerID,Customers.CustomerID, Sum(Amount) as TotalAmount
from Customers 
Inner Join Orders  on Customers.CustomerID = Orders.CustomerID
group by Customers.CustomerID
having sum(Amount) > 150;

SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    SUM(Orders.Amount) AS TotalAmount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName;

SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID,
    Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT 
    Customers.CustomerID,
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.Amount
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;


SELECT 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.Amount
FROM Customers
CROSS JOIN Orders;





SELECT Customers.CustomerID, Customers.CustomerName, SUM(Orders.Amount) AS TotalAmount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY GROUPING SETS (
    (Customers.CustomerID, Customers.CustomerName),  
    (Customers.CustomerID),
	()
);


select CustomerName, CustomerID,(select sum(o.amount) from Orders o
where o.CustomerID = C.CustomerID) as TotalSpent from customers C;

select * from customers
where CustomerID in(select distinct CustomerID from Orders where Amount > 400);

select CustomerName,Country from customers
where Country not in(select distinct Country from Customers where Country like 'J%');

select 
C.CustomerName,C.CustomerID,(select o.Orderdate from Orders o
where o.CustomerID = C.CustomerID  and datediff(year,o.orderdate,getdate()) < 1 ) as ThisYearOrders  from Customers C;

SELECT C.CustomerID ,C.CustomerName,(SELECT SUM(o.Amount) 
FROM Orders o 
WHERE o.CustomerID = C.CustomerID 
AND C.Country = 'India') AS OrdersfromIndia
FROM Customers C
WHERE C.Country = 'India';


select * ,(select Sum(o.Amount) from Orders o where o.CustomerID = C.CustomerID) as TotalAmount
from Customers C
where (Select sum(o.Amount) from Orders o
where o.CustomerID = C.CustomerID) > (select avg(amount) from orders);

Select C.CustomerName,C.CustomerID from Customers C 
Where exists (select 1 from Orders o where o.CustomerID = C.CustomerID);

SELECT 
    C.CustomerID, 
    C.CustomerName
FROM Customers C
WHERE C.CustomerID = ALL (
    SELECT O.CustomerID
    FROM Orders O
    GROUP BY O.CustomerID
    HAVING SUM(O.Amount) > 500
);


select CustomerID from Customers
Union
Select CustomerID from Orders

Select CustomerID from Customers
Intersect
Select CustomerID from Orders

select CustomerID from Customers
except
select CustomerID from orders

MERGE INTO Orders AS O
USING Customers AS C
ON O.CustomerID = C.CustomerID
WHEN MATCHED THEN
    UPDATE SET O.OrderDate = C.CustomerSince, 
               O.Amount = C.TotalSpent     
WHEN NOT MATCHED THEN
    INSERT (CustomerID, OrderDate, Amount) 
    VALUES (C.CustomerID, GETDATE(), 0);  
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;  


