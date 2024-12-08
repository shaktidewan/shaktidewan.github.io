/*
1. Define the variabales
2. Create a CTE that rounds the average views per video
3. Select columns that useful for analysis
4. Filter the results by Youtube channels with the highest subscriber basis
5. Order  by net_profit (From highest to lowest)
*/

--1.
--Conversion rate @2%
DECLARE @conversionRate FLOAT; -- Declare the variable with the appropriate data type
SET @conversionRate = 0.02;   
--Product cost @5
DECLARE @productCost MONEY;
SET @productCost= 5.0;	
--Campaign cost @50
DECLARE @campaignCost MONEY;
SET @campaignCost= 50000.0;	


--2.
WITH ChannelData AS (
	SELECT 
	channel_name,
	total_views,
	total_videos,
	ROUND((CAST(total_views as FLOAT)/total_videos ) ,-4)
	as rounded_avg_views_per_video
	FROM 
	youtube_db.dbo.view_uk_youtubers_2024
)

--3.

SELECT 
	channel_name,
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video*@conversionRate) 
	AS potential_units_sold_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost) 
	AS potential_revenue_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost)-@campaignCost 
	AS net_profit
FROM ChannelData
--4.
WHERE 
channel_name IN ('NoCopyrightSounds','DanTDM','Dan Rhodes ')
--5.
ORDER BY net_profit DESC;


