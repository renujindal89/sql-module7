create database self;
use self;


Employees & Managers — Self Join Example
Create Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT,
    salary INT,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

Insert Sample Data
INSERT INTO employees (emp_id, name, manager_id, salary) VALUES
(1, 'Rohan', 3, 50000),
(2, 'Meera', 3, 52000),
(3, 'Amit', NULL, 90000),
(4, 'Kunal', 2, 48000);

Find each employee’s manager
SELECT 
    e.name AS employee,
    m.name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;
    
    
    
    
    Customers in Same City — Self Join Example
Create Table
CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50)
);

Insert Data
INSERT INTO customers (cust_id, cust_name, city) VALUES
(1, 'John', 'Delhi'),
(2, 'Priya', 'Delhi'),
(3, 'Sameer', 'Mumbai'),
(4, 'Raj', 'Delhi');

List pairs of customers in the same city
SELECT 
    A.cust_name AS Customer1,
    B.cust_name AS Customer2,
    A.city
FROM customers A
JOIN customers B 
    ON A.city = B.city 
    AND A.cust_id <> B.cust_id;
    
    
    
    Students Having Same Group — Self Join Example
Create Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    group_id INT
);

Insert Data
INSERT INTO students (student_id, student_name, group_id) VALUES
(1, 'Arjun', 101),
(2, 'Ravi', 102),
(3, 'Reema', 101),
(4, 'Neha', 103);
    
    Students having the same group
    SELECT 
    s.student_name,
    s1.student_name AS partner_name,
    s.group_id
FROM students s
JOIN students s1
    ON s.group_id = s1.group_id
    AND s.student_id <> s1.student_id;
    
    
    CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);INSERT INTO employees (emp_id, name, salary) VALUES
(1, 'Rohan', 50000),
(2, 'Meera', 65000),
(3, 'Amit', 90000),
(4, 'Kunal', 45000),
(5, 'Sara', 75000);
    
    Find employees earning higher than others in the same table
SELECT 
    e1.name AS employee,
    e1.salary,
    e2.name AS higher_salary_employee,
    e2.salary AS higher_salary
FROM employees e1
JOIN employees e2
    ON e2.salary > e1.salary;