  
select 
	DepartmentID,
	SUM(Salary) AS totalSalaryPerDepartment
from Employees as e
GrouP BY DepartmentID

--01.Records Count
--use Gringotts
	SELECT COUNT(Id) FROM WizzardDeposits

--02.Longest Magic Wand
SELECT 
	MAX(MagicWandSize) AS LongestMagicWand 
FROM WizzardDeposits

--03. Longest Magic Wand per Deposit Groups
SELECT 
	DepositGroup,
	MAX(MagicWandSize) AS LongestMagicWand 
FROM WizzardDeposits
GROUP BY DepositGroup

--04. Smallest Deposit Group per Magic Wand Size
SELECT 
	DepositGroup
	FROM WizzardDeposits
GROUP BY DepositGroup
HAVING AVG(MagicWandSize) = 
	(
	SELECT TOP (1)
	AVG(MagicWandSize) AS AvgMagicWandSize
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize)
	);
	
--05.Deposits Sum
SELECT 
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
 FROM WizzardDeposits
 GROUP BY DepositGroup

--06. Deposits Sum for Ollivander Family
 SELECT 
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
 FROM WizzardDeposits
 WHERE MagicWandCreator = 'Ollivander family'
 GROUP BY DepositGroup
 
--07. Deposits Filter
 SELECT 
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
 FROM WizzardDeposits
 WHERE MagicWandCreator = 'Ollivander family'
 GROUP BY DepositGroup
 HAVING SUM(DepositAmount) < 150000
 ORDEr BY SUM(DepositAmount) DESC

 --08. Deposit Charge
SELECT 
	wd.DepositGroup, 
	wd.MagicWandCreator,
	MIN(wd.DepositCharge) AS MinDepositCharge
FROM WizzardDeposits AS wd
GROUP BY wd.DepositGroup, wd.MagicWandCreator

--09. Age Groups
SELECT
CASE
	WHEN (Age >= 0 AND Age <= 10)
	THEN '[0-10]'
	WHEN (Age >= 11 AND Age <= 20)
	THEN '[11-20]'
	WHEN (Age >= 21 AND Age <= 30)
	THEN '[21-30]'
	WHEN (Age >= 31 AND Age <= 40)
	THEN '[31-40]'
	WHEN (Age >= 41 AND Age <= 50)
	THEN '[41-50]'
	WHEN (Age >= 51 AND Age <= 60)
	THEN '[51-60]'
	ELSE '[61+]'
END AS AgeGroup,
	COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY 
CASE
	WHEN (Age >= 0 AND Age <= 10)
	THEN '[0-10]'
	WHEN (Age >= 11 AND Age <= 20)
	THEN '[11-20]'
	WHEN (Age >= 21 AND Age <= 30)
	THEN '[21-30]'
	WHEN (Age >= 31 AND Age <= 40)
	THEN '[31-40]'
	WHEN (Age >= 41 AND Age <= 50)
	THEN '[41-50]'
	WHEN (Age >= 51 AND Age <= 60)
	THEN '[51-60]'
	ELSE '[61+]'
END

--10. First Letter
SELECT 
	LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits AS wd
WHERE wd.DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)
ORDER BY LEFT(FirstName, 1) 

--11. Average Interest
SELECT
	wd.DepositGroup,
	wd.IsDepositExpired,
	AVG(wd.DepositInterest) AS AverageInterest
FROM WizzardDeposits AS wd
WHERE wd.DepositStartDate > '01-01-1985'
GROUP BY wd.IsDepositExpired, wd.DepositGroup
ORDER BY DepositGroup DESC, wd.IsDepositExpired

--12. Rich Wizard, Poor Wizard
SELECT SUM(wizardDep.Difference) FROM 
(
	SELECT 
	FirstName AS [Host Wizard],
	DepositAmount [Host Wizard Deposit],
	LEAD(FirstName) OVER (ORDER BY Id) AS [Guest Wizard],
	LEAD(DepositAmount) OVER (ORDER BY Id) AS [Guest Wizard Deposit],
	(DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id)) AS [Difference]
	FROM WizzardDeposits
) AS wizardDep

--13. Departments Total Salaries
--USE Softuni;
SELECT
	DepartmentId,
	SUM(Salary) AS TotalSalary
FROM Employees 
GROUP BY DepartmentID
ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT
	DepartmentId,
	MIN(Salary) AS TotalSalary
FROM Employees 
WHERE DepartmentID IN (2,5,7) AND HireDate > '01-01-2000'
GROUP BY DepartmentID

--15. Employees Average Salaries
SELECT 
	*
INTO EmployeesNewTable
FROM Employees
WHERE Salary > 30000;

DELETE FROM EmployeesNewTable
WHERE ManagerID = 42;

UPDATE EmployeesNewTable
SET Salary = Salary + 5000
WHERE DepartmentID = 1;

SELECT
DepartmentID,
AVG(Salary) AS AverageSalary
FROM EmployeesNewTable
WHERE Salary > 30000 
GROUP BY DepartmentID

--16. Employees Maximum Salaries
SELECT
	DepartmentID,
	MaxSalary = MAX(Salary) 
FROM Employees
GROUP BY DepartmentID
HAVING (MAX(Salary) NOT BETWEEN 30000 AND 70000)

--17. Employees Count Salaries
SELECT
	Count(e.Salary) AS [Count] 
FROM Employees AS e
WHERE(ManagerID IS NULL)

--18. 3rd Highest Salary
SELECT
SalaryDep.DepartmentID,
SalaryDep.ThirdHighesthSalary FROM 
(
	SELECT
	DepartmentID,
	MAX(Salary) AS ThirdHighesthSalary,
	DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS [Rank]
	FROM Employees
	GROUP BY DepartmentID, Salary
) AS SalaryDep
WHERE SalaryDep.Rank = 3;

--19. **Salary Challenge
SELECT TOP 10
	e.FirstName,
	e.LastName,
	e.DepartmentID
FROM Employees AS e
WHERE e.Salary > 
				(
					select
						AVG(Salary) AS AvgSalary
					from Employees AS ee
					WHERE ee.DepartmentID = e.DepartmentID
				) 
ORDER BY e.DepartmentID
