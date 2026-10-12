# E-Commerce Order Management System

A relational database project built with **MySQL** to manage the core data and reporting needs of an e-commerce store. It models product categories, inventory, customers, orders, order items, payments, and shipping, then demonstrates SQL techniques for retrieving, updating, joining, and analyzing this data.

This repository is designed as a practical SQL learning project and portfolio example. It uses sample records and does not connect to a live storefront, payment gateway, or shipping provider.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Database Design](#database-design)
- [Entity Relationships](#entity-relationships)
- [SQL Skills Demonstrated](#sql-skills-demonstrated)
- [Reports and Business Questions](#reports-and-business-questions)
- [Getting Started](#getting-started)
- [Running the SQL Script](#running-the-sql-script)
- [Important Script Behavior](#important-script-behavior)
- [Possible Improvements](#possible-improvements)
- [Project Structure](#project-structure)
- [Learning Outcomes](#learning-outcomes)

---

## Project Overview

The project creates a database named `ecommerce_management` and defines seven related tables. Sample data is inserted so that queries can demonstrate common e-commerce reporting scenarios, including order status tracking, inventory availability, customer order history, payment status, and shipping progress.

The SQL file contains both data-definition statements (database and table creation) and data-manipulation/query statements. It also includes examples using aggregate functions, joins, subqueries, date and string functions, conditional logic, and window functions.

## Objectives

- Design a relational schema for common e-commerce entities.
- Connect related records with primary and foreign keys.
- Store product, customer, order, payment, and shipping information.
- Practice adding, updating, deleting, and retrieving data.
- Write queries that summarize sales and order activity.
- Use SQL functions to format, classify, rank, and analyze records.

## Features

- **Category management:** organize products by category.
- **Product and inventory records:** store prices, stock quantities, and product-added dates.
- **Customer records:** store names, email addresses, phone numbers, addresses, and registration dates.
- **Order tracking:** record order dates, total amounts, and statuses.
- **Order line items:** associate products and quantities with orders.
- **Payment tracking:** record payment dates, methods, and statuses.
- **Shipping tracking:** record shipping dates, delivery dates, and shipping statuses.
- **Inventory update example:** reduce the stock quantity of a product.
- **Data cleanup example:** delete payment records for qualifying old cancelled orders.
- **Analytical queries:** calculate totals, averages, rankings, cumulative values, and classifications.

## Technology Stack

| Technology | Usage |
|---|---|
| MySQL | Relational database and SQL execution |
| SQL | Schema creation, sample data, data changes, and reporting |
| MySQL Workbench or another MySQL client | Optional graphical interface for running the script |

**Version recommendation:** MySQL 8.0 or later. The script uses window functions such as `RANK()` and `COUNT() OVER`, which require a MySQL version that supports window functions.

## Database Design

The script creates the following tables:

| Table | Important columns | Purpose |
|---|---|---|
| `Categories` | `category_id`, `category_name` | Stores the available product categories. |
| `Products` | `product_id`, `name`, `category_id`, `price`, `stock_quantity`, `added_date` | Stores product details, pricing, inventory, and category reference. |
| `Customers` | `customer_id`, `name`, `email`, `phone_number`, `address`, `registration_date` | Stores customer contact and registration information. |
| `Orders` | `order_id`, `customer_id`, `order_date`, `total_amount`, `status` | Stores order-level information and current order status. |
| `Order_Items` | `order_item_id`, `order_id`, `product_id`, `quantity`, `subtotal` | Stores the products and quantities included in each order. |
| `Payments` | `payment_id`, `order_id`, `payment_date`, `payment_method`, `payment_status` | Stores payment details associated with orders. |
| `Shipping` | `shipping_id`, `order_id`, `shipping_date`, `delivery_date`, `shipping_status` | Stores shipping and delivery information. |

### Key fields and allowed values

- Primary identifiers use `INT PRIMARY KEY AUTO_INCREMENT`.
- Product prices and monetary amounts use `DECIMAL(10, 2)`.
- Order status values: `Pending`, `Shipped`, `Delivered`, `Cancelled`.
- Payment methods: `Credit Card`, `PayPal`, `UPI`.
- Payment status values: `Paid`, `Pending`, `Failed`.
- Shipping status values: `Dispatched`, `In Transit`, `Delivered`.
- `Customers.email` can contain `NULL`, which is used in one sample record to demonstrate missing-value handling.
- A shipping `delivery_date` can be `NULL` while an order is still in transit.

## Entity Relationships

The foreign keys establish these relationships:

1. **Categories → Products:** `Products.category_id` references `Categories.category_id`.
2. **Customers → Orders:** `Orders.customer_id` references `Customers.customer_id`.
3. **Orders → Order_Items:** `Order_Items.order_id` references `Orders.order_id`.
4. **Products → Order_Items:** `Order_Items.product_id` references `Products.product_id`.
5. **Orders → Payments:** `Payments.order_id` references `Orders.order_id`.
6. **Orders → Shipping:** `Shipping.order_id` references `Orders.order_id`.

Conceptually, a category can contain multiple products, a customer can place multiple orders, and an order can contain multiple order items. Payment and shipping records are associated with orders through their order IDs.

## SQL Skills Demonstrated

The supplied SQL script demonstrates the following concepts.

### 1. Database and table creation

- `CREATE DATABASE IF NOT EXISTS`
- `USE`
- `CREATE TABLE`
- Primary keys, auto-increment identifiers, foreign keys, and `ENUM` columns

### 2. Data manipulation

- `INSERT INTO` to add sample and additional records
- `UPDATE` to change a product's stock quantity
- `DELETE` to remove payment records matching the script's criteria

### 3. Filtering and sorting

- `WHERE` conditions
- Comparisons and logical conditions
- `ORDER BY` for ascending or descending sorting
- `LIMIT` to restrict result counts
- `IN`, `NOT IN`, and `IS NULL` checks

### 4. Aggregation and grouping

- `COUNT()` to count records
- `SUM()` to calculate totals
- `AVG()` to calculate averages
- `GROUP BY` to group records
- `HAVING` to filter grouped results

### 5. Joins

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- Joining customers to orders, products to categories, and products to order items
- Identifying records with no related row through outer joins

### 6. Subqueries and set operations

- Subqueries used with `IN`
- A subquery to identify a high-spending customer
- `UNION` to combine query results

### 7. Date and string functions

- `CURDATE()` and `DATE_SUB()` for date-based conditions
- `MONTH()` and `YEAR()` for date grouping/filtering
- `DATEDIFF()` for delivery-duration calculations
- `DATE_FORMAT()` for readable date output and monthly grouping
- `UPPER()` and `TRIM()` for string transformations
- `COALESCE()` to provide a fallback for missing email or aggregate values

### 8. Conditional logic and window functions

- `CASE` to assign customer loyalty labels and product sales labels
- `RANK()` to rank customers by spending
- `SUM() OVER(...)` to calculate cumulative monthly revenue
- `COUNT() OVER(...)` to calculate a running order count

## Reports and Business Questions

The script includes queries that explore questions such as:

- Which orders were placed within the last six months?
- Which products have the highest prices?
- Which customers have placed more than three orders?
- Which orders have a pending order status but a paid payment status?
- Which products currently have stock available?
- How many orders has each customer placed?
- What is the total subtotal represented by order items for each product category?
- What is the sum and average of recorded order totals?
- Which product has the highest total quantity in the order-item records?
- Which orders do not have a corresponding shipping record?
- Which products have never appeared in `Order_Items`?
- How long did completed shipments take, in days?
- How does customer spending rank when cancelled orders are excluded?
- What are the monthly order totals and cumulative monthly revenue?
- What loyalty label is assigned to each customer based on the script's thresholds?
- What sales label is assigned to each product based on recorded quantities?

These are examples of query capabilities in the SQL file; they are not a live dashboard or automatically refreshed business report.

## Getting Started

### Prerequisites

1. Install MySQL Server.
2. Install MySQL Workbench or have access to another MySQL client.
3. Save the supplied SQL file in an accessible folder.

### Run with MySQL Workbench

1. Open MySQL Workbench and connect to your local or remote MySQL server.
2. Select **File → Open SQL Script** and open `E-Commerce Order Management System.sql`.
3. Review the script before execution, especially the `UPDATE` and `DELETE` statements.
4. Execute the script.
5. Refresh the Schemas panel and look for `ecommerce_management`.
6. Expand the database's tables to inspect the data, or run additional `SELECT` queries.

### Run from the command line

Save the SQL file locally, open a terminal in its folder, and run:

```bash
mysql -u YOUR_USERNAME -p < "E-Commerce Order Management System.sql"
```

Replace `YOUR_USERNAME` with your MySQL username. Enter the password when prompted. The MySQL client must be installed and available in your terminal's PATH.

### Verify the database

After the script runs, you can use these checks:

```sql
USE ecommerce_management;

SHOW TABLES;

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
SELECT * FROM Payments;
SELECT * FROM Shipping;
```

## Important Script Behavior

Please read these details before running or re-running the script:

- **The script changes data.** It includes an inventory `UPDATE` and a conditional `DELETE` from `Payments`. Use a test database if you need to preserve existing data.
- **Re-running may fail.** The database creation uses `IF NOT EXISTS`, but the table definitions do not. If the tables already exist, their `CREATE TABLE` statements can fail.
- **Sample data is illustrative.** Customer, product, order, payment, and shipping records are sample records, not production information.
- **Revenue definitions vary.** Some totals use `Orders.total_amount`, while category totals use `Order_Items.subtotal`. These values measure different things and should not automatically be treated as equivalent.
- **Order status matters.** A sum across all orders can include cancelled or pending orders unless the query filters those statuses.
- **Sales labels use fixed thresholds.** The `CASE` expression labels products using quantity thresholds in the script. The labels do not automatically represent statistically defined best sellers.
- **No live integrations are included.** The database does not process real payments, place orders on a website, send shipping updates, or synchronize inventory with an external service.

## Possible Improvements

The current SQL file is a useful learning foundation. Potential next steps include:

- Add `NOT NULL`, `UNIQUE`, `CHECK`, and default constraints where appropriate.
- Add indexes to frequently queried foreign keys and reporting columns.
- Define whether each order can have one or multiple payment and shipping records, and enforce that rule if needed.
- Add a dedicated inventory transaction table to track stock changes over time.
- Improve revenue reports by defining whether cancelled, pending, refunded, or failed-payment orders should be included.
- Add views for frequently used reports.
- Add stored procedures or triggers for selected order and stock workflows.
- Add a separate test script with expected query results.
- Document the business rules for order totals, subtotals, discounts, taxes, and shipping charges.

These are recommendations for future development; they are not features already implemented in the supplied script.

## Project Structure

```text
.
├── E-Commerce Order Management System.sql
└── README.md
```

Keep the README and SQL script in the same repository so users can understand the project before running the database setup.

## Learning Outcomes

After working through this project, a learner can practice:

- Designing a relational schema with linked entities
- Defining primary keys and foreign key constraints
- Inserting and maintaining sample records
- Writing joins, grouped queries, and nested queries
- Applying common date and string functions
- Handling missing values
- Using conditional expressions for simple classifications
- Applying MySQL window functions for rankings and running totals
- Considering data quality, rerun safety, and reporting assumptions

---

**Project type:** SQL / Database Management  
**Database:** MySQL  
**Level:** Beginner to intermediate  
**Use case:** E-commerce order and inventory data practice
