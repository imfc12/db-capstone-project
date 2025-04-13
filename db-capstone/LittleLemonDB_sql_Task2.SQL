-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
    UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE,
    SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8;
USE `LittleLemonDB`;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
    `customerID` INT NOT NULL,
    `customer_name` VARCHAR(45) NULL,
    `mobile_no` INT NULL,
    PRIMARY KEY (`customerID`)
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff` (
    `staffID` INT NOT NULL,
    `staff_name` VARCHAR(45) NULL,
    `position` VARCHAR(45) NULL,
    `salary` INT NULL,
    PRIMARY KEY (`staffID`)
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
    `bookingID` INT NOT NULL,
    `booking_date` DATE NULL,
    `table_no` INT NULL,
    `customerID` INT NULL,
    `staffID` INT NULL,
    PRIMARY KEY (`bookingID`),
    INDEX `staffID_fk_idx` (`staffID` ASC) VISIBLE,
    INDEX `customerID_fk_idx` (`customerID` ASC) VISIBLE,
    CONSTRAINT `staffID_bookings_fk` FOREIGN KEY (`staffID`) REFERENCES `LittleLemonDB`.`staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `customerID_bookings_fk` FOREIGN KEY (`customerID`) REFERENCES `LittleLemonDB`.`customers` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
    `orderID` INT NOT NULL,
    `total_cost` DECIMAL(6, 2) NULL,
    `customerID` INT NULL,
    `staffID` INT NULL,
    PRIMARY KEY (`orderID`),
    INDEX `customerID_fk_idx` (`customerID` ASC) VISIBLE,
    INDEX `staffID_fk_idx` (`staffID` ASC) VISIBLE,
    CONSTRAINT `customerID_orders_fk` FOREIGN KEY (`customerID`) REFERENCES `LittleLemonDB`.`customers` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `staffID_orders_fk` FOREIGN KEY (`staffID`) REFERENCES `LittleLemonDB`.`staff` (`staffID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_types` (
    `menuID` INT NOT NULL,
    `menu_name` VARCHAR(45) NULL,
    PRIMARY KEY (`menuID`)
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
    `menuID` INT NOT NULL,
    `itemID` INT NOT NULL,
    `item_name` VARCHAR(45) NULL,
    `item_cost` DECIMAL(5, 2) NULL,
    INDEX `menuID_fk_idx` (`menuID` ASC) VISIBLE,
    PRIMARY KEY (`itemID`),
    CONSTRAINT `menuID_fk` FOREIGN KEY (`menuID`) REFERENCES `LittleLemonDB`.`menu_types` (`menuID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_delivery_status` (
    `orderID` INT NOT NULL,
    `order_status` VARCHAR(45) NULL,
    `order_date` DATE NULL,
    `order_time` TIME NULL,
    PRIMARY KEY (`orderID`),
    CONSTRAINT `orderID_deliveries_fk` FOREIGN KEY (`orderID`) REFERENCES `LittleLemonDB`.`orders` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_items` (
    `orderID` INT NOT NULL,
    `itemID` INT NULL,
    `quantity` INT NULL,
    INDEX `order_id_fk_idx` (`orderID` ASC) VISIBLE,
    INDEX `item_id_fk_idx` (`itemID` ASC) VISIBLE,
    CONSTRAINT `orderID_orderitems_fk` FOREIGN KEY (`orderID`) REFERENCES `LittleLemonDB`.`orders` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `item_id_fk` FOREIGN KEY (`itemID`) REFERENCES `LittleLemonDB`.`menu_items` (`itemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;