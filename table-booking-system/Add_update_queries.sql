-- Create SQL queries to add and update bookings
-- Task 1
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN inputBookingID INT,
    IN inputCustomerID INT,
    IN inputBookingDate DATE,
    IN inputTableNumber INT
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (inputBookingID, inputCustomerID, inputBookingDate, inputTableNumber);
END //
DELIMITER ;
CALL AddBooking(101, 1, '2025-04-20', 5);

-- Task 2
DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN inputBookingID INT,
    IN newBookingDate DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = newBookingDate
    WHERE BookingID = inputBookingID;
END //
DELIMITER ;
CALL UpdateBooking(101, '2025-04-25');

-- Task 3
DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN inputBookingID INT
)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = inputBookingID;
END //
DELIMITER ;
CALL CancelBooking(101);










