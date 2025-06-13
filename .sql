-- ================================================
-- Developer: Phani
-- Assignment: MIS 673 - Assignment 4 - SQL #1
-- ================================================

DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Viewing;
DROP TABLE IF EXISTS ShowAward;
DROP TABLE IF EXISTS ShowTable;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Director;
DROP TABLE IF EXISTS Award;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Viewer;
DROP TABLE IF EXISTS Platform;

-- ================================================
-- CREATING TABLES
-- ================================================

CREATE TABLE Platform (
  PlatformID INT AUTO_INCREMENT PRIMARY KEY,
  PlatformName VARCHAR(50) NOT NULL,
  IsInternetBased BOOLEAN NOT NULL
);

CREATE TABLE Viewer (
  ViewerID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  MI CHAR(1),
  LastName VARCHAR(50) NOT NULL,
  Gender CHAR(1),
  BestFriendID INT,
  FOREIGN KEY (BestFriendID) REFERENCES Viewer(ViewerID)
);

CREATE TABLE Actor (
  ActorID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Gender CHAR(1) NOT NULL
);

CREATE TABLE Director (
  DirectorID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Gender CHAR(1) NOT NULL
);

CREATE TABLE Award (
  AwardID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL
);

CREATE TABLE Genre (
  GenreID INT AUTO_INCREMENT PRIMARY KEY,
  GenreDescription VARCHAR(50) NOT NULL
);

CREATE TABLE ShowTable (
  ShowID INT AUTO_INCREMENT PRIMARY KEY,
  Title VARCHAR(50) NOT NULL,
  DateReleased DATE NOT NULL,
  Description VARCHAR(100) NOT NULL,
  BoxOfficeEarnings DECIMAL(15,2) NOT NULL,
  IMDBRating DECIMAL(3,1) NOT NULL,
  IsMovie BOOLEAN NOT NULL,
  GenreID INT NOT NULL,
  DirectorID INT NOT NULL,
  FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
  FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID)
);

CREATE TABLE Viewing (
  ViewerID INT,
  PlatformID INT,
  ShowID INT,
  WatchDateTime DATETIME NOT NULL,
  ViewerRatingStars DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (ViewerID, PlatformID, ShowID),
  FOREIGN KEY (ViewerID) REFERENCES Viewer(ViewerID),
  FOREIGN KEY (PlatformID) REFERENCES Platform(PlatformID),
  FOREIGN KEY (ShowID) REFERENCES ShowTable(ShowID)
);

CREATE TABLE Role (
  ShowID INT,
  ActorID INT,
  CharacterName VARCHAR(50) NOT NULL,
  Salary INT NOT NULL,
  PRIMARY KEY (ShowID, ActorID),
  FOREIGN KEY (ShowID) REFERENCES ShowTable(ShowID),
  FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)
);

CREATE TABLE ShowAward (
  ShowID INT,
  AwardID INT,
  YearWon INT NOT NULL,
  PRIMARY KEY (ShowID, AwardID),
  FOREIGN KEY (ShowID) REFERENCES ShowTable(ShowID),
  FOREIGN KEY (AwardID) REFERENCES Award(AwardID)
);

-- ==========================================================
-- INSERT SAMPLE DATA INTO THE TABLES AS PER THE REQUIREMENT
-- ==========================================================

-- Platforms
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES
('Aha', 1),
('Hotstar', 1),
('Zee5', 1),
('Netflix', 1),
('Amazon Prime', 1),
('SonyLiv', 1),
('SunNXT', 1),
('JioCinema', 1);

-- Viewers
INSERT INTO Viewer (FirstName, MI, LastName, Gender) VALUES
('Teja', 'K', 'Reddy', 'M'),
('Lakshmi', 'B', 'Kavya', 'F'),
('Mahesh', NULL, 'Varma', 'M'),
('Sita', 'A', 'Devi', 'F'),
('Raj', NULL, 'Kumar', 'M'),
('Ravi', 'P', 'Teja', 'M'),
('Kiran', 'L', 'Chowdary', 'M'),
('Divya', 'S', 'Anand', 'F');

UPDATE Viewer SET BestFriendID = 1 WHERE ViewerID IN (2, 3);
UPDATE Viewer SET BestFriendID = 4 WHERE ViewerID = 5;
UPDATE Viewer SET BestFriendID = 6 WHERE ViewerID = 7;

-- Actors
INSERT INTO Actor (FirstName, LastName, Gender) VALUES
('Mahesh', 'Babu', 'M'),
('Pawan', 'Kalyan', 'M'),
('NTR', 'Jr', 'M'),
('Allu', 'Arjun', 'M'),
('Samantha', 'Ruth', 'F'),
('Rashmika', 'Mandanna', 'F'),
('Vijay', 'Deverakonda', 'M'),
('Nani', 'Ghanta', 'M');

-- Directors
INSERT INTO Director (FirstName, LastName, Gender) VALUES
('Trivikram', 'Srinivas', 'M'),
('Sukumar', 'Bandreddi', 'M'),
('Rajamouli', 'SS', 'M'),
('Krish', 'Jagarlamudi', 'M'),
('Anil', 'Ravipudi', 'M'),
('Sekhar', 'Kammula', 'M'),
('Harish', 'Shankar', 'M'),
('Vamshi', 'Paidipally', 'M');

-- Awards
INSERT INTO Award (Name) VALUES
('Nandi Award'),
('Filmfare South'),
('SIIMA'),
('National Award'),
('CineMAA Awards'),
('Zee Cine Awards'),
('IIFA Utsavam'),
('TSR-TV9 Awards');

-- Genres
INSERT INTO Genre (GenreDescription) VALUES
('Action'),
('Romantic'),
('Drama'),
('Comedy'),
('Historical'),
('Fantasy'),
('Thriller'),
('Family');

-- Shows
INSERT INTO ShowTable (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES
('Pushpa', '2021-12-17', 'Red sanders smuggling drama', 350000000.00, 8.2, TRUE, 1, 2),
('Ala Vaikunthapurramuloo', '2020-01-12', 'Family entertainer', 280000000.00, 7.9, TRUE, 4, 1),
('RRR', '2022-03-25', 'Patriotic fiction epic', 1200000000.00, 8.7, TRUE, 1, 3),
('Gautamiputra Satakarni', '2017-01-12', 'Ancient Telugu ruler biopic', 70000000.00, 7.5, TRUE, 5, 4),
('Sarileru Neekevvaru', '2020-01-11', 'Army man vs corruption', 260000000.00, 7.4, TRUE, 1, 8),
('Fidaa', '2017-07-21', 'Telangana girl love story', 51000000.00, 7.5, TRUE, 2, 6),
('DJ Tillu', '2022-02-12', 'Carefree youth & mess', 40000000.00, 7.8, TRUE, 4, 5),
('Eega', '2012-07-06', 'Revenge of a fly', 130000000.00, 7.7, TRUE, 6, 3);

-- Viewing
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES
(1, 1, 1, NOW(), 4.5),
(2, 2, 2, NOW(), 5.0),
(3, 2, 3, NOW(), 4.8),
(4, 1, 2, NOW(), 4.2),
(5, 3, 4, NOW(), 4.0),
(6, 4, 5, NOW(), 4.3),
(7, 5, 6, NOW(), 4.6),
(8, 6, 7, NOW(), 4.1);

-- Role
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES
(1, 4, 'Pushpa Raj', 100000000),
(2, 2, 'Bantu', 90000000),
(3, 3, 'Komaram Bheem', 95000000),
(3, 1, 'Alluri Sitarama Raju', 95000000),
(4, 1, 'Satakarni', 50000000),
(5, 1, 'Ajay Krishna', 65000000),
(6, 6, 'Bhanumathi', 40000000),
(7, 8, 'Tillu', 30000000);

-- ShowAward
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES
(1, 1, 2022),
(2, 2, 2020),
(3, 3, 2022),
(3, 1, 2023),
(4, 4, 2017),
(5, 5, 2021),
(6, 6, 2018),
(7, 7, 2022);

-- ================================================
-- SELECT STATEMENTS
-- ================================================
SELECT * FROM Platform;
SELECT * FROM Viewer;
SELECT * FROM Actor;
SELECT * FROM Director;
SELECT * FROM Award;
SELECT * FROM Genre;
SELECT * FROM ShowTable;
SELECT * FROM Viewing;
SELECT * FROM Role;
SELECT * FROM ShowAward;
