-- Pred-query naredbe
-- 0.1
USE RentACar;
-- 0.2
CREATE FUNCTION RentPrice (@RentId as int)
RETURNS decimal(10, 2)
AS
BEGIN
	declare @SummerTariffStartDate	datetime2 = '2020-03-01';
	declare @SummerTariffEndDate	datetime2 = '2020-09-30';
	declare @SummerTariffPrice		decimal(10, 2);
	declare	@WinterTariffPrice		decimal(10, 2);
	declare @DurationInDays			decimal(10, 2);
	declare @PriceCheckingDate		datetime2;
	declare @Price					decimal(10, 2) = 0.0;

	SELECT 
		@SummerTariffPrice	= tc.SummerHalfDayPrice,
		@WinterTariffPrice	= tc.WinterHalfDayPrice,
		@DurationInDays		= r.RoundedDuration,
		@PriceCheckingDate	= r.StartTime
	FROM TariffClasses tc
	JOIN Vehicles v ON tc.Id = v.TarriffClassId
	JOIN Rents r ON v.Id = r.VehicleId
	WHERE r.Id = @RentId;

	WHILE (@DurationInDays > 0.00)
	BEGIN
		IF (DATEPART(MONTH, @PriceCheckingDate) >= DATEPART(MONTH, @SummerTariffStartDate) AND DATEPART(MONTH, @PriceCheckingDate) <= DATEPART(MONTH, @SummerTariffEndDate))
			SET @Price += @SummerTariffPrice;
		ELSE
			SET @Price += @WinterTariffPrice;
		

		SET @PriceCheckingDate = DATEADD(HOUR, 12, @PriceCheckingDate);
		SET @DurationInDays -= 0.5;
	END

RETURN @Price;
END;
-- 1. Vozila sa isteknutom registracijom
SELECT *
FROM Vehicles v
WHERE v.Id NOT IN 
(
	SELECT DISTINCT(v.id)
	FROM Vehicles v	
	JOIN Registrations r ON v.Id = r.VehicleId
	WHERE 
		GETDATE() >= r.RegistrationTime 
		AND GETDATE() < r.ExpirationTime
);


-- 2. Vozila sa istekom registracije unutar sljedeæih mjesec dana
SELECT *
FROM Vehicles v	
JOIN Registrations r ON v.Id = r.VehicleId
WHERE 
	GETDATE() < r.ExpirationTime
	AND DATEADD(month, 1, GETDATE()) >= r.ExpirationTime;


-- 3. Broj vozila po vrsti
SELECT	v.[Type]	AS 'Vehicle type',
		COUNT(*)	AS 'Number of vehicles'
FROM Vehicles v
GROUP BY v.[Type]
ORDER BY 'Number of vehicles' DESC;


-- 4. Zadnjih 5 najmova koje je ostvario neki zaposlenik
-- IZRADA PROCEDURE(ideja sa procedurom je da ne bude hardkodiran employee id u upitu)
CREATE PROCEDURE SelectLast5RentsMadeByEmployeeWithId @EmployeeId int
AS
	SELECT TOP(5) *
	FROM Rents r
	JOIN Employees e ON r.EmployeeId = e.Id
	WHERE e.Id = @EmployeeId
	ORDER BY r.StartTime DESC;
GO

-- IZVRŠENJE UPITA
EXEC SelectLast5RentsMadeByEmployeeWithId 3;


-- 5. Izraèunati ukupnu cijenu najma za odreðeni najam 
-- (hint: pripaziti na najmove koji imaju miješanu zimsku i ljetnu tarifu tijekom trajanja)
SELECT	r.*,
		tc.SummerHalfDayPrice,
		tc.WinterHalfDayPrice,
		CAST([dbo].RentPrice(r.Id) as nvarchar) + ' kn' AS 'Price'
FROM Rents r
JOIN Vehicles v ON r.VehicleId = v.Id
JOIN TariffClasses tc ON v.TarriffClassId = tc.Id;

-- 6. Svi kupci najmova ikad, bez ponavljanja
SELECT  
	MIN (r.CustomerFirstName)			AS 'First name',
	MIN (r.CustomerLastName)			AS 'Last name',
	MIN (r.CustomerDateOfBirth)			AS 'Date of birth',
	MIN (r.CustomerPIN)					AS 'Personal ID number',
	MIN (r.CustomerCreditCardNumber)	AS 'Credit card number',
	MIN (r.CustomerDriverLicenceNumber)	AS 'Driver licence number'
FROM Rents r
GROUP BY r.CustomerPIN;


-- 7. Za svakog zaposlenika timestamp zadnjeg najma kojeg je ostvario
SELECT	MIN(e.FirstName)	AS 'Employee first name',
		MIN(e.LastName)		AS 'Employee last name',
		CASE
			WHEN MAX(r.StartTime) IS NULL THEN 'No rents made yet.'
			ELSE CONVERT(nvarchar, MAX(r.StartTime))
		END					AS 'Timestamp of last rent made' 
FROM Rents r
RIGHT JOIN Employees e ON r.EmployeeId = e.Id
GROUP BY e.Id;


-- 8. Broj vozila svake marke koji rent-a-car ima
SELECT v.Brand, COUNT(*) AS 'Number of vehicles by brand'
FROM Vehicles v
GROUP BY v.Brand;


-- 9. Arhivirati sve najmove koji su završili u novu tablicu. Osim veæ postojeæih podataka u najmu, arhivirana tablica æe sadržavati i podatak koliko je taj najam koštao.
SELECT 
	r.*,
	CAST([dbo].RentPrice(r.Id) as nvarchar) + ' kn' AS Price
INTO PastRents
FROM Rents r
WHERE GETDATE() > r.EndTime;

-- Ispis arhivirane
SELECT * FROM PastRents;


-- 10. Pobrojati koliko je najmova bilo po mjesecu, u svakom mjesecu 2020. godine
WITH Months(MonthNumber) AS
(
    SELECT 1
    UNION ALL
    SELECT MonthNumber + 1
	FROM Months
    WHERE MonthNumber < 12
)
SELECT	
	MONTH(r.StartTime)	AS 'Month',
	COUNT(*)			AS 'Number of rents made'
FROM Rents r
WHERE YEAR(r.StartTime) = 2020
GROUP BY MONTH(r.StartTime)
UNION
SELECT 
	MonthNumber	AS 'Month',
	0			AS 'Number of rents made'
FROM Months
WHERE MonthNumber NOT IN (
	SELECT MONTH(MIN(r.StartTime))
	FROM Rents r 
	WHERE YEAR(r.StartTime) = 2020
	GROUP BY MONTH(r.StartTime)
);

-- 11. Za sva vozila odreðene vrste, osim informaciju o vozilu, ispisati tekstualnu informaciju treba li registrirati vozilo unutar iduæih mjesec dana (‘Treba registraciju’, ‘Ne treba registraciju’)
SELECT	MIN(v.[Type])			AS 'Vehicle type',
		MIN(v.Brand)			AS 'Brand',
		MIN(v.Model)			AS 'Model',
		MIN(v.Color)			AS 'Color',
		MIN(v.OdometerDistance)	AS 'Odometer distance',
		CASE WHEN MAX(r.ExpirationTime) < DATEADD(MONTH, 1, GETDATE())
			THEN 'Treba registraciju' 
			ELSE 'Ne treba registraciju'
		END						AS 'Potreba za obnovom registracije:' 
FROM Vehicles v
JOIN Registrations r ON v.Id = r.VehicleId
GROUP BY v.Id;


-- 12. Dohvatiti broj najmova po vrsti vozila èija duljina najma (razdoblje) prelazi prosjeènu duljinu najma
CREATE PROCEDURE GetNumberOfRentsByVehicleTypeWithLengthGreaterThanAverage
AS
	declare @AverageRentLength int;
	
	SELECT @AverageRentLength = AVG(DATEDIFF(HOUR, r.StartTime, r.EndTime))
	FROM Rents r;

	SELECT
		v.Type		AS 'Vehicle type',
		COUNT(*)	AS 'Number of rents longer than average'
	FROM Rents r
	JOIN Vehicles v ON r.VehicleId = v.Id
	WHERE DATEDIFF(HOUR, r.StartTime, r.EndTime) > @AverageRentLength
	GROUP BY v.[Type]
GO

-- Izvršavanje procedure

EXEC GetNumberOfRentsByVehicleTypeWithLengthGreaterThanAverage;
