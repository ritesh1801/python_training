-- Database Initialization
IF DB_ID('PetPals') IS NULL
    CREATE DATABASE PetPals;
GO
USE PetPals;
GO

-- Table: Pets
IF OBJECT_ID('Pets', 'U') IS NOT NULL
    DROP TABLE Pets;
GO
CREATE TABLE Pets (
    PetID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Age INT,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption BIT,
    OwnerID INT,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);
GO

-- Table: Shelters
IF OBJECT_ID('Shelters', 'U') IS NOT NULL
    DROP TABLE Shelters;
GO
CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Location VARCHAR(200)
);
GO

-- Table: Donations
IF OBJECT_ID('Donations', 'U') IS NOT NULL
    DROP TABLE Donations;
GO
CREATE TABLE Donations (
    DonationID INT PRIMARY KEY IDENTITY(1,1),
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10, 2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);
GO

-- Table: AdoptionEvents
IF OBJECT_ID('AdoptionEvents', 'U') IS NOT NULL
    DROP TABLE AdoptionEvents;
GO
CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(200)
);
GO

-- Table: Participants
IF OBJECT_ID('Participants', 'U') IS NOT NULL
    DROP TABLE Participants;
GO
CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY IDENTITY(1,1),
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);
GO

-- Table: Adoptions
IF OBJECT_ID('Adoptions', 'U') IS NOT NULL
    DROP TABLE Adoptions;
GO
CREATE TABLE Adoptions (
    AdoptionID INT PRIMARY KEY IDENTITY(1,1),
    PetID INT,
    AdopterID INT,
    AdoptionDate DATETIME,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (AdopterID) REFERENCES Participants(ParticipantID)
);
GO

-- Insert Data into Shelters
INSERT INTO Shelters (Name, Location) VALUES
('Happy Tails Shelter', 'Chennai'),
('Paws & Claws', 'Mumbai'),
('Furry Friends Haven', 'Bangalore'),
('Safe Haven Shelter', 'Delhi');
GO

-- Insert Data into Pets
INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption, ShelterID) VALUES
('Buddy', 3, 'Golden Retriever', 'Dog', 1, 1),
('Whiskers', 2, 'Persian Cat', 'Cat', 1, 2),
('Max', 1, 'Beagle', 'Dog', 0, 1),
('Bella', 4, 'Labrador', 'Dog', 1, 3),
('Shadow', 5, 'German Shepherd', 'Dog', 1, 4);
GO

-- Insert Data into Donations
INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID) VALUES
('John Doe', 'Cash', 5000.00, NULL, '2025-03-30', 1),
('Jane Smith', 'Item', NULL, 'Dog Food', '2025-03-29', 2),
('Alice Brown', 'Cash', 3000.00, NULL, '2025-03-28', 3),
('Robert Green', 'Item', NULL, 'Cat Toys', '2025-03-27', 4);
GO

-- Insert Data into AdoptionEvents
INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Pet Adoption Drive', '2025-04-15', 'Chennai'),
('Love a Pet', '2025-05-20', 'Mumbai'),
('Forever Homes', '2025-06-10', 'Bangalore'),
('Adopt & Care', '2025-07-25', 'Delhi');
GO

-- Insert Data into Participants
INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES
('Happy Tails Shelter', 'Shelter', 1),
('John Doe', 'Adopter', 1),
('Paws & Claws', 'Shelter', 2),
('Alice Brown', 'Adopter', 3);
GO

-- Insert Data into Adoptions
INSERT INTO Adoptions (PetID, AdopterID, AdoptionDate) VALUES
(3, 2, '2025-03-30'),
(1, 4, '2025-03-31'),
(2, 3, '2025-04-01'),
(4, 1, '2025-04-02');
GO

Select * from Shelters
Select * from Donations
Select * from Pets
Select * from AdoptionEvents
Select * from Participants
Select * from Adoptions

--1.Write an SQL query that retrieves a list of available pets (those marked as available for adoption) 
--from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that 
--the query filters out pets that are not available for adoption. 
Select Name,age,Breed,type 
from Pets
where AvailableForAdoption = 1;

--2.Write an SQL query that retrieves the names of participants (shelters and adopters) registered 
--for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query 
--joins the necessary tables to retrieve the participant names and types.
Declare @EventID Int = 1;
Select ParticipantName from Participants where EventID = @EventID;

--3.Create a stored procedure in SQL that allows a shelter to update its information (name and 
--location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information. 
--Ensure that the procedure performs the update and handles potential errors, such as an invalid 
--shelter ID. 

--4.Write an SQL query that calculates and retrieves the total donation amount for each shelter (by 
--shelter name) from the "Donations" table. The result should include the shelter name and the 
--total donation amount. Ensure that the query handles cases where a shelter has received no 
--donations. 
Select S.Name as Shelter_Name,Sum(D.DonationAmount) as Donations from Donations D
left Join Shelters S on S.ShelterID = D.ShelterID
group by S.name

--5.Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an 
--owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result 
--set.
Select name,Age,Breed,Type from Pets
where OwnerID is Null;

--6.Write an SQL query that retrieves the total donation amount for each month and year (e.g., 
--January 2023) from the "Donations" table. The result should include the month-year and the 
--corresponding total donation amount. Ensure that the query handles cases where no donations 
--were made in a specific month-year. 
Select Sum(DonationAmount) as TotalDonations,Format(DonationDate ,'MMMM yyyy') as Date_of_Donation
from Donations
group by Format(DonationDate ,'MMMM yyyy')

--7.Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older 
--than 5 years.
Select Distinct Breed,Name,Age from Pets
where Age between 1 and 3 or Age > 5;

--8.Retrieve a list of pets and their respective shelters where the pets are currently available for 
--adoption.
Select P.name as PetName,S.Name as ShelterName from Pets P
Join Shelters S on P.ShelterID = S.ShelterID
where AvailableForAdoption = 1;

--9.Find the total number of participants in events organized by shelters located in specific city. 
--Example: City=Chennai 
Select E.EventID, Count(*) as Number_of_Participants,E.Location as City from Participants P
join AdoptionEvents E on P.EventID = E.EventID
where E.location = 'Chennai'
group by E.Location,E.EventID

--10.Retrieve a list of unique breeds for pets with ages between 1 and 5 years.
Select Distinct Breed from Pets
where Age Between 1 and 5;

--11.Find the pets that have not been adopted by selecting their information from the 'Pet' table. 
Select Name as Not_Adopted from Pets 
where AvailableForAdoption = 1;

--12.Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and 'User' tables.
Select P.Name as Pet,A.AdopterID as AdopterID from Pets P
Right Join Adoptions A on P.PetID = A.PetID;

--13.Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter. 
Select S.Name,Count(*) as Number_of_pets_available_for_adoption from Pets P
Join Shelters S on S.ShelterID = P.ShelterID
Where P.AvailableForAdoption = 1
group by S.Name;

--14.Find pairs of pets from the same shelter that have the same breed. 
Select P1.Name as Pet1,P2.Name as Pet2 ,P1.Breed as Breed,S.Name as Shelter from Pets P1
Join Pets P2 on P1.ShelterID = P2.ShelterID and P1.Breed = P2.Breed and P1.PetID != P2.PetID
Join Shelters S on P1.ShelterID = S.ShelterID;

--15.List all possible combinations of shelters and adoption events.
Select S.Name as Shelter_Name,A.EventName,A.Location from AdoptionEvents A
Cross Join Shelters S

--16.Determine the shelter that has the highest number of adopted pets. 
Select Top 1 S.Name from Shelters S
Join Pets P on S.ShelterID = P.ShelterID
Join Adoptions A on A.PetID = P.PetID












