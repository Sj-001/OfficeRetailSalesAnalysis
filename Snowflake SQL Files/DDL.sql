-- Create Database
CREATE DATABASE test_db;

-- Create schema 
CREATE SCHEMA test_schema;


-- Dimension Table: DimDate
CREATE OR REPLACE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    DayOfWeek VARCHAR(10),
    Month VARCHAR(10),
    Quarter INT,
    Year INT,
    IsWeekend BOOLEAN
);

-- Dimension Table: DimLoyaltyProgram
CREATE OR REPLACE TABLE DimLoyaltyProgram (
    LoyaltyProgramID INT PRIMARY KEY,
    ProgramName VARCHAR(100),
    ProgramTier VARCHAR(50),
    PointsAccrued INT
);

-- Dimension Table: DimCustomer
CREATE OR REPLACE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY autoincrement start 1 increment 1,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Gender VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(100),
    Country VARCHAR(200),
    LoyaltyProgramID INT
);

-- Dimension Table: DimProduct
CREATE OR REPLACE TABLE DimProduct (
    ProductID INT PRIMARY KEY autoincrement start 1 increment 1,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

-- Dimension Table: DimStore
CREATE OR REPLACE TABLE DimStore (
    StoreID INT PRIMARY KEY autoincrement start 1 increment 1,
    StoreName VARCHAR(100),
    StoreType VARCHAR(100),
	StoreOpeningDate DATE,
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Region VARCHAR(100),
    ManagerName VARCHAR(100)
);

-- Fact Table: FactOrders
CREATE OR REPLACE TABLE FactOrders (
    OrderID INT PRIMARY KEY autoincrement start 1 increment 1,
    DateID INT,
    ProductID INT,
    StoreID INT,
    CustomerID INT,
    QuantityOrdered INT,
    OrderAmount DECIMAL(10, 2),
    DiscountAmount DECIMAL(10, 2),
    ShippingCost DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (StoreID) REFERENCES DimStore(StoreID)
);