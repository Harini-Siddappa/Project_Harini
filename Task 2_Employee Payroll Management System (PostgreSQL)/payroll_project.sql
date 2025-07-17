DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
   EMPLOYEE_ID INT PRIMARY KEY,
    NAME TEXT NOT NULL,
    DEPARTMENT TEXT,
    EMAIL TEXT UNIQUE,
    PHONE_NO BIGINT,
    JOINING_DATE DATE,
    SALARY INT,
    BONUS INT,
    TAX_PERCENTAGE DECIMAL(5,2)
);


INSERT INTO employees (
    EMPLOYEE_ID, NAME, DEPARTMENT, EMAIL, PHONE_NO, JOINING_DATE, SALARY, BONUS, TAX_PERCENTAGE
) VALUES
(1, 'Ravi Kumar', 'IT', 'ravi.kumar@abcsolutions.com', 9876543001, '2023-01-10', 85000, 5000, 10),
(2, 'Sneha Reddy', 'HR', 'sneha.reddy@abcsolutions.com', 9876543002, '2022-06-15', 70000, 4000, 8),
(3, 'Amit Verma', 'Sales', 'amit.verma@abcsolutions.com', 9876543003, '2023-03-20', 65000, 3000, 9),
(4, 'Priya Mehta', 'Marketing', 'priya.mehta@abcsolutions.com', 9876543004, '2024-01-05', 65000, 2000, 7), 
(5, 'Deepak Singh', 'Finance', 'deepak.singh@abcsolutions.com', 9876543005, '2022-09-30', 91000, 8000, 12),
(6, 'Geeta Joshi', 'IT', 'geeta.joshi@abcsolutions.com', 9876543006, '2023-08-18', 88000, 7000, 11),
(7, 'Nikhil Sharma', 'Sales', 'nikhil.sharma@abcsolutions.com', 9876543007, '2023-11-25', 90000, 6000, 10),
(8, 'Meena Das', 'HR', 'meena.das@abcsolutions.com', 9876543008, '2022-12-10', 70000, 5000, 9), 
(9, 'Neeraj Kumar', 'IT', 'neeraj.kumar@abcsolutions.com', 9876543009, '2024-07-01', 95000, 8000, 10),  
(10, 'Ananya Jain', 'Finance', 'ananya.jain@abcsolutions.com', 9876543010, '2024-06-10', 98000, 7000, 9);


SELECT * FROM employees
ORDER BY SALARY DESC;

SELECT * FROM employees
WHERE (SALARY + BONUS) > 100000;

UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales';

SELECT EMPLOYEE_ID,
NAME, Round((SALARY + BONUS) * (1 - TAX_PERCENTAGE / 100),2) AS NET_SALARY
FROM employees;


SELECT DEPARTMENT,ROUND(AVG(SALARY), 2) AS AVERAGE_SALARY,
 MIN(SALARY) AS MIN_SALARY,
 MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;

SELECT * FROM employees
WHERE joining_date >= DATE '2024-12-31' - INTERVAL '6 months';

SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM employees
GROUP BY DEPARTMENT;

SELECT DEPARTMENT, ROUND(AVG(SALARY), 2) AS AVG_SALARY
FROM employees
GROUP BY DEPARTMENT
ORDER BY AVG_SALARY DESC;

SELECT *
FROM employees
WHERE SALARY IN (
    SELECT SALARY
    FROM employees
    GROUP BY SALARY
    HAVING COUNT(*) > 1
);


