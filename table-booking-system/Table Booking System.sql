-- Table Booking System
-- Task 1
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID)
VALUES (1, '2022-10-10', 5, 1), (2, '2022-11-12', 3, 3), 
(3, '2022-10-11', 2, 2), (4, '2022-10-13', 2, 1);

-- Task 2
DELIMITER //
CREATE PROCEDURE CheckTableAvailability(IN inputDate DATE, IN inputTableNumber INT)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Bookings
        WHERE BookingDate = inputDate AND TableNumber = inputTableNumber
    ) THEN
        SELECT CONCAT('Table ', inputTableNumber, ' is already booked') AS 'Booking status';
    ELSE
        SELECT CONCAT('Table ', inputTableNumber, ' is not booked') AS 'Booking status';
    END IF;
END //
DELIMITER ;
CALL CheckTableAvailability('2025-04-15', 5);



-- Task 3
DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN inputDate DATE,
    IN inputTableNumber INT
)
BEGIN
    DECLARE bookingExists INT;
    DECLARE defaultCustomerID INT DEFAULT 1; -- Replace with desired logic or ID

    START TRANSACTION;
    -- Check if a booking already exists for the given date and table
    SELECT COUNT(*)
    INTO bookingExists
    FROM Bookings
    WHERE BookingDate = inputDate AND TableNumber = inputTableNumber;

    IF bookingExists > 0 THEN
		-- Table is already booked, rollback
        ROLLBACK;
        SELECT CONCAT('Table ', inputTableNumber, ' is already booked on ', inputDate) AS 'Booking status';
    ELSE
		-- Table is available, insert booking and commit
        INSERT INTO Bookings (TableNumber, BookingDate, CustomerID)
        VALUES (inputTableNumber, inputDate, defaultCustomerID);

        COMMIT;
        SELECT CONCAT('Booking confirmed for table ', inputTableNumber, ' on ', inputDate) AS 'Booking status';
    END IF;
END //
DELIMITER ;
CALL AddValidBooking('2022-12-17', 6)