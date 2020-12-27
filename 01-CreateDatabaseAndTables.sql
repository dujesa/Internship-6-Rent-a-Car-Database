-- 0.1
CREATE DATABASE RentACar;

-- 0.2
USE RentACar;


-- 1. Set of creations
CREATE TABLE Employees(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	PIN nvarchar(20) NOT NULL UNIQUE
);

CREATE TABLE Customers(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	PIN nvarchar(20) NOT NULL UNIQUE,
	CreditCardNumber nvarchar(100) NOT NULL,
	DriverLicenceNumber nvarchar(100) NOT NULL,
	DateOfBirth datetime2 NOT NULL CHECK (DATEDIFF(year, DateOfBirth, SYSDATETIME()) >= 18)
);

CREATE TABLE TariffClasses(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Name] nvarchar(20) NOT NULL,
	SummerDailyPrice smallmoney NOT NULL CHECK (SummerDailyPrice >= 0),
	WinterDailyPrice smallmoney NOT NULL CHECK (WinterDailyPrice >= 0)
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
	EndTime datetime2 NOT NULL ,
	VehicleId int FOREIGN KEY REFERENCES Vehicles(Id) NOT NULL,
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId int FOREIGN KEY REFERENCES Customers(Id) NOT NULL
);

ALTER TABLE Rents ADD CHECK (StartTime < EndTime);

CREATE TRIGGER VehicleAvailabilityCheck ON Rents
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
	