create database youtube_db;
use youtube_db;

/*
Data cleaning steps:

1. Remove unnecessary columns by only selecting the ones we need
2. Extract the Youtube Channel names from the first columns
3. Rename the column names

*/

SELECT
NOMBRE,
total_subscribers,
total_views,
total_videos
from top_uk_youtubers_2024;


/*Extract channel name*/
--Find @ in the stirng;

--SELECT CHARINDEX('@',NOMBRE), NOMBRE FRom top_uk_yotubers_2024;

--SUBSTRING WITH CHARINDEX;

SELECT 
CAST( SUBSTRING(NOMBRE,1, CHARINDEX('@',NOMBRE)-1) AS VARCHAR(100))
AS channel_name
FROM 
top_uk_youtubers_2024;


--CREATE A VIEW: Virutal Table

CREATE VIEW view_uk_youtubers_2024 AS

SELECT 
CAST( SUBSTRING(NOMBRE,1, CHARINDEX('@',NOMBRE)-1) AS VARCHAR(100))
AS channel_name,
total_subscribers,
total_views,
total_videos
FROM 
top_uk_youtubers_2024;

SELECT * FROM view_uk_youtubers_2024;

/**
*Data qualtiy Tests
1. The data needs to be 100 records of Youtube channels
 RESULT: PASSED
2. The data needs 4 field(column count test)
RESULT: PASSED
3. The channel name column must be string format.
and other columb must be numerical data types(Data type check)
RESULT: PASSED
4. Each record must be unique in the dataset(Duplicate count check)
RESULT: PASSED


Row Count-100
Column count-4

Data types:
channel_name =VARCHAR
total_subscribers = INT
total_views = INT
total_videos = INT

Duplicate count = 0  
*/

--Test 1:ROW COUNT CHECK;
SELECT COUNT(*) AS no_of_rows
FROM view_uk_youtubers_2024;

---TEST 2:COLUMN COUNT CHECK
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_uk_youtubers_2024';

SELECT COUNT(*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_uk_youtubers_2024';

--TEST 3: DATA TYPE CHECK

SELECT 
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_uk_youtubers_2024';

--TEST 4: REMOVE DUPLICATES
SELECT channel_name,
COUNT(*) AS duplicate_count
FROM view_uk_youtubers_2024
GROUP BY channel_name
HAVING COUNT(*) >1;

/*4/4 TEST PASSED*/