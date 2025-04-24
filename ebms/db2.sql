CREATE DATABASE electricity_billings;

USE electricity_billings;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    contact_number VARCHAR(10),
    email VARCHAR(100),
    entry_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT ,
    account_number VARCHAR(20) ,
    accouunt_type ENUM ("Residential","Commercial","Industrial")
);



CREATE TABLE Meter_Readings (
    reading_id INT PRIMARY KEY ,
    customer_id INT , 
    reading_date DATE ,
    current_reading INT ,
    previous_reading INT
);




CREATE TABLE Bills (
    bill_id INT PRIMARY KEY ,
    customer_id INT , 
    bill_date DATE ,
    units_consumed INT , 
    amount DECIMAL(10,2) , 
    due_date DATE ,
    status ENUM("Paid","Unpaid")
);





CREATE TABLE Payments (
    payment_id INT PRIMARY KEY ,
    bill_id INT ,
    payment_date DATE ,
    payment_mode ENUM("Credit Card","Debit Card","Net Banking","UPI","Cash") ,
    amount_paid DECIMAL(10,2) ,
    payment_status ENUM("Successful","Failed","Pending")
);



CREATE TABLE Tariffs (
    tariff_id INT PRIMARY KEY,
    tariff_type ENUM("Residential","Commercial","Industrial"),
    per_unit_charge DECIMAL(5,2)
);




CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY ,
    bill_id INT ,
    payment_id INT ,
    invoice_date DATE ,
    total_amount DECIMAL(10,2)
);



CREATE TABLE Electric_Board (
    board_id INT PRIMARY KEY ,
    board_name VARCHAR(100) ,
    region VARCHAR(100)
);

SET SQL_SAFE_UPDATES = 0;



-- adding entries

INSERT INTO customers (customer_id, name, address, contact_number, email) VALUES
(1, 'Alice Sharma', '123 Park St, Delhi', '9876543210', 'alice@example.com'),
(2, 'Rahul Mehta', '456 Green Ave, Mumbai', '9123456789', 'rahul@example.com'),
(3, 'Sneha Rao', '789 Lake View, Bangalore', '9345678901', 'sneha@example.com'),
(4, 'Amit Patel', '101 Hill Road, Pune', '9234567890', 'amit@example.com'),
(5, 'Pooja Iyer', '32 Beach Lane, Chennai', '9456123789', 'pooja@example.com'),
(6, 'Karan Singh', '67 MG Road, Hyderabad', '9988776655', 'karan@example.com'),
(7, 'Neha Jain', '89 Palm Grove, Kolkata', '9765432109', 'neha@example.com'),
(8, 'Ravi Kumar', '14 Sector 18, Noida', '9876012345', 'ravi@example.com'),
(9, 'Anjali Verma', '77 Ring Rd, Jaipur', '9312345678', 'anjali@example.com'),
(10, 'Deepak Joshi', '88 Sunrise Apts, Lucknow', '9001122334', 'deepak@example.com'),
(11, 'Meera Das', '100 Ocean View, Kochi', '9988771122', 'meera@example.com'),
(12, 'Varun Nair', '55 Sector 9, Trivandrum', '9887766554', 'varun@example.com'),
(13, 'Swati Bansal', '909 New Town, Indore', '9877611223', 'swati@example.com'),
(14, 'Harshit Goyal', '409 Old City, Bhopal', '9766001234', 'harshit@example.com'),
(15, 'Divya Kapoor', '78 Maple St, Chandigarh', '9887004411', 'divya@example.com'),
(16, 'Rakesh Dubey', '28 Fort Rd, Nagpur', '9944112233', 'rakesh@example.com'),
(17, 'Tanvi Rathi', '63 University Rd, Surat', '9877554321', 'tanvi@example.com'),
(18, 'Vikas Sinha', '120 Central Ave, Patna', '9090901234', 'vikas@example.com'),
(19, 'Isha Malhotra', '230 Sunrise Blvd, Ranchi', '9123459988', 'isha@example.com'),
(20, 'Rohit Rana', '45 Metro Lane, Ghaziabad', '9234598765', 'rohit@example.com');



INSERT INTO Accounts (account_id, customer_id, account_number, accouunt_type) VALUES
(1, 1, 'ACC1001', 'Residential'),
(2, 2, 'ACC1002', 'Commercial'),
(3, 3, 'ACC1003', 'Residential'),
(4, 4, 'ACC1004', 'Industrial'),
(5, 5, 'ACC1005', 'Commercial'),
(6, 6, 'ACC1006', 'Residential'),
(7, 7, 'ACC1007', 'Industrial'),
(8, 8, 'ACC1008', 'Residential'),
(9, 9, 'ACC1009', 'Commercial'),
(10, 10, 'ACC1010', 'Residential'),
(11, 11, 'ACC1011', 'Industrial'),
(12, 12, 'ACC1012', 'Commercial'),
(13, 13, 'ACC1013', 'Residential'),
(14, 14, 'ACC1014', 'Industrial'),
(15, 15, 'ACC1015', 'Commercial'),
(16, 16, 'ACC1016', 'Residential'),
(17, 17, 'ACC1017', 'Commercial'),
(18, 18, 'ACC1018', 'Residential'),
(19, 19, 'ACC1019', 'Industrial'),
(20, 20, 'ACC1020', 'Residential');


INSERT INTO Meter_Readings (reading_id, customer_id, reading_date, current_reading, previous_reading) VALUES
(1, 1, '2024-03-01', 500, 400),
(2, 2, '2024-03-01', 750, 680),
(3, 3, '2024-03-01', 640, 580),
(4, 4, '2024-03-01', 1200, 1100),
(5, 5, '2024-03-01', 900, 850),
(6, 6, '2024-03-01', 670, 600),
(7, 7, '2024-03-01', 1050, 950),
(8, 8, '2024-03-01', 610, 570),
(9, 9, '2024-03-01', 800, 750),
(10, 10, '2024-03-01', 500, 450),
(11, 11, '2024-03-01', 950, 890),
(12, 12, '2024-03-01', 700, 640),
(13, 13, '2024-03-01', 480, 430),
(14, 14, '2024-03-01', 980, 900),
(15, 15, '2024-03-01', 620, 570),
(16, 16, '2024-03-01', 790, 720),
(17, 17, '2024-03-01', 850, 800),
(18, 18, '2024-03-01', 550, 500),
(19, 19, '2024-03-01', 700, 650),
(20, 20, '2024-03-01', 600, 560);



INSERT INTO Bills (bill_id, customer_id, bill_date, units_consumed, amount, due_date, status) VALUES
(1, 1, '2024-03-05', 100, 500.00, '2024-03-20', 'Paid'),
(2, 2, '2024-03-05', 70, 420.00, '2024-03-20', 'Unpaid'),
(3, 3, '2024-03-05', 60, 300.00, '2024-03-20', 'Paid'),
(4, 4, '2024-03-05', 100, 600.00, '2024-03-20', 'Paid'),
(5, 5, '2024-03-05', 50, 350.00, '2024-03-20', 'Unpaid'),
(6, 6, '2024-03-05', 70, 490.00, '2024-03-20', 'Paid'),
(7, 7, '2024-03-05', 100, 700.00, '2024-03-20', 'Unpaid'),
(8, 8, '2024-03-05', 40, 240.00, '2024-03-20', 'Paid'),
(9, 9, '2024-03-05', 60, 360.00, '2024-03-20', 'Unpaid'),
(10, 10, '2024-03-05', 50, 250.00, '2024-03-20', 'Paid'),
(11, 11, '2024-03-05', 60, 480.00, '2024-03-20', 'Paid'),
(12, 12, '2024-03-05', 80, 560.00, '2024-03-20', 'Unpaid'),
(13, 13, '2024-03-05', 50, 275.00, '2024-03-20', 'Paid'),
(14, 14, '2024-03-05', 90, 630.00, '2024-03-20', 'Unpaid'),
(15, 15, '2024-03-05', 45, 315.00, '2024-03-20', 'Paid'),
(16, 16, '2024-03-05', 65, 455.00, '2024-03-20', 'Paid'),
(17, 17, '2024-03-05', 70, 490.00, '2024-03-20', 'Unpaid'),
(18, 18, '2024-03-05', 50, 350.00, '2024-03-20', 'Paid'),
(19, 19, '2024-03-05', 55, 385.00, '2024-03-20', 'Paid'),
(20, 20, '2024-03-05', 60, 420.00, '2024-03-20', 'Unpaid');



INSERT INTO Payments (payment_id, bill_id, payment_date, payment_mode, amount_paid, payment_status) VALUES
(1, 1, '2024-03-06', 'UPI', 500.00, 'Successful'),
(2, 2, '2024-03-08', 'Credit Card', 420.00, 'Pending'),
(3, 3, '2024-03-07', 'Net Banking', 300.00, 'Successful'),
(4, 4, '2024-03-08', 'Debit Card', 600.00, 'Successful'),
(5, 5, '2024-03-09', 'Cash', 350.00, 'Failed'),
(6, 6, '2024-03-07', 'UPI', 490.00, 'Successful'),
(7, 7, '2024-03-10', 'Credit Card', 700.00, 'Pending'),
(8, 8, '2024-03-06', 'Net Banking', 240.00, 'Successful'),
(9, 9, '2024-03-07', 'Cash', 360.00, 'Pending'),
(10, 10, '2024-03-06', 'UPI', 250.00, 'Successful'),
(11, 11, '2024-03-07', 'Debit Card', 480.00, 'Successful'),
(12, 12, '2024-03-08', 'Credit Card', 560.00, 'Failed'),
(13, 13, '2024-03-06', 'Net Banking', 275.00, 'Successful'),
(14, 14, '2024-03-09', 'UPI', 630.00, 'Pending'),
(15, 15, '2024-03-06', 'Cash', 315.00, 'Successful'),
(16, 16, '2024-03-07', 'Debit Card', 455.00, 'Successful'),
(17, 17, '2024-03-09', 'Credit Card', 490.00, 'Pending'),
(18, 18, '2024-03-06', 'Net Banking', 350.00, 'Successful'),
(19, 19, '2024-03-07', 'UPI', 385.00, 'Successful'),
(20, 20, '2024-03-08', 'Cash', 420.00, 'Failed');



INSERT INTO Tariffs (tariff_id, tariff_type, per_unit_charge) VALUES
(1, 'Residential', 5.00),
(2, 'Commercial', 6.50),
(3, 'Industrial', 7.25),
(4, 'Residential', 4.80),
(5, 'Commercial', 6.10),
(6, 'Industrial', 7.00),
(7, 'Residential', 5.10),
(8, 'Commercial', 6.20),
(9, 'Industrial', 7.30),
(10, 'Residential', 5.00),
(11, 'Commercial', 6.40),
(12, 'Industrial', 7.10),
(13, 'Residential', 5.20),
(14, 'Commercial', 6.30),
(15, 'Industrial', 7.50),
(16, 'Residential', 4.90),
(17, 'Commercial', 6.00),
(18, 'Industrial', 7.40),
(19, 'Residential', 5.30),
(20, 'Commercial', 6.60);



INSERT INTO Invoices (invoice_id, bill_id, payment_id, invoice_date, total_amount) VALUES
(1, 1, 1, '2024-03-06', 500.00),
(2, 2, 2, '2024-03-08', 420.00),
(3, 3, 3, '2024-03-07', 300.00),
(4, 4, 4, '2024-03-08', 600.00),
(5, 5, 5, '2024-03-09', 350.00),
(6, 6, 6, '2024-03-07', 490.00),
(7, 7, 7, '2024-03-10', 700.00),
(8, 8, 8, '2024-03-06', 240.00),
(9, 9, 9, '2024-03-07', 360.00),
(10, 10, 10, '2024-03-06', 250.00),
(11, 11, 11, '2024-03-07', 480.00),
(12, 12, 12, '2024-03-08', 560.00),
(13, 13, 13, '2024-03-06', 275.00),
(14, 14, 14, '2024-03-09', 630.00),
(15, 15, 15, '2024-03-06', 315.00),
(16, 16, 16, '2024-03-07', 455.00),
(17, 17, 17, '2024-03-09', 490.00),
(18, 18, 18, '2024-03-06', 350.00),
(19, 19, 19, '2024-03-07', 385.00),
(20, 20, 20, '2024-03-08', 420.00);



INSERT INTO Electric_Board (board_id, board_name, region) VALUES
(1, 'North Power Corp', 'North'),
(2, 'Southern Electricity Ltd', 'South'),
(3, 'Western Grid Systems', 'West'),
(4, 'Eastern Light Supply', 'East'),
(5, 'Central Energy Board', 'Central'),
(6, 'UP Power Ltd', 'North'),
(7, 'Tamil Nadu Elec Corp', 'South'),
(8, 'Maharashtra Grid', 'West'),
(9, 'Bengal State Elec', 'East'),
(10, 'Madhya Energy Co.', 'Central'),
(11, 'Delhi Power Authority', 'North'),
(12, 'Kerala Electrics', 'South'),
(13, 'Rajasthan Volt Ltd', 'West'),
(14, 'Assam Electric Supply', 'East'),
(15, 'Chhattisgarh Grid', 'Central'),
(16, 'Punjab Power Service', 'North'),
(17, 'Andhra Energy Board', 'South'),
(18, 'Gujarat Elec Corp', 'West'),
(19, 'Odisha Light & Power', 'East'),
(20, 'Jharkhand Energy Dept', 'Central');






DELIMITER //

CREATE TRIGGER prevent_meter_reading_decrease
BEFORE INSERT ON Meter_Readings
FOR EACH ROW
BEGIN
    DECLARE last_reading INT;

    -- Get the last meter reading for this customer
    SELECT current_reading
    INTO last_reading
    FROM Meter_Readings
    WHERE customer_id = NEW.customer_id
    ORDER BY reading_date DESC
    LIMIT 1;

    -- Check if new reading is less than the last reading
    IF NEW.current_reading < IFNULL(last_reading, 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'New meter reading cannot be less than the previous reading';
    END IF;
END;
//

DELIMITER ;



CREATE TRIGGER update_bill_status_after_payment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    DECLARE total_paid DECIMAL(10,2);
    DECLARE bill_amount DECIMAL(10,2);

    -- Calculate total payments for the bill
    SELECT SUM(amount_paid) INTO total_paid FROM Payments WHERE bill_id = NEW.bill_id;

    -- Get the total bill amount
    SELECT amount INTO bill_amount FROM Bills WHERE bill_id = NEW.bill_id;

    -- Update bill status if fully paid
    IF total_paid >= bill_amount THEN
        UPDATE Bills SET status = 'Paid' WHERE bill_id = NEW.bill_id;
    END IF;
END ;



CREATE TRIGGER apply_late_fee_before_update
BEFORE UPDATE ON Bills
FOR EACH ROW
BEGIN
    IF NEW.status = 'Unpaid' AND OLD.due_date < NOW() THEN
        SET NEW.amount = NEW.amount + 50.00;  -- Adding a fixed late fee
    END IF;
END $$



CREATE TRIGGER prevent_customer_deletion
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    DECLARE unpaid_bills INT;

    -- Count the number of unpaid bills
    SELECT COUNT(*) INTO unpaid_bills 
    FROM Bills 
    WHERE customer_id = OLD.customer_id AND status = 'Unpaid';

    -- Prevent deletion if unpaid bills exist
    IF unpaid_bills > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer cannot be deleted due to unpaid bills';
    END IF;
END $$



CREATE TRIGGER generate_invoice_after_payment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Successful' THEN
        INSERT INTO Invoices (bill_id, payment_id, invoice_date, total_amount)
        VALUES (NEW.bill_id, NEW.payment_id, NOW(), NEW.amount_paid);
    END IF;
END $$




SELECT name, customer_id 
FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM Bills 
    GROUP BY customer_id 
    HAVING SUM(amount) = (
        SELECT MAX(total_amount) 
        FROM (
            SELECT SUM(amount) AS total_amount 
            FROM Bills 
            GROUP BY customer_id
        ) AS bill_totals
    )
);


SELECT * 
FROM Meter_Readings 
WHERE (customer_id, reading_date) IN (
    SELECT customer_id, MAX(reading_date)
    FROM Meter_Readings
    GROUP BY customer_id
);




SELECT name, customer_id 
FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM Bills 
    WHERE status = 'Unpaid' 
      AND amount > (
        SELECT AVG(amount) FROM Bills
    )
);






SELECT * 
FROM Bills 
WHERE bill_id NOT IN (
    SELECT bill_id 
    FROM Payments 
    WHERE payment_status = 'Successful'
);



SELECT name, customer_id 
FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM Accounts 
    GROUP BY customer_id 
    HAVING COUNT(*) > 1
);




CREATE VIEW Paid_Bills_View AS
SELECT b.bill_id, c.name, b.amount, b.bill_date
FROM Bills b
JOIN customers c ON b.customer_id = c.customer_id
WHERE b.status = 'Paid';



SELECT p.payment_id, c.name, p.amount_paid, p.payment_date
FROM Payments p
JOIN Bills b ON p.bill_id = b.bill_id
JOIN customers c ON b.customer_id = c.customer_id;





SELECT c.customer_id, c.name, b.bill_id, b.amount
FROM customers c
LEFT JOIN Bills b ON c.customer_id = b.customer_id;




UPDATE Bills 
SET status = 'Unpaid' 
WHERE status IS NULL 
  AND due_date < CURDATE();



DELETE FROM Payments 
WHERE payment_status = 'Failed';



CREATE VIEW Overdue_Bills AS
SELECT * 
FROM Bills 
WHERE status = 'Unpaid' AND due_date < CURDATE();



SELECT c.name, a.account_type, t.per_unit_charge
FROM customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Tariffs t ON a.account_type = t.tariff_type;



SELECT i.invoice_id, i.total_amount, p.payment_status
FROM Invoices i
JOIN Payments p ON i.payment_id = p.payment_id;



UPDATE Payments p
JOIN Bills b ON p.bill_id = b.bill_id
SET p.payment_status = 'Successful'
WHERE p.amount_paid = b.amount AND p.payment_status != 'Successful';





SHOW TABLES;