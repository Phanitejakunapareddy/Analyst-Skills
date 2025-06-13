-- ====================================================================================
-- Developer: Phani
-- Date: 06/09/2025
-- Assignment: Homework #5
-- ====================================================================================

SET NOCOUNT ON;

-- ========================================================
-- PART 1:
-- tb_HW Tables
-- ========================================================

-- HW 5, Q1. List all student names.
SELECT S.FirstName, S.LastName
FROM tb_HWStudent AS S
ORDER BY S.LastName, S.FirstName;

-- HW 5, Q2. How many students are there?
SELECT COUNT(*) AS StudentCount
FROM tb_HWStudent AS S;

-- HW 5, Q3. List all student names currently enrolled (no duplicates).
SELECT DISTINCT S.FirstName, S.LastName
FROM tb_HWStudent AS S
INNER JOIN tb_HWEnrolled AS E ON S.SID = E.SID
ORDER BY S.LastName, S.FirstName;

-- HW 5, Q4. Student info with course code + grade (if any).
SELECT S.SID, S.FirstName, S.LastName, C.CourseCode, E.Grade
FROM tb_HWStudent AS S
LEFT OUTER JOIN tb_HWEnrolled AS E ON S.SID = E.SID
LEFT OUTER JOIN tb_HWCourse AS C ON E.CID = C.CID
ORDER BY S.LastName, S.FirstName, C.CourseCode;

-- HW 5, Q5. All courses and their instructor names (even if unassigned).
SELECT C.CourseCode, C.CourseDescription, E.FirstName AS InstructorFirstName, E.LastName AS InstructorLastName
FROM tb_HWCourse AS C
LEFT OUTER JOIN tb_HWEmployee AS E ON C.InstructorEID = E.EID
ORDER BY C.CourseCode;

-- ========================================================
-- PART 2:
-- Your SHOW Assignment Tables
-- ========================================================

-- HW 5, Q6. List all show titles released after 2020 with IMDB rating > 8
SELECT S.Title, S.DateReleased, S.IMDBRating
FROM Show AS S
WHERE S.DateReleased > '2020-12-31' AND S.IMDBRating > 8.0
ORDER BY S.DateReleased DESC;

-- HW 5, Q7. Names of viewers who rated a show > 4.5 stars
SELECT DISTINCT V.FirstName, V.LastName
FROM Viewer AS V
INNER JOIN Viewing AS VW ON V.ViewerID = VW.ViewerID
WHERE VW.ViewerRatingStars > 4.5;

-- HW 5, Q8. List all shows and their genre descriptions
SELECT S.Title, G.GenreDescription
FROM Show AS S
INNER JOIN Genre AS G ON S.GenreID = G.GenreID;

-- HW 5, Q9. List actors and shows they appeared in, with character names
SELECT A.FirstName AS ActorFirstName, A.LastName AS ActorLastName, S.Title, R.CharacterName
FROM Actor AS A
INNER JOIN Role AS R ON A.ActorID = R.ActorID
INNER JOIN Show AS S ON R.ShowID = S.ShowID
ORDER BY A.LastName, S.Title;

-- HW 5, Q10. Platforms and number of shows watched on them
SELECT P.PlatformName, COUNT(VW.ShowID) AS TotalShowsWatched
FROM Platform AS P
LEFT OUTER JOIN Viewing AS VW ON P.PlatformID = VW.PlatformID
GROUP BY P.PlatformName
ORDER BY TotalShowsWatched DESC;
