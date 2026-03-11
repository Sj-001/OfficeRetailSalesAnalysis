TEST_DB.TEST_SCHEMA.TEST_STAGEUSE DATABASE TEST_DB;
USE SCHEMA TEST_SCHEMA;

CREATE OR REPLACE FILE FORMAT CSV_SOURCE_FILE_FORMAT
TYPE = 'CSV'
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
DATE_FORMAT = 'YYYY-MM-DD';

CREATE OR REPLACE STAGE TEST_STAGE;

/* Use SnowSQL CLI to load the local csv files to stage. 
snowsql -a <account_identifier> -u <username>
> use database test_db;
> use schema test_schema;
> use role ACCOUNTADMIN;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/DimLoyaltyInfo.csv @test_db.test_schema.test_stage/DimLoyaltyInfo/ AUTO_COMPRESS=FALSE;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/DimCustomerData.csv @test_db.test_schema.test_stage/DimCustomerData/ AUTO_COMPRESS=FALSE;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/DimDateData.csv @test_db.test_schema.test_stage/DimDateData/ AUTO_COMPRESS=FALSE;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/DimProductData.csv @test_db.test_schema.test_stage/DimProductData/ AUTO_COMPRESS=FALSE;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/DimStoreData.csv @test_db.test_schema.test_stage/DimStoreData/ AUTO_COMPRESS=FALSE;
> put file:///Users/sj/Desktop/OfflineRetailProject/Data/FactOrdersData.csv @test_db.test_schema.test_stage/FactOrdersData/ AUTO_COMPRESS=FALSE;
> put 'file:///Users/sj/Desktop/OfflineRetailProject/Data/OvernightStoresData/*.csv' @test_db.test_schema.test_stage/OvernightStoresData/ AUTO_COMPRESS=FALSE;
> ls @TEST_STAGE
*/

COPY INTO DIMLOYALTYPROGRAM
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimLoyaltyInfo/DimLoyaltyInfo.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

SELECT * FROM DIMLOYALTYPROGRAM;

COPY INTO DIMCUSTOMER(
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Email,
    Address,
    City,
    State,
    ZipCode,
    Country,
    LoyaltyProgramID
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

COPY INTO DIMPRODUCT(
    ProductName,
    Category,
    Brand,
    UnitPrice
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimProductData/DimProductData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

COPY INTO DIMDATE(
    DateID,
    Date,
    DayOfWeek,
    Month,
    Quarter,
    Year,
    IsWeekend
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimDateData/DimDateData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

COPY INTO DIMSTORE(
    StoreName,
    StoreType,
	StoreOpeningDate,
    Address,
    City,
    State,
    Country,
    Region,
    ManagerName
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimStoreData/DimStoreData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

-- Currently the random orderDate generated is out of date range of past 10 years
COPY INTO FACTORDERS(
    DateID,
    ProductID,
    StoreID,
    CustomerID,
    QuantityOrdered,
    OrderAmount,
    DiscountAmount,
    ShippingCost,
    TotalAmount
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/FactOrdersData/FactOrdersData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');

-- Loading the overnight sales data TEST_DB.TEST_SCHEMA.FACTORDERS
COPY INTO FACTORDERS(
    DateID,
    ProductID,
    StoreID,
    CustomerID,
    QuantityOrdered,
    OrderAmount,
    DiscountAmount,
    ShippingCost,
    TotalAmount
    )
FROM @TEST_DB.TEST_SCHEMA.TEST_STAGE/OvernightStoresData/
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT');