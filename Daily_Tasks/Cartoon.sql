CREATE TABLE Organizations (
    OrganizationID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    ContactEmail VARCHAR(255)
);


CREATE TABLE Series (
    SeriesID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    OrganizationID INT,
	TRP DECIMAL(5, 2),
	NoOfViews INT,
    FOREIGN KEY (OrganizationID) REFERENCES Organizations(OrganizationID)
);


CREATE TABLE Cartoons (
    CartoonID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ReleaseDate DATE,
    SeriesID INT,
	TRP DECIMAL(5, 2),
	NoOfViews INT,
    FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID)
);


INSERT INTO Organizations (OrganizationID, Name, Address, ContactEmail)
VALUES
    (1, 'Pixar Animation Studios', '1200 Park Avenue, Emeryville, CA', 'contact@pixar.com'),
    (2, 'Walt Disney Animation Studios', '500 S. Flower Street, Burbank, CA', 'info@disneyanimation.com'),
    (3, 'Studio Ghibli', '1-1-1 Kamiyama-cho, Mitaka, Tokyo', 'support@ghibli.jp'),
    (4, 'DreamWorks Animation', '1000 Flower Street, Glendale, CA', 'hello@dreamworks.com'),
    (5, 'Nickelodeon Animation Studio', '231 W Olive Avenue, Burbank, CA', 'animation@nick.com'),
    (6, 'Cartoon Network Studios', '300 N 3rd Street, Burbank, CA', 'studios@cartoonnetwork.com'),
    (7, 'Sony Pictures Animation', '10202 W Washington Blvd, Culver City, CA', 'animation@sonypictures.com'),
    (8, 'Blue Sky Studios', '1065 Avenue of the Americas, New York, NY', 'contact@blueskystudios.com'),
    (9, 'Laika', '137 SE Salmon Street, Portland, OR', 'info@laika.com'),
    (10, 'Aardman Animations', 'Gas Ferry Road, Bristol, UK', 'studio@aardman.com');


INSERT INTO Series (SeriesID, Title, Genre, OrganizationID, TRP, NoOfViews)
VALUES
    (1, 'Toy Story', 'Animation', 1, 5.2, 1500000),
    (2, 'The Lion King', 'Animation', 2, 6.8, 1800000),
    (3, 'Spirited Away', 'Animation', 3, 4.5, 1200000),
    (4, 'Shrek', 'Animation', 4, 7.1, 2000000),
    (5, 'SpongeBob SquarePants', 'Animation', 5, 6.0, 1700000),
    (6, 'Adventure Time', 'Animation', 6, 5.5, 1600000),
    (7, 'Cloudy with a Chance of Meatballs', 'Animation', 7, 4.8, 1100000),
    (8, 'Ice Age', 'Animation', 8, 6.2, 1800000),
    (9, 'Coraline', 'Animation', 9, 5.0, 1300000),
    (10, 'Wallace & Gromit', 'Animation', 10, 6.5, 1400000);



INSERT INTO Cartoons (CartoonID, Title, ReleaseDate, SeriesID, TRP, NoOfViews)
VALUES
    (1, 'Toy Story 1', '1995-11-22', 1, 5.0, 1500000),
    (2, 'Toy Story 2', '1999-10-30', 1, 5.3, 1550000),
    (3, 'Toy Story 3', '2010-06-18', 1, 5.5, 1600000),
    (4, 'The Lion King 1', '1994-06-15', 2, 6.5, 1700000),
    (5, 'The Lion King 2', '1998-10-27', 2, 7.0, 1750000),
    (6, 'Spirited Away', '2001-07-20', 3, 4.2, 1200000),
    (7, 'Shrek 1', '2001-04-22', 4, 7.0, 1800000),
    (8, 'Shrek 2', '2004-05-19', 4, 7.2, 1850000),
    (9, 'SpongeBob SquarePants Movie', '2004-11-19', 5, 6.0, 1700000),
    (10, 'Adventure Time: Distant Lands', '2020-06-25', 6, 5.5, 1600000);

Exec sp_rename Cartoons,CartoonCharacters;

	select * from series
	order by TRP desc;

SELECT TOP 1* 
FROM CartoonCharacters 
ORDER BY TRP DESC;



SELECT TOP 1* 
FROM CartoonCharacters 
ORDER BY NoOfViews DESC;

select top 1 *
from Series
Order by NoOfViews Desc;