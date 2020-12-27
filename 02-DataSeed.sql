-- 0.1 dio data seeda
USE RentACar;


-- 2. dio data seeda
INSERT INTO Employees(FirstName, LastName, PIN) VALUES 
('Anthony', 'Ants', '12345678'),
('Brock', 'Brockons', '23456789'),
('Clara', 'Claroni', '34567890'),
('Dean', 'Deanson', '45678901'),
('Edmond', 'Edmonsoba', '56789012');

INSERT INTO TariffClasses([Name], SummerHalfDayPrice, WinterHalfDayPrice) VALUES
('Classic motorcycle', 99.99, 79.99),
('Sport motorcycle', 109.99, 84.99),
('Trail motorcycle', 109.99, 84.99),
('Electric motorcycle', 199.99, 149.99),
('Small car', 99.99, 89.99),
('Medium car', 119.99, 99.99),
('Large car', 139.99, 109.99),
('SUV', 249.99, 179.99),
('Luxury car', 499.99, 299.99),
('Van', 199.99, 109.99),
('Truck', 299.99, 149.99);


-- 3. dio data seeda
INSERT INTO Vehicles([Type], Brand, Model, Color, OdometerDistance, TarriffClassId) VALUES
('Motorcycle', 'Piaggio', 'Vespa S 50', 'Magenta', 100000, 1),
('Motorcycle', 'Yamaha', 'TMAX 560', 'White', 50000, 1),
('Motorcycle', 'Honda', 'CBR 1000RR', 'Black-orange', 120000, 2),
('Motorcycle', 'BMW', 'F 750 GS', 'Black', 0, 3),
('Motorcycle', 'Harley-Davidson', 'LiveWire', 'Black-blue', 2000, 4),
('Car', 'Renault', 'Clio', 'Yellow', 200000, 5),
('Car', 'Ford', 'Fiesta', 'Red', 220000, 5),
('Car', 'Volkswagen', 'Polo', 'Orange', 50000, 5),
('Car', 'Peugeot', '208', 'Cyan', 80000, 6),
('Car', 'SEAT', 'Ibiza', 'White', 1500, 6),
('Car', 'Škoda', 'Fabia', 'Black', 120000, 6),
('Car', 'Audi', 'TT', 'Red', 250, 6),
('Car', 'Kia', 'Cadenza', 'Black', 0, 7),
('Car', 'Nissan', 'Maxima', 'Black', 0, 7),
('Car', 'Hyundai', 'Kona', 'Green', 1000, 8),
('Car', 'BMW', 'X1', 'Purple', 9000, 8),
('Car', 'Lamborghini', 'Aventador', 'Black-red', 100, 9),
('Van', 'Chrysler', 'Pacifica', 'Grey', 2000, 10),
('Van', 'Mercedes-Benz', 'Metris', 'Black', 0, 10),
('Truck', 'Chevy', 'Colorado', 'Black', 100000, 11);

-- 4. dio data seeda
INSERT INTO Registrations(RegistrationTime, ExpirationTime, VehicleId) VALUES
('2020-01-11', '2021-01-11', 1),
('2020-01-11', '2021-01-11', 2),
('2020-01-11', '2021-01-11', 3),
('2020-01-11', '2021-01-11', 4),
('2020-01-11', '2021-01-11', 5),
('2020-01-11', '2021-01-11', 6),
('2020-01-11', '2021-01-11', 7),
('2020-01-11', '2021-01-11', 8),
('2020-01-11', '2021-01-11', 9),
('2020-01-11', '2021-01-11', 10),
('2020-03-01', '2021-03-01', 11),
('2020-03-01', '2021-03-01', 12),
('2020-03-01', '2021-03-01', 13),
('2020-03-01', '2021-03-01', 14),
('2020-03-01', '2021-03-01', 15),
('2020-03-01', '2021-03-01', 17),
('2020-03-01', '2021-03-01', 18),
('2020-03-01', '2021-03-01', 19),
('2020-03-01', '2021-03-01', 20),
('2019-01-11', '2020-01-11', 1),
('2019-01-11', '2020-01-11', 2),
('2019-01-11', '2020-01-11', 3),
('2019-01-11', '2020-01-11', 4),
('2019-01-11', '2020-01-11', 5),
('2019-01-11', '2020-01-11', 6),
('2019-01-11', '2020-01-11', 7),
('2019-01-11', '2020-01-11', 8),
('2019-01-11', '2020-01-11', 9),
('2019-01-11', '2020-01-11', 10),
('2019-03-01', '2020-03-01', 11),
('2019-03-01', '2020-03-01', 12),
('2019-03-01', '2020-03-01', 13),
('2019-03-01', '2020-03-01', 14),
('2019-03-01', '2020-03-01', 15),
('2019-03-01', '2020-03-01', 16),
('2019-03-01', '2020-03-01', 17),
('2019-03-01', '2020-03-01', 18),
('2019-03-01', '2020-03-01', 19),
('2020-03-01', '2021-03-01', 20);

INSERT INTO Rents(StartTime, EndTime, CustomerFirstName, CustomerLastName, CustomerPIN, CustomerDateOfBirth, CustomerCreditCardNumber, CustomerDriverLicenceNumber, VehicleId, EmployeeId) VALUES 
('2019-12-01', '2020-01-06', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 1, 1), 
('1997-11-01', '1999-11-06', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 2, 2), 
('2019-12-20 09:00', '2019-12-21', 'Harry', 'Hunter', '89012345', '1994-03-03', '111-1121', '1111 1111 2222 1111', 3, 3), 
('2020-01-01 10:00', '2020-01-02', 'Isaac', 'Itwood', '901234567', '1996-04-04', '111-1211', '1111 2222 1111 1111', 4, 1), 
('2020-06-01 11:00', '2021-01-02', 'John', 'Jackson', '01234567', '1998-05-05', '111-2111', '2222 1111 1111 1111', 5, 2), 
('2019-12-01 12:00', '2021-02-26', 'Jack', 'Johnson', '01928374', '1990-01-01', '112-1111', '1111 1111 2222 2222', 6, 1), 
('2019-12-01 13:00', '2019-12-02', 'Kelvin', 'Kiss', '92837465', '1980-12-12', '112-1121', '1111 2222 1111 2222', 7, 1), 
('2019-10-01', '2022-02-11', 'Luke', 'Luesson', '11223344', '1981-11-11', '112-1211', '1111 2222 2222 1111', 8, 2), 
('2015-11-11', '2016-02-09', 'Margaret', 'Melwood', '22334455', '1990-01-01', '112-2111', '2222 2222 1111 1111', 1, 3), 
('2021-01-01', '2021-02-10', 'Norah', 'Nilsson', '33445566', '2000-10-01', '121-1111', '1111 2222 2222 2222', 9, 1), 
('2021-01-01', '2021-01-02', 'Olaf', 'Oshea', '44556677', '1999-09-09', '121-1112', '2222 2222 2222 2222 1111', 10, 2), 
('2019-02-02', '2022-02-02', 'Petra', 'Peterson', '55667788', '1971-11-11', '121-1121', '2222 2222 2222 2222', 11, 1), 
('2021-12-01', '2022-01-06', 'Rita', 'Ridley', '66778899', '1990-02-01', '121-1211', '1010 1010 1010 1010', 1, 1), 
('2010-02-01', '2020-02-01', 'Sarah', 'Sweep', '77889900', '2001-01-01', '121-2111', '1111 1111 0000 0000', 12, 2), 
('2010-01-01', '2010-01-03', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 2, 3), 
('2020-11-01', '2021-03-03', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 13, 1), 
('2020-02-01', '2021-02-06', 'Harry', 'Hunter', '89012345', '1994-03-03', '111-1121', '1111 1111 2222 1111', 14, 2), 
('2015-12-12', '2016-01-02', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 5, 1),
('2021-12-01', '2022-02-02', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 2, 5),
('2030-01-04', '2032-01-05', 'Margaret', 'Melwood', '22334455', '1990-01-01', '112-2111', '2222 2222 1111 1111', 1, 1),
('2021-06-01', '2022-06-02', 'Sarah', 'Sweep', '77889900', '2001-01-01', '121-2111', '1111 1111 0000 0000', 3, 3),
('2010-06-01', '2014-06-02', 'Luke', 'Luesson', '11223344', '1981-11-11', '112-1211', '1111 2222 2222 1111', 3, 3),
('2023-06-01', '2024-06-02', 'Luke', 'Luesson', '11223344', '1981-11-11', '112-1211', '1111 2222 2222 1111', 3, 2),
('2000-06-01', '2005-06-02', 'Luke', 'Luesson', '11223344', '1981-11-11', '112-1211', '1111 2222 2222 1111', 2, 3),
('2020-02-02', '2023-03-01', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 18, 3),
('2020-01-12', '2020-03-22', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 19, 3),
('2020-01-22', '2020-01-25', 'George', 'Georgins', '78901234', '1992-02-02', '111-1112', '1111 1111 1111 2222', 18, 3),
--Last two for easier price calculation testing (2 days in summer tariff half a day in winter tariff)
('2031-09-29', '2031-10-01 10:00', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 18, 1),
--(3.5 days in winter tariff and day and one day in summer tariff)
('2011-02-26 17:30', '2011-03-02 00:00', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 18, 1);



-- Check if availability check for rents work:
-- should fail because of first rent from upper script
-- [start: '2019-12-01' => end: '2020-01-06']

-- CASE 1 => Overlap format: ****[***----]
INSERT INTO Rents(StartTime, EndTime, CustomerFirstName, CustomerLastName, CustomerPIN, CustomerDateOfBirth, CustomerCreditCardNumber, CustomerDriverLicenceNumber, VehicleId, EmployeeId) VALUES 
('2018-01-01', '2020-01-01', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 1, 1);

-- CASE 2 => Overlap format: [---****---]
INSERT INTO Rents(StartTime, EndTime, CustomerFirstName, CustomerLastName, CustomerPIN, CustomerDateOfBirth, CustomerCreditCardNumber, CustomerDriverLicenceNumber, VehicleId, EmployeeId) VALUES 
('2019-12-20', '2019-12-30', 'Franck', 'Frenkies', '67890123', '1990-01-01', '111-1111', '1111 1111 1111 1111', 1, 2);

-- CASE 3 => Overlap format: [---***]****
INSERT INTO Rents(StartTime, EndTime, CustomerFirstName, CustomerLastName, CustomerPIN, CustomerDateOfBirth, CustomerCreditCardNumber, CustomerDriverLicenceNumber, VehicleId, EmployeeId) VALUES 
('2019-12-20', '2022-01-02', 'Norah', 'Nilsson', '33445566', '2000-10-01', '121-1111', '1111 2222 2222 2222', 1, 3);

-- CASE 4 => Overlap format: ****[*****]****
INSERT INTO Rents(StartTime, EndTime, CustomerFirstName, CustomerLastName, CustomerPIN, CustomerDateOfBirth, CustomerCreditCardNumber, CustomerDriverLicenceNumber, VehicleId, EmployeeId) VALUES 
('2015-01-01', '2022-01-02', 'Norah', 'Nilsson', '33445566', '2000-10-01', '121-1111', '1111 2222 2222 2222', 1, 3);

-- Should be 29 after each of 4 overlapping cases because overlapping cases are removed on triggers
select COUNT(*) from Rents;