-- optimised queries

-- Task 1
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS MaxQuantity
    FROM Orders;
END //
DELIMITER;


-- Task 2
PREPARE GetOrderDetail FROM
'SELECT OrderID, quantity, order_cost FROM Orders WHERE CustomerID = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
DEALLOCATE PREPARE GetOrderDetail;



-- Task 3
DELIMITER //
CREATE PROCEDURE CancelOrder(IN inputOrderID INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = inputOrderID;
END //
DELIMITER;

CALL CancelOrder(123);

