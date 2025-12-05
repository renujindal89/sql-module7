create database sub_query;
use sub_query;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(10,2),
    manager_id INT,
    department_id INT
);

INSERT INTO employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES
(101, 'John', 'Doe', 'john.doe@email.com', '9876543210', '2022-01-15', 'IT_PROG', 60000.00, 201, 10),
(102, 'Emma', 'Stone', 'emma.stone@email.com', '9876501234', '2021-03-20', 'HR_MGR', 75000.00, 202, 20),
(103, 'Raj', 'Kumar', 'raj.kumar@email.com', '9988776655', '2023-07-11', 'FIN_CLRK', 45000.00, 202, 30),
(104, 'Neha', 'Sharma', 'neha.sharma@email.com', '8877665544', '2020-11-01', 'IT_PROG', 62000.00, 201, 10),
(105, 'Victor', 'Hunt', 'victor.hunt@email.com', '7788996655', '2019-08-25', 'SA_MAN', 82000.00, 203, 40),
(106, 'Sophia', 'Lee', 'sophia.lee@email.com', '6655443322', '2024-05-30', 'MK_REP', 38000.00, 204, 50);
select * from employees;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);
INSERT INTO departments (department_id, department_name, location)
VALUES
(10, 'IT', 'New York'),
(20, 'Human Resources', 'Chicago'),
(30, 'Finance', 'Boston'),
(40, 'Sales', 'New York'),
(50, 'Marketing', 'Dallas'),
(60, 'Operations', 'Chicago');
select * from departments;

-- type1
-- return Scalar  value
When a subquery returns a single value, or exactly one row and exactly one column, we call it a scalar subquery
Definition: Returns a single row with a single value.
Use Case: Typically used with comparison operators like =, <, >, etc.

1.Write an SQL query to display the names of employees who work in the IT department.
Use a subquery to find the department ID based on the department name.

SELECT first_name
FROM employees
WHERE department_id =  (SELECT department_id FROM departments WHERE department_name = 'it');

2. Multi-Row Subquery
Definition: Returns multiple rows.
Use Case: Used with operators like IN, ANY, or ALL.
Example:
-- -- Retrieve employees working in departments located in 'New York' 


SELECT first_name
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location = 'New York');

-- Retrieve employees working in departments located in 'New York' or 'Chicago'
SELECT first_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location IN ('New York', 'Chicago')
);

-- Find employees whose salary is greater than any employee in department 10
SELECT first_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 10
);

SELECT first_name, salary
FROM employees
WHERE salary > all (
    SELECT salary
    FROM employees
    WHERE department_id = 10
);


3. Multi-Column Subquery
Definition: Returns multiple columns (a set of rows with multiple values).
Use Case: Often used in WHERE or FROM clauses.
Example:
Sql
Find employees whose job_id and department_id match exactly the same combination as employee John.

SELECT first_name, job_id, department_id
FROM employees
WHERE (job_id, department_id) IN (
    SELECT job_id, department_id
    FROM employees
    WHERE first_name = 'John'
);
SELECT first_name, job_id, department_id
FROM employees
WHERE (job_id, department_id) IN (
    SELECT job_id, department_id
    FROM employees
    WHERE department_id=20
);


4. Correlated Subquery

Definition: A correlated subquery depends on the outer query.
It runs row-by-row for each record of the main query.
Example:

1.Find employees earning more than the average salary of their own department

SELECT first_name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees f
    WHERE f.department_id = e.department_id
);

2.Find employees who earn more than their manager
SELECT e.first_name, e.salary, e.manager_id
FROM employees e
WHERE e.salary > (
    SELECT m.salary
    FROM employees m
    WHERE m.employee_id = e.manager_id
);
3.Find highest paid employee in each department (Correlated + IN)
SELECT first_name, salary, department_id
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

5. Nested Subquery

Definition: A subquery within another subquery.
Use Case: Used for deeply complex queries.
Example:
Sql
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(50)
);

INSERT INTO locations (location_id, city) VALUES
(100, 'New York'),
(200, 'Chicago'),
(300, 'Boston');

CREATE TABLE departments1 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location_id INT
);

INSERT INTO departments1 (department_id, department_name, location_id) VALUES
(10, 'IT', 100),
(20, 'HR', 200),
(30, 'Finance', 300);

CREATE TABLE employees1(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    department_id INT
);

INSERT INTO employees1 (employee_id, first_name, department_id) VALUES
(1, 'John', 10),
(2, 'Emma', 20),
(3, 'Raj', 10),
(4, 'Neha', 30);

1.Find employees who work in the department located in New York.
But department location comes from locations table (assume structure):

employees → department_id
departments → department_id, location_id
locations → location_id, city


SELECT first_name
FROM employees1
WHERE department_id = (SELECT department_id FROM departments1 WHERE location_id = 
(SELECT location_id FROM locations WHERE city = 'New York'));



These subqueries enhance SQL's flexibility, allowing for efficient data retrieval and manipulation.














The following statement uses a subquery to find the employees who have the highest salary:
SELECT
  first_name,
  salary
FROM
  employees
WHERE
  salary = (
    SELECT
      MAX(salary)
    FROM
      employees
  );
  The following example uses a subquery to find employees with a salary greater than the average salary:
  SELECT
  first_name,
  salary
FROM
  employees
WHERE
  salary > (
    SELECT
      AVG(salary)
    FROM
      employees
  )
ORDER BY
  salary;
  the following query uses a subquery with the IN operator to find all employees with the job titles related to Sales:
  SELECT
  first_name,
  last_name
FROM
  employees
WHERE
  job_id IN (
    SELECT
      job_id
    FROM
      jobs
    WHERE
      job_title LIKE '%Sales%'
  );
  
  The following example uses a subquery in the SELECT clause to retrieve the first name, salary, and average salary of all employees:
  
  SELECT
  first_name,
  salary,
  (
    SELECT
      ROUND(AVG(salary),2) average_salary
    FROM
      employees
  )
FROM
  employees
ORDER BY
  salary;
  
  The following example shows how to use a subquery in the FROM clause:

SELECT
  ROUND(AVG(department_salary), 0) average_department_salary
FROM
  (
    SELECT
      department_id,
      SUM(salary) department_salary
    FROM
      employees
    GROUP BY
      department_id
  );
  
  The following example uses a subquery in the INNER JOIN clause of the outer query to 
  retrieve employees who earn above the company’s average salary:
  SELECT
  first_name,
  last_name,
  salary,
  s.avg_salary
FROM
  employees e
  INNER JOIN (
    SELECT
      ROUND(AVG(salary), 0) AS avg_salary
    FROM
      employees
  ) s ON e.salary > s.avg_salary
ORDER BY
  salary;