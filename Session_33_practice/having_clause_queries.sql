SELECT * 
FROM campusx.smartphones;

-- Find the average rating of smartphone brands excluding those having number of devices under 20

SELECT brand_name , 
COUNT(*) AS "number_of_devices",
ROUND(AVG(rating)) AS "avg_rating"
FROM campusx.smartphones
GROUP BY brand_name
HAVING COUNT(*) > 20;

-- Find the top 3 brands with highest average RAM that has refresh rate of 90 or above with fast charging available. Exclude brands having under 10 devices.alter

SELECT brand_name ,
ROUND(AVG(ram_capacity),2) 
AS "average_ram"
FROM campusx.smartphones
WHERE refresh_rate >=90 
AND fast_charging_available = 1
GROUP BY brand_name
HAVING  COUNT(*) > 10
ORDER BY average_ram DESC LIMIT 5;

-- Find the average price for all the brands where average rating is above 70 for only 5G enabled phones. Exclude brands that has less then 10 devices

SELECT brand_name ,
ROUND(AVG(price),2) AS "average_price",
ROUND(AVG(rating),2) AS "average_rating"
FROM campusx.smartphones
WHERE has_5g ='True'
GROUP BY brand_name
HAVING average_rating > 70
AND COUNT(*) > 10;
