-- Query 22: Query data from the customer csv file that is present in the stage

SELECT $1, $2, $3
FROM 
@TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
(FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT');

-- Query 23: Aggregate data, share the count of records in the customers file from stage

SELECT COUNT($1)
FROM 
@TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
(FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT');

-- Query 24: Filter data, share the records from customer file where customer DOB is after 1st Jan 2000

SELECT $1, $2, $3, $4, $5, $6, $7, $8
FROM 
@TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
(FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT')
WHERE $4 > '2000-01-01';

-- Query 25: Join Cutomers and Loyalty data and show the customer first name along with their program tier 

WITH CUSTOMER_DATA AS
(
    SELECT 
        $1 AS FIRST_NAME, 
        $11 AS PROGRAM_ID
    FROM 
    @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
    (FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT')
),
LOYALTY_PROGRAM_DATA AS
(
     SELECT 
        $1 AS PROGRAM_ID, 
        $3 AS PROGRAM_TIER
    FROM 
    @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimLoyaltyInfo/DimLoyaltyInfo.csv
    (FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT')
)
SELECT
    FIRST_NAME, 
    PROGRAM_TIER
FROM CUSTOMER_DATA C
JOIN LOYALTY_PROGRAM_DATA L
ON L.PROGRAM_ID = C.PROGRAM_ID;

-- Query 26: Join Cutomers and Loyalty data and show the number of cutomers per tier
WITH CUSTOMER_DATA AS
(
    SELECT 
        $1 AS FIRST_NAME, 
        $11 AS PROGRAM_ID
    FROM 
    @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimCustomerData/DimCustomerData.csv
    (FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT')
),
LOYALTY_PROGRAM_DATA AS
(
     SELECT 
        $1 AS PROGRAM_ID, 
        $3 AS PROGRAM_TIER
    FROM 
    @TEST_DB.TEST_SCHEMA.TEST_STAGE/DimLoyaltyInfo/DimLoyaltyInfo.csv
    (FILE_FORMAT => 'CSV_SOURCE_FILE_FORMAT')
)
SELECT 
    PROGRAM_TIER,
    COUNT(FIRST_NAME) AS CUSTOMER_COUNT
FROM CUSTOMER_DATA C
JOIN LOYALTY_PROGRAM_DATA L
ON L.PROGRAM_ID = C.PROGRAM_ID
GROUP BY PROGRAM_TIER;
