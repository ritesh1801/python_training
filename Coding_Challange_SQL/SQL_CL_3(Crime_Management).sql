
CREATE TABLE Crime (
    CrimeID INT PRIMARY KEY,
    IncidentType VARCHAR(255),
    IncidentDate DATE,
    Location VARCHAR(255),
    Description TEXT,
    Status VARCHAR(20)
);

CREATE TABLE Victim (
    VictimID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    Injuries VARCHAR(255),
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
    SuspectID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    Description TEXT,
    CriminalHistory TEXT,
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status) VALUES
    (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
    (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
    (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries) VALUES
    (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
    (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
    (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory) VALUES
    (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
    (2, 2, 'Unknown', 'Investigation ongoing', NULL),
    (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');


ALTER TABLE Victim ADD Age INT;
ALTER TABLE Suspect ADD Age INT;


UPDATE Victim SET Age = 35 WHERE Name = 'John Doe';
UPDATE Victim SET Age = 40 WHERE Name = 'Jane Smith';
UPDATE Victim SET Age = 28 WHERE Name = 'Alice Johnson';


UPDATE Suspect SET Age = 30 WHERE Name = 'Robber 1';
UPDATE Suspect SET Age = 25 WHERE Name = 'Suspect 1';
UPDATE Suspect SET Age = NULL WHERE Name = 'Unknown';

    INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status) VALUES
    (4, 'Robbery', '2023-09-25', '222 Maple St, Cityville', 'Bank robbery reported', 'Open'),
    (5, 'Robbery', '2023-10-01', '555 Pine St, Cityville', 'Jewelry store heist', 'Open'),
    (6, 'Homicide', '2023-10-05', '888 Birch St, Townsville', 'Double murder investigation', 'Under Investigation'),
    (7, 'Assault', '2023-10-10', '999 Willow St, Villagetown', 'Physical assault at a nightclub', 'Closed');

	INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries, Age) VALUES
    (4, 4, 'Michael Brown', 'michaelbrown@example.com', 'Serious injuries', 40),
    (5, 5, 'Lisa White', 'lisawhite@example.com', 'None', 28),
    (6, 6, 'David Johnson', 'davidjohnson@example.com', 'Deceased', 50),
    (7, 7, 'Chris Evans', 'chrisevans@example.com', 'Bruises', 22);

	INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory) VALUES
    (4, 4, 'Robber 2', 'Masked individual', 'Bank robbery suspect'),
    (5, 5, 'Robber 3', 'Wore a black hoodie', 'Prior theft cases'),
    (6, 6, 'Unknown', 'Investigation ongoing', NULL),
    (7, 7, 'Suspect 2', 'Nightclub altercation', 'Assault charges in past');

	INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries, Age) VALUES
    (8, 4, 'James Wilson', 'jameswilson@example.com', 'Minor injuries', 33), 
    (9, 5, 'Emma Davis', 'emmadavis@example.com', 'Serious injuries', 29); 
	INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory) VALUES
    (8, 6, 'James Wilson', 'Linked to homicide case', 'Prior assault case'),  
    (9, 7, 'Emma Davis', 'Involved in a bar fight', 'No prior record'); 
	INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory, Age) VALUES
    (10, 4, 'Mark Taylor', 'Repeat offender in robbery cases', 'Prior robbery and assault cases', 42),
    (11, 6, 'Mark Taylor', 'Suspected connection to homicide case', 'Prior robbery and assault cases', 42);

	INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status) VALUES
    (8, 'Burglary', '2024-02-15', '101 Pine St, Cityville', 'Home burglary reported', 'Open'),
    (9, 'Assault', '2024-03-10', '202 Maple Ave, Townsville', 'Physical altercation in a parking lot', 'Under Investigation');


	
UPDATE Suspect SET Age = 38 WHERE SuspectID = 1;
UPDATE Suspect SET Age = NULL WHERE SuspectID = 2;
UPDATE Suspect SET Age = 27 WHERE SuspectID = 3;
UPDATE Suspect SET Age = 40 WHERE SuspectID = 4;
UPDATE Suspect SET Age = 35 WHERE SuspectID = 5;
UPDATE Suspect SET Age = NULL WHERE SuspectID = 6;
UPDATE Suspect SET Age = 29 WHERE SuspectID = 7;
UPDATE Suspect SET Age = 33 WHERE SuspectID = 8;
UPDATE Suspect SET Age = 29 WHERE SuspectID = 9;




	select * from Crime;
	select * from Victim;
	select * from Suspect;

    --1
	Select * from Crime
	where Status ='open';

	--2
	Select Count(*) as TotalIncidents from Crime;

	--3
	Select Distinct IncidentType from Crime;

	--4
	Select * from Crime
	where IncidentDate between '2023-9-1' and '2023-9-10';

	--5.
	Select Name,Age from Victim
	Order by Age desc;

	--6
	Select Avg(age) as Average_age from Victim;

	--7
	Select IncidentType,Count(*) as Count from Crime
	where Status in ('Open')
	group by IncidentType;

	--8
	Select name from Victim
	where name like ('%Doe');

	 --9
	 select name As Victim_name ,C.status as Incident_Status from Victim V
	 join Crime C on V.CrimeID = C.CrimeID
	 where status in ('open','closed');

	 --10
	 Select V.name,C.IncidentType,V.Age from Crime C
	 join Victim V on C.CrimeID = V.CrimeID
	 where age in ('30','35');

	 --11
	 Select S.name,S.SuspectID,C.IncidentType from Suspect S
	 join Crime C on S.CrimeID = C.CrimeID
	 where IncidentType = 'Robbery';

	 --12
	 Select IncidentType from Crime
	 where status = 'Open'
	 group by IncidentType
	 having count(*) > 1;

	 --13
	 Select Distinct C.CrimeID,S.Name from Crime C
	 join Suspect S on S.CrimeID = C.CrimeID
	 join Victim V on V.name = S.name;

	 --14.
	 Select C.*,V.Name as Victim_Name,S.name as Suspect_Name from Crime C
	 join Suspect S on S.CrimeID = C.CrimeID
	 join Victim V on V.CrimeID = C.CrimeID;

	 --15.
	 SELECT Distinct C.CrimeID, V.Age 
     FROM Crime C
     JOIN Suspect S ON S.CrimeID = C.CrimeID
     JOIN Victim V ON V.CrimeID = C.CrimeID
     WHERE V.Age > ALL (SELECT Age FROM Suspect Where Age is Not Null);


	 --16.
	SELECT S.Name, COUNT(DISTINCT S.CrimeID) AS CrimeCount
    FROM Suspect S
    GROUP BY S.Name
    HAVING COUNT(DISTINCT S.CrimeID) > 1;

	 --17
	 SELECT * 
     FROM Crime 
     WHERE CrimeID NOT IN (SELECT DISTINCT CrimeID FROM Suspect);

	 --18
	 SELECT CrimeID
     FROM Crime
     GROUP BY CrimeID
     HAVING SUM(CASE WHEN IncidentType = 'Homicide' THEN 1 ELSE 0 END) > 0
     AND SUM(CASE WHEN IncidentType = 'Robbery' THEN 1 ELSE 0 END) = COUNT(*)
	 --18
	 SELECT * FROM Crime 
     WHERE IncidentType = 'Homicide'
     UNION ALL
     SELECT * FROM Crime 
     WHERE IncidentType = 'Robbery';


	 --19
     SELECT Crime.*, ISNULL(Suspect.Name, 'No Suspect') AS SuspectName
     FROM Crime
     LEFT JOIN Suspect ON Crime.CrimeID = Suspect.CrimeID;

	
	 --20
     Select S.name , S.SuspectID,C.IncidentType from Suspect S
     join Crime C on S.CrimeID = C.CrimeID
     where IncidentType in ('Robbery','Assault');

	


