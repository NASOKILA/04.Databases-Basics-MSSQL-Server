
SELECT DepartmentId
FROM Employees
group by DepartmentID

SELECT 
DepartmentID, SUM(Salary) as [Total Salary]
FROM Employees
GROUP BY DepartmentID
ORDER BY [Total Salary] DESC

SELECT 
JobTitle, COUNT(FirstName) as [NamesCount]
FROM Employees
GROUP BY JobTitle
ORDER BY [NamesCount] DESC

SELECT
COUNT(FirstName) as [PeopleCount]
FROM Employees

SELECT 
FirstName, COUNT(EmployeeID)
FROM Employees
GROUP BY FirstName

SELECT
LEFT(FirstName, 2), COUNT(FirstName)
FROM Employees
GROUP BY LEFT(FirstName, 2)

SELECT * FROM Mountains

SELECT * FROM Peaks

SELECT 
MountainId,
COUNT(Id) as [PeakNumber]
FROM Peaks
GROUP BY MountainId
ORDER BY [PeakNumber] DESC

USE Diablo

SELECT 
SUM(Price),
ItemTypeId
FROM items
GROUP BY ItemTypeId

SELECT 
GameId,
SUM(Cash) as [Total Cash Per GameId]
FROM UsersGames
GROUP BY GameId

USE SoftUni

SELECT 
MAX(Salary) AS [Max Salary],
DepartmentID
FROM Employees
GROUP BY DepartmentID
ORDER BY [Max Salary] DESC

USE Diablo

SELECT 
UserId,
MAX(Cash) as [Richest Players]
FROM UsersGames
GROUP BY UserId
ORDER BY [Richest Players] DESC

USE Geography

SELECT 
MountainId,
MAX(Elevation) AS [Hiest Peak in mountain]
FROM Peaks
GROUP BY MountainId
ORDER BY [Hiest Peak in mountain]

SELECT 
MAX(Elevation) AS [Hiest Peak]
FROM Peaks

SELECT 
MountainId,
MAX(Elevation) AS [Lowest Peak in mountain]
FROM Peaks
GROUP BY MountainId
ORDER BY [Lowest Peak in mountain]

SELECT 
MIN(Elevation) AS [Hiest Peak]
FROM Peaks

Use SoftUni

SELECT 
DepartmentID,
AVG(Salary) AS [Average Salary]
FROM Employees
GROUP BY DepartmentID 
ORDER BY [Average Salary] DESC

USE Diablo
SELECT AVG(Duration)
FROM Games

SELECT AVG(CAST(Duration AS float))
FROM Games

USE SoftUni 
SELECT 
DepartmentID,
SUM(Salary) AS [Total Salary]
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) >= 150000
ORDER BY [Total Salary] DESC

USE SoftUni

SELECT 
COUNT(EmployeeId) AS [People we hired],
DATEDIFF(MONTH, '1998-07-31', HireDate) AS [Mounts in buisness]
FROM Employees
WHERE DATEDIFF(MONTH, '1998-07-31', HireDate) >= 24 AND DATEDIFF( month ,'1998-07-31' ,HireDate) <= 36
GROUP BY DATEDIFF(MONTH, '1998-07-31', HireDate) 

SELECT 
FirstName, LastName, Name AS [Department Name]
FROM Employees, Departments
WHERE Name IN ('Sales', 'Marketing');