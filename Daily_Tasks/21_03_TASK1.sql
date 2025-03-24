Use StudentRecords;
Go

Alter Database StudentRecords Modify Name = UniversityRecords

Use master
Drop Database UniversityRecords

Create Table Students (
StudentID INT Primary Key,
FirstName Varchar(50),
LastName Varchar(50),
Department Varchar(50)
);


Alter table Students
Add Email Varchar(50);


EXEC sp_rename Students, UniversityStudents;

Drop Table UniversityStudents;

Create Table Students(
StudentID INT PRimary Key,
FirstName Varchar(50),
LastName Varchar(50),
Email Varchar(50)
);

Insert into Students Values
(4234, 'Ritesh','Mohite','ram@gmail.com'),
(5643, 'Atharva','Mahajan','am@gmail.com'),
(6345, 'Rohit','Kadam','rk@gmail.com'),
(6543, 'Rushi','Mohite','rsm@gmail.com'),
(6348, 'Akash','Mohite','am@gmail.com');


UPDATE Students
SET Email = 'ritesh@email.com'
WHERE StudentID = 4234;

DELETE FROM Students
WHERE StudentID = 6543;

SELECT FirstName, LastName, Email
FROM Students
WHERE StudentID < 6000;

SELECT * FROM Students;

ALTER TABLE Students
ADD Department VARCHAR(50);


SELECT FirstName, LastName, Department
FROM Students
WHERE Department = 'Computer Science';
