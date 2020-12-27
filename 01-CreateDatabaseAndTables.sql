-- 0.1
CREATE DATABASE RentACar;
-- 0.2
USE RentACar;
-- 0.3
CREATE FUNCTION RoundInHalfDays(@DurationInHours as decimal(10,2))
RETURNS decimal(10,2)
AS
BEGIN
	declare @DurationInDays			decimal(10, 2) = @DurationInHours / 24.00;
	declare @RoundedDurationInDays	decimal(10, 2);

	SET @RoundedDurationInDays = CASE
		WHEN (@DurationInDays % 1 = 0.00 OR @DurationInDays % 1 = 0.50 ) 
			THEN cast(@DurationInDays as decimal(10, 2))
		WHEN (@DurationInDays % 1) > 0.50 
			THEN cast(CEILING(@DurationInDays) as decimal(10, 2))
		WHEN (@DurationInDays % 1) < 0.50 
			THEN cast(FLOOR(@DurationInDays) as decimal(10, 2)) + 0.50
	END
RETURN @RoundedDurationInDays;
END;


-- 1. Set of creations
CREATE TABLE Employees(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	PIN nvarchar(20) NOT NULL UNIQUE
);

CREATE TABLE TariffClasses(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Name] nvarchar(20) NOT NULL,
	SummerHalfDayPrice decimal(10, 2) NOT NULL CHECK (SummerHalfDayPrice >= 0.0),
	WinterHalfDayPrice decimal(10, 2) NOT NULL CHECK (WinterHalfDayPrice >= 0.0)
);


-- 2. Set of creations
CREATE TABLE Vehicles(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Type] nvarchar(100) NOT NULL CHECK ([Type] in ('Motorcycle', 'Car', 'Van', 'Truck')),
	Brand nvarchar(100) NOT NULL,
	Model nvarchar(100) NOT NULL,
	Color nvarchar(100) NOT NULL,
	OdometerDistance int NOT NULL CHECK (OdometerDistance >= 0),
	TarriffClassId int FOREIGN KEY REFERENCES TariffClasses(Id) NOT NULL
);


-- 3. Set of creations
CREATE TABLE Registrations(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	RegistrationTime datetime2 NOT NULL,
	ExpirationTime datetime2 NOT NULL,
	VehicleId int FOREIGN KEY REFERENCES Vehicles(Id) NOT NULL
);

CREATE TABLE Rents(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	StartTime datetime2 NOT NULL,
	EndTime datetime2 NOT NULL,
	RoundedDuration decimal(10, 2),
	CustomerFirstName nvarchar(100) NOT NULL,
	CustomerLastName nvarchar(100) NOT NULL,
	CustomerPIN nvarchar(20) NOT NULL,
	CustomerCreditCardNumber nvarchar(100) NOT NULL,
	CustomerDriverLicenceNumber nvarchar(100) NOT NULL,
	CustomerDateOfBirth datetime2 NOT NULL CHECK (DATEDIFF(year, CustomerDateOfBirth, SYSDATETIME()) >= 18),
	VehicleId int FOREIGN KEY REFERENCES Vehicles(Id) NOT NULL,
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL
);

-- 4.Set
ALTER TABLE Rents ADD CHECK (StartTime < EndTime);


-- 5.Set
CREATE TRIGGER CalculateRoundedRentDuration
ON Rents
AFTER INSERT
AS
BEGIN
	declare @FullDuration decimal(10,2);

	UPDATE Rents
	SET Rents.RoundedDuration = [dbo].RoundInHalfDays(CAST(DATEDIFF(HOUR, StartTime, EndTime) as decimal));
END
GO

-- 6. set
CREATE TRIGGER VehicleAvailabilityCheck 
ON Rents
AFTER INSERT
AS
	declare @OverlappingRentsCount	int;
	declare @VehicleId				int;
	declare @StartTime				datetime2;
	declare @EndTime				datetime2;
	declare @InsertedRentId			int;

	SELECT 
		@InsertedRentId = i.Id,
		@VehicleId		= i.VehicleId,
		@StartTime		= i.StartTime,
		@EndTime		= i.EndTime
	FROM inserted i;

	SELECT
		@OverlappingRentsCount = COUNT(*)
		FROM Rents r
		JOIN Vehicles v ON r.VehicleId = v.Id
		WHERE 
			r.Id <> @InsertedRentId
			AND v.id = @VehicleId	
			AND
			(
				(
					r.StartTime < @StartTime
					AND r.EndTime >= @StartTime
				) 
				OR
				(
					r.StartTime >= @StartTime 
					AND r.StartTime < @EndTime
					AND r.EndTime > @StartTime 
				)
				OR
				r.StartTime = @EndTime
			);

	IF (@OverlappingRentsCount > 0)
		BEGIN
			RAISERROR('Requested rent cannot be done because selected vehicle is already booked for rent in choosen time period.', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN
		END;
	