CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission DECIMAL(4,2)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James', 'New York', 0.15),
(5002, 'Alex', 'London', 0.13),
(5003, 'Micheal', 'New York', 0.14),
(5004, 'Robert', 'Paris', 0.12),
(5005, 'David', 'Rome', 0.11);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3001, 'Brad', 'New York', 100, 5001),
(3002, 'Sofia', 'Rome', 200, 5005),
(3003, 'Liam', 'Paris', 200, 5002),
(3004, 'Emma', 'London', 300, 5002),
(3005, 'Olivia', 'New York', NULL, 5003),
(3006, 'Noah', 'London', 100, 5004);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(7001, 1500.00, '2022-10-05', 3001, 5001),
(7002, 65.26, '2022-10-06', 3002, 5005),
(7003, 2400.00, '2022-10-10', 3003, 5002),
(7004, 600.00, '2022-10-15', 3004, 5002),
(7005, 800.00, '2022-10-17', 3001, 5001),
(7006, 75.00, '2022-10-18', 3005, 5003),
(7007, 150.00, '2022-10-20', 3006, 5004);

-- Task 1
SELECT s.name AS Salesman, c.cust_name AS Customer, s.city
FROM salesman s
JOIN customer c ON s.city = c.city;

-- Task 2
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;


