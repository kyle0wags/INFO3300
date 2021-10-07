-- CoffeeMerchantDM2 database developed and written by Anna Andrews, Nick Bascone, Sasha Shadrina, and Kyle Waggoner
-- Originally Written: October 2021| Updated: October 2021
-----------------------------------------------------------
IF NOT EXISTS(SELECT * FROM sys.databases
WHERE NAME = N'CoffeeMerchantDM2')
CREATE DATABASE CoffeeMerchantDM2
GO
USE CoffeeMerchantDM2
--
---
--
IF EXISTS(
SELECT *
FROM sys.tables
WHERE NAME = N'FactSales'
       )
DROP TABLE FactSales;
--
IF EXISTS(
SELECT *
FROM sys.tables
WHERE NAME = N'DimDate'
       )
DROP TABLE DimDate;
--
IF EXISTS(
SELECT *
FROM sys.tables
WHERE NAME = N'DimEmployee'
       )
DROP TABLE DimEmployee;
--
IF EXISTS(
SELECT *
FROM sys.tables
WHERE NAME = N'DimCustomer'
       )
DROP TABLE DimCustomer;
--
IF EXISTS(
SELECT *
FROM sys.tables
WHERE NAME = N'DimProduct'
       )
DROP TABLE DimProduct;
--
---
--
CREATE TABLE DimProduct
	(Product_SK			INT IDENTITY (1,1)	CONSTRAINT pk_product_sk PRIMARY KEY,
	Product_AK			INT					CONSTRAINT ATTTRIBUTE NOT NULL,
	ProductType			NCHAR(1)			CONSTRAINT ck_type  CHECK (ProductType IN('C', 'T')),
	Country 			INT					CONSTRAINT ATTTRIBUTE NOT NULL
);
--
CREATE TABLE DimCustomer
	(Customer_SK		INT IDENTITY (1,1)	CONSTRAINT pk_customer_sk PRIMARY KEY,
	Customer_AK			INT					CONSTRAINT nn_      NOT NULL,
	DOB					DATETIME			CONSTRAINT nn_dob   NOT NULL,
	Gender				NVARCHAR(1)			CONSTRAINT nn_gen   NOT NULL,
	CreditLimit			NVARCHAR(50)		CONSTRAINT nn_cl    NOT NULL,
	City				NVARCHAR(2)			CONSTRAINT nn_cty   NOT NULL,
	[State]				NVARCHAR(20)		CONSTRAINT nn_st    NOT NULL,
	Taxrate				INT					CONSTRAINT nn_tr    NOT NULL,								
	Zipcode				NVARCHAR(10)		CONSTRAINT nn_zc	NOT NULL								
	);
--
CREATE TABLE DimEmployee
	(Employee_SK		INT IDENTITY (1,1)	CONSTRAINT pk_employee_sk PRIMARY KEY,
	Employee_AK			INT					CONSTRAINT nn_emp_ak	NOT NULL,
	HireDate			DATETIME			CONSTRAINT nn_hd		NOT NULL,
	BirthDate			DATETIME			CONSTRAINT nn_bd		NOT NULL,
	Gender			    NVARCHAR(1)			CONSTRAINT nn_emp_gen	NOT NULL,
	EmployeeType		NVARCHAR(30)		CONSTRAINT nn_et		NOT NULL
	);
--
CREATE TABLE DimDate 
	(Date_SK			INT					CONSTRAINT pk_date_sk PRIMARY KEY, 
	Date				DATE,
	FullDate			NCHAR(10),		-- Date in MM-dd-yyyy format
	DayOfMonth			INT,			-- Field will hold day number of Month
	DayName				NVARCHAR(9),	-- Contains name of the day, Sunday, Monday 
	DayOfWeek			INT,			-- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth	INT,			-- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear		INT,
	DayOfQuarter		INT,
	DayOfYear			INT,
	WeekOfMonth			INT,			-- Week Number of Month 
	WeekOfQuarter		INT,			-- Week Number of the Quarter
	WeekOfYear			INT,			-- Week Number of the Year
	Month				INT,			-- Number of the Month 1 to 12{}
	MonthName			NVARCHAR(9),	-- January, February etc
	MonthOfQuarter		INT,			-- Month Number belongs to Quarter
	Quarter				NCHAR(2),
	QuarterName			NVARCHAR(9),	-- First,Second..
	Year				INT,			-- Year value of Date stored in Row
	YearName			CHAR(7),		-- CY 2017,CY 2018
	MonthYear			CHAR(10),		-- Jan-2018,Feb-2018
	MMYYYY				INT,
	FirstDayOfMonth		DATE,
	LastDayOfMonth		DATE,
	FirstDayOfQuarter	DATE,
	LastDayOfQuarter	DATE,
	FirstDayOfYear		DATE,
	LastDayOfYear		DATE,
	IsHoliday			BIT,			-- Flag 1=National Holiday, 0-No National Holiday
	IsWeekday			BIT,			-- 0=Week End ,1=Week Day
	Holiday				NVARCHAR(50),	--Name of Holiday in US
	Season				NVARCHAR(10)	--Name of Season
	);
--
CREATE TABLE FactSales
	(OrderID_DD			INT IDENTITY(1,1)	CONSTRAINT pk_orderid_dd PRIMARY KEY,
	Product_SK			INT					CONSTRAINT fk_product_sk 
		FOREIGN KEY REFERENCES dbo.DimProduct (Product_SK) NOT NULL,
	Customer_SK			INT					CONSTRAINT fk_customer_sk 
		FOREIGN KEY REFERENCES dbo.DimCustomer (Customer_SK) NOT NULL,
	Employee_SK			INT					CONSTRAINT fk_employeer_sk 
		FOREIGN KEY REFERENCES dbo.DimEmployee (Employee_SK) NOT NULL,
	Date_SK				INT					CONSTRAINT fk_date_sk 
		FOREIGN KEY REFERENCES dbo.DimDate (Date_SK) NOT NULL,
	PriceOnOrder		INT					CONSTRAINT nn_poo NOT NULL,
	QuantityOnOrder		INT					CONSTRAINT nn_qoo NOT NULL,	
	DiscountOnOrder		INT					CONSTRAINT nn_doo NOT NULL,	
	ValueOnOrder		INT					CONSTRAINT nn_voo NOT NULL
);
--
