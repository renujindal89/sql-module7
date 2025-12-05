
CREATE TABLE Salesmen (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);
INSERT INTO Salesmen (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT
);
INSERT INTO Customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);

CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006);

1-From the following tables write a SQL query to find the salesperson and customer who reside in the same city.
 Return Salesman, cust_name and city.
ans-SELECT salesman.name AS "Salesman", customer.cust_name, customer.city
FROM salesman, customer
WHERE salesman.city = customer.city;

qq2-From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000. 
Return ord_no, purch_amt, cust_name, city.
ans--SELECT  a.ord_no, a.purch_amt,
        b.cust_name, b.city 
FROM orders a, customer b 

WHERE a.customer_id = b.customer_id 
AND a.purch_amt BETWEEN 500 AND 2000;

q3-From the following tables write a SQL query to find the salesperson(s) and the customer(s) he represents.
 Return Customer Name, city, Salesman, commission.
ans-SELECT a.cust_name AS "Customer Name", 
       a.city, 
       b.name AS "Salesman", 
       b.commission 

FROM customer a 

INNER JOIN salesman b 
ON a.salesman_id = b.salesman_id;

q4-From the following tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company. 
Return Customer Name, customer city, Salesman, commission.
ans--SELECT a.cust_name AS "Customer Name", 
       a.city, 
       b.name AS "Salesman", 
       b.commission 

FROM customer a 

INNER JOIN salesman b 
ON a.salesman_id = b.salesman_id 

WHERE b.commission > 0.12;

q5-From the following tables write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. 
Return Customer Name, customer city, Salesman, salesman city, commission. 
ans--SELECT a.cust_name AS "Customer Name", 
       a.city, 
       b.name AS "Salesman", 
       b.city, b.commission  
FROM customer a  

INNER JOIN salesman b  
ON a.salesman_id = b.salesman_id 
WHERE b.commission > 0.12 
AND a.city <> b.city;

q6-From the following tables write a SQL query to find the details of an order.
 Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
ans--SELECT a.ord_no, a.ord_date, a.purch_amt,
       b.cust_name AS "Customer Name", b.grade, 
       c.name AS "Salesman", c.commission 
FROM orders a 
-- Performing an inner join with 'customer' table ('b') based on customer_id
INNER JOIN customer b 
ON a.customer_id = b.customer_id 
-- Performing another inner join with 'salesman' table ('c') based on salesman_id
INNER JOIN salesman c 
ON a.salesman_id = c.salesman_id;

q7From the following tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city.
 The results should be sorted by ascending customer_id.  
ans-SELECT a.cust_name, a.city, a.grade, 
       b.name AS "Salesman", b.city 
-- Specifying the tables to retrieve data from ('customer' as 'a' and 'salesman' as 'b')
FROM customer a 
-- Performing a left join based on the salesman_id, including unmatched rows from 'customer'
LEFT JOIN salesman b 
ON a.salesman_id = b.salesman_id 
-- Sorting the result set by customer_id in ascending order
ORDER BY a.customer_id;

q8-From the following tables write a SQL query to find those customers with a grade less than 300.
 Return cust_name, customer city, grade, Salesman, salesmancity. 
The result should be ordered by ascending customer_id.  SQL database training
ans--SELECT a.cust_name, a.city, a.grade, 
       b.name AS "Salesman", b.city 
-- Specifying the tables to retrieve data from ('customer' as 'a' and 'salesman' as 'b')
FROM customer a 
-- Performing a left outer join based on the salesman_id, including unmatched rows from 'customer'
LEFT OUTER JOIN salesman b 
ON a.salesman_id = b.salesman_id 
-- Filtering the results based on the condition that 'grade' is less than 300
WHERE a.grade < 300 
-- Sorting the result set by customer_id in ascending order
ORDER BY a.customer_id;

q9-Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according 
to the order date to determine whether any of the existing customers have placed an order or not.
ans--SELECT a.cust_name, a.city, b.ord_no,
       b.ord_date, b.purch_amt AS "Order Amount", 
       c.name, c.commission 
-- Specifying the tables to retrieve data from ('customer' as 'a', 'orders' as 'b', and 'salesman' as 'c')
FROM customer a 
-- Performing a left outer join based on the customer_id, including unmatched rows from 'customer'
LEFT OUTER JOIN orders b 
ON a.customer_id = b.customer_id 
-- Performing another left outer join with the result of the previous join and the 'salesman' table based on salesman_id
LEFT OUTER JOIN salesman c 
ON c.salesman_id = b.salesman_id;
