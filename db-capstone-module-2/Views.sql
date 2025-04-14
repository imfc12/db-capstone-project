-- Task 1, create OrdersView
CREATE VIEW OrdersView AS
SELECT orderID, total_cost FROM orders WHERE total_cost > 100;
SELECT * FROM OrdersView;


-- Task 2
SELECT c.customerID, c.customer_name, o.orderID, o.total_cost
FROM customers AS c
INNER JOIN orders as o
ON c.customerID = o.customerID;

