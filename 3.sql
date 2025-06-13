-- ====================================================================================
-- Developer: Phani
-- Date: 06/10/2025
-- Assignment: Homework #6
-- ====================================================================================


SET NOCOUNT ON;

-- HW 6, Q1.
-- List each course Code, along with how many students are enrolled in each course.
SELECT C.CourseCode, COUNT(E.SID) AS NumStudents
FROM tb_HWCourse AS C
LEFT OUTER JOIN tb_HWEnrolled AS E ON C.CID = E.CID
GROUP BY C.CourseCode
ORDER BY C.CourseCode;

-- HW 6, Q2.
-- Each course code/ID with ≤ 2 students or zero (show 0).
SELECT C.CourseCode, C.CID, COUNT(E.SID) AS NumStudents
FROM tb_HWCourse AS C
LEFT OUTER JOIN tb_HWEnrolled AS E ON C.CID = E.CID
GROUP BY C.CourseCode, C.CID
HAVING COUNT(E.SID) <= 2
ORDER BY C.CourseCode;

-- HW 6, Q3.
-- Student names, DOB, and current age (approx).
SELECT S.FirstName, S.LastName, S.DOB,
       (DATEDIFF(DAY, S.DOB, GETDATE()) / 365) AS Age
FROM tb_HWStudent AS S
ORDER BY Age DESC;

-- HW 6, Q4.
-- Avg age of students per course and count
SELECT C.CourseCode,
       COUNT(S.SID) AS NumStudents,
       ISNULL(AVG(DATEDIFF(DAY, S.DOB, GETDATE()) / 365), 0) AS AvgAge
FROM tb_HWCourse AS C
LEFT OUTER JOIN tb_HWEnrolled AS E ON C.CID = E.CID
LEFT OUTER JOIN tb_HWStudent AS S ON E.SID = S.SID
GROUP BY C.CourseCode
ORDER BY AvgAge DESC;

-- HW 6, Q5.
-- Courses related to "Brontosaurus" and who teaches them
SELECT C.*, E.FirstName AS InstructorFirstName, E.LastName AS InstructorLastName
FROM tb_HWCourse AS C
LEFT OUTER JOIN tb_HWEmployee AS E ON C.InstructorEID = E.EID
WHERE C.CourseCode LIKE '%Brontosaurus%' OR C.CourseDescription LIKE '%Brontosaurus%'
ORDER BY C.CourseCode DESC;

--=========================================================================
--- Part 2
--=========================================================================
-- HW 6, Q6.
-- List each genre and the average IMDB rating of shows in that genre.
-- Include genres even if they have 0 shows (they’ll show NULL for avg).
-- Only include genres with at least 2 shows.

SELECT 
    G.GenreDescription,
    COUNT(S.ShowID) AS NumShows,
    AVG(S.IMDBRating) AS AvgIMDBRating
FROM Genre AS G
LEFT OUTER JOIN Show AS S ON G.GenreID = S.GenreID
GROUP BY G.GenreDescription
HAVING COUNT(S.ShowID) >= 2
ORDER BY AvgIMDBRating DESC;



-- HW 6, Q7.
-- List each platform and the number of distinct viewers.
-- Include platforms with zero viewers.
-- Only show platforms with more than 1 viewer or NULL (to show zero).

SELECT 
    P.PlatformName,
    COUNT(DISTINCT V.ViewerID) AS UniqueViewers
FROM Platform AS P
LEFT OUTER JOIN Viewing AS V ON P.PlatformID = V.PlatformID
GROUP BY P.PlatformName
HAVING COUNT(DISTINCT V.ViewerID) > 1 OR COUNT(DISTINCT V.ViewerID) = 0
ORDER BY P.PlatformName;



-- HW 6, Q8.
-- For each director, show number of shows and avg IMDB.
-- Include directors who directed 0 shows (NULLs in rating).

SELECT 
    D.FirstName + ' ' + D.LastName AS DirectorName,
    COUNT(S.ShowID) AS NumShowsDirected,
    AVG(S.IMDBRating) AS AvgRating
FROM Director AS D
LEFT OUTER JOIN Show AS S ON D.DirectorID = S.DirectorID
GROUP BY D.FirstName, D.LastName
HAVING COUNT(S.ShowID) > 1 OR COUNT(S.ShowID) = 0
ORDER BY NumShowsDirected DESC;



-- HW 6, Q9.
-- List actors and number of unique characters played.
-- Include actors with 0 roles.

SELECT 
    A.FirstName + ' ' + A.LastName AS ActorName,
    COUNT(DISTINCT R.CharacterName) AS UniqueCharacters
FROM Actor AS A
LEFT OUTER JOIN Role AS R ON A.ActorID = R.ActorID
GROUP BY A.FirstName, A.LastName
HAVING COUNT(DISTINCT R.CharacterName) > 1 OR COUNT(DISTINCT R.CharacterName) = 0
ORDER BY UniqueCharacters DESC;



-- HW 6, Q10.
-- List shows and the number of awards.
-- Include shows with zero awards.

SELECT 
    S.Title,
    COUNT(SA.AwardID) AS NumAwards
FROM Show AS S
LEFT OUTER JOIN ShowAward AS SA ON S.ShowID = SA.ShowID
GROUP BY S.Title
ORDER BY NumAwards DESC, S.Title;
