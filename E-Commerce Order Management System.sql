CREATE DATABASE IF NOT EXISTS ecommerce_management;
USE ecommerce_management;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    added_date DATE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(150),
    registration_date DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method ENUM('Credit Card', 'PayPal', 'UPI'),
    payment_status ENUM('Paid', 'Pending', 'Failed'),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipping_date DATE,
    delivery_date DATE,
    shipping_status ENUM('Dispatched', 'In Transit', 'Delivered'),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Sports'),
(2, 'Footwear'),
(3, 'Groceries'),
(4, 'Stationery');

INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date) VALUES
(1, 'Cricket Bat', 1, 1299.00, 25, '2026-02-10'),
(2, 'Running Shoes', 2, 2499.00, 15, '2026-03-01'),
(3, 'Organic Honey', 3, 450.00, 40, '2026-02-15'),
(4, 'Formal Shirt', 1, 899.00, 0, '2026-03-05'),
(5, 'Mixer Grinder', 3, 2999.00, 10, '2026-01-20'),
(6, 'Drawing Sketchbook', 4, 199.00, 70, '2026-01-12'),
(7, 'Smart Band', 1, 1599.00, 30, '2026-03-12');

INSERT INTO Customers (customer_id, name, email, phone_number, address, registration_date) VALUES
(1, 'Manish Kumar', 'manish@email.com', '9123456780', 'Mumbai', '2022-04-12'),
(2, 'Deepika Sharma', 'deepika@email.com', '9123456781', 'Delhi', '2024-01-10'),
(3, 'Aakash Gupta', NULL, '9123456782', 'Pune', '2023-09-15'),
(4, 'Pooja Tiwari', 'pooja@email.com', '9123456783', 'Nagpur', '2021-03-22'),
(5, 'Suresh Rao', 'suresh@email.com', '9123456784', 'Bangalore', '2025-02-01');

INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2026-05-05', 2500.00, 'Delivered'),
(2, 1, '2026-06-10', 4500.00, 'Pending'),
(3, 2, '2026-07-01', 12000.00, 'Shipped'),
(4, 2, '2026-07-18', 8500.00, 'Pending'),
(5, 3, '2026-04-11', 9500.00, 'Delivered'),
(6, 4, '2026-01-15', 30000.00, 'Delivered'),
(7, 4, '2026-02-20', 15000.00, 'Delivered'),
(8, 5, '2026-05-12', 6000.00, 'Delivered'),
(9, 5, '2026-05-25', 5000.00, 'Delivered'),
(10, 5, '2026-06-02', 7500.00, 'Pending'),
(11, 5, '2026-06-20', 4000.00, 'Shipped'),
(12, 1, '2026-01-02', 1500.00, 'Cancelled');

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 1, 1299.00),
(2, 1, 3, 2, 900.00),
(3, 2, 2, 1, 2499.00),
(4, 3, 5, 3, 8997.00),
(5, 3, 6, 5, 995.00),
(6, 4, 1, 2, 2598.00),
(7, 5, 2, 2, 4998.00),
(8, 5, 6, 4, 796.00),
(9, 6, 1, 4, 5196.00),
(10, 6, 5, 3, 8997.00),
(11, 7, 3, 10, 4500.00),
(12, 7, 6, 15, 2985.00),
(13, 8, 1, 3, 3897.00),
(14, 9, 2, 2, 4998.00),
(15, 10, 5, 2, 5998.00),
(16, 11, 6, 10, 1990.00);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status) VALUES
(1, 1, '2026-05-06', 'UPI', 'Paid'),
(2, 2, '2026-06-11', 'Credit Card', 'Paid'),
(3, 3, '2026-07-02', 'PayPal', 'Paid'),
(4, 4, '2026-07-19', 'UPI', 'Pending'),
(5, 5, '2026-04-12', 'Credit Card', 'Paid'),
(6, 6, '2026-01-16', 'UPI', 'Paid'),
(7, 7, '2026-02-21', 'PayPal', 'Paid'),
(8, 8, '2026-05-13', 'Credit Card', 'Paid'),
(9, 9, '2026-05-26', 'UPI', 'Paid'),
(10, 10, '2026-06-03', 'PayPal', 'Failed'),
(11, 11, '2026-06-21', 'UPI', 'Paid'),
(12, 12, '2026-01-03', 'UPI', 'Failed');

INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_status) VALUES
(1, 1, '2026-05-07', '2026-05-10', 'Delivered'),
(2, 3, '2026-07-03', '2026-07-07', 'Delivered'),
(3, 5, '2026-04-13', '2026-04-17', 'Delivered'),
(4, 6, '2026-01-17', '2026-01-21', 'Delivered'),
(5, 7, '2026-02-22', '2026-02-26', 'Delivered'),
(6, 8, '2026-05-14', '2026-05-18', 'Delivered'),
(7, 9, '2026-05-27', '2026-05-30', 'Delivered'),
(8, 11, '2026-06-22', NULL, 'In Transit');

INSERT INTO Products (name, category_id, price, stock_quantity, added_date)
VALUES ('Badminton Racket', 1, 1199.00, 20, CURDATE());

INSERT INTO Customers (name, email, phone_number, address, registration_date)
VALUES ('Kirti Joshi', 'kirti@email.com', '9123456785', 'Indore', CURDATE());

INSERT INTO Orders (customer_id, order_date, total_amount, status)
VALUES (2, CURDATE(), 1800.00, 'Pending');

UPDATE Products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 1;

DELETE FROM Payments
WHERE order_id IN (
    SELECT order_id FROM Orders
    WHERE status = 'Cancelled'
      AND order_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY)
);

SELECT * FROM Orders 
WHERE order_date >= DATE_SUB(CURDATE() , INTERVAL 6 MONTH);

SELECT * FROM Products
ORDER BY price DESC
LIMIT 5;

SELECT customer_id , COUNT(*) AS total_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(*) > 3;

SELECT o.order_id , o.customer_id , o.order_date , o.total_amount , o.status , p.payment_status
FROM Orders o
JOIN Payments p
ON o.order_id = p.order_id
WHERE status = "Pending" AND p.payment_status = "Paid";

SELECT * FROM Products 
WHERE NOT stock_quantity = 0;

SELECT c.* , o.total_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id 
WHERE YEAR(c.registration_date) > 2022 OR o.total_amount > 10000;

SELECT * FROM Products
ORDER BY price DESC;

SELECT c.name , COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name ;

SELECT cat.category_name , SUM(oi.subtotal) AS total_revenue
FROM Categories cat
JOIN Products p ON cat.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY cat.category_name;

SELECT SUM(total_amount) AS total_revenue
FROM Orders;

SELECT p.name , SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT AVG(total_amount) AS average_order_value
FROM Orders;

SELECT p.name , c.category_name
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;

SELECT o.* , c.* 
FROM Orders o
LEFT JOIN Customers c
ON o.customer_id = c.customer_id;

SELECT o.order_id , o.status , s.shipping_status
FROM Shipping s
RIGHT JOIN Orders o
ON o.order_id = s.order_id
WHERE s.shipping_id IS NULL;

SELECT c.customer_id , c.name 
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT c.customer_id , c.name 
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id
WHERE order_id IS NULL;

SELECT *
FROM Orders 
WHERE customer_id IN (SELECT customer_id FROM Customers WHERE registration_date > "2022-12-31");

SELECT customer_id , name 
FROM Customers
WHERE customer_id = (SELECT o.customer_id FROM Orders o WHERE o.status <> "Cancelled" 
GROUP BY o.customer_id ORDER BY SUM(o.total_amount) DESC LIMIT 1);

SELECT * FROM Products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Order_Items);

SELECT MONTH(order_date) AS order_month , COUNT(*) AS total_orders
FROM Orders
GROUP BY MONTH(order_date) 
ORDER BY order_month;

SELECT order_id , shipping_date , delivery_date , DATEDIFF(delivery_date , shipping_date) AS delivery_days
FROM Shipping
WHERE delivery_date IS NOT NULL;

SELECT order_id , DATE_FORMAT(order_date , "%d-%m-%Y") AS formatted_order_date
FROM Orders ;

SELECT product_id , UPPER(name) AS name_upper FROM Products;

SELECT customer_id , TRIM(name) AS trimmed_name FROM Customers;

SELECT customer_id , COALESCE(email , "Not Provided") AS email
FROM Customers;

SELECT c.customer_id , c.name , SUM(o.total_amount) AS total_spent ,
RANK() OVER(ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id 
WHERE o.status <> "Cancelled"
GROUP BY c.customer_id , c.name;

SELECT order_month , monthly_revenue , 
SUM(monthly_revenue) OVER(ORDER BY order_month) AS cumulative_revenue
FROM ( SELECT DATE_FORMAT(order_date , "%Y-%m") AS order_month ,
SUM(total_amount) AS monthly_revenue
FROM Orders 
WHERE status <> "Cancelled"
GROUP BY DATE_FORMAT(order_date , "%Y-%m"))
AS monthly_totals
ORDER BY order_month;

SELECT order_id , order_date , 
COUNT(*) OVER(ORDER BY order_date , order_id) AS running_order_count 
FROM Orders 
ORDER BY order_date , order_id ;

SELECT c.customer_id , c.name , COALESCE(SUM(o.total_amount) , 0) AS total_spent,
CASE 
WHEN COALESCE(SUM(o.total_amount) , 0 ) > 50000 THEN "Gold"
WHEN COALESCE(SUM(o.total_amount) , 0 ) BETWEEN 20000 AND 50000 THEN "Silver"
ELSE "Bronze"
END AS Loyalty_Status 
FROM Customers c
LEFT JOIN Orders o 
ON c.customer_id = o.customer_id
AND o.status <> "Cancelled"
GROUP BY c.customer_id , c.name;

SELECT p.product_id , p.name , COALESCE(SUM(oi.quantity) , 0 ) AS unit_sold,
CASE 
WHEN COALESCE(SUM(oi.quantity) , 0) > 500 THEN "Best Seller"
WHEN COALESCE(SUM(oi.quantity) , 0) BETWEEN 200 AND 500 THEN "Popular"
ELSE "Regular"
END AS product_category
FROM Products p
LEFT JOIN Order_Items oi 
ON p.product_id = oi.product_id
GROUP BY p.product_id , p.name;