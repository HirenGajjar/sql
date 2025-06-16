SELECT *
FROM campusx.smartphones;

-- Group Smartphones by Brand name and get the count, Average Price, Max Rating, Average Screen Size, And average Battery Capacity

SELECT brand_name , 
COUNT(*) AS "Total Number of Phones",
ROUND(AVG(price)) AS "Average Price",
MAX(rating) "Max Rating",
ROUND(AVG(screen_size)) "Average Screen Size",
ROUND(AVG(battery_capacity)) "Average Battery Capacity"
FROM campusx.smartphones
GROUP BY brand_name;

-- Group smartphones by has_nfc and get the average price and Average Rating

SELECT has_nfc,
ROUND(AVG(price)) AS "Average Price",
ROUND(AVG(rating)) AS "Average Rating"
FROM campusx.smartphones
GROUP BY has_nfc;

-- Group smartphones by extended memory available and get the average price

SELECT extended_memory_available , 
ROUND(AVG(price))
FROM campusx.smartphones
GROUP BY extended_memory_available;

-- Group smartphones by brand name ,processor brand ,and then get number of devices, average primary camera resolution for Rear camera

SELECT brand_name, processor_brand ,
COUNT(*) ,
ROUND(AVG(primary_camera_rear))
FROM campusx.smartphones
GROUP BY brand_name,processor_brand;

-- Find top 5 Most expensive phone brands

SELECT brand_name,
ROUND(AVG(price)) AS "average_price"
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY average_price DESC LIMIT 10;

-- Find out the brand that makes smallest screen size smartphones

SELECT brand_name , 
ROUND(AVG(screen_size)) AS  "screen_size"
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY screen_size ASC;

-- Average price of 5G phones vs Average price of non-5G phones

SELECT has_5g,
ROUND(AVG(price)) AS "average_price"
FROM campusx.smartphones
GROUP BY has_5g;

-- Group the smartphones by brand name and find the brand that has most number of phones with Both NFC and IR Blaster

SELECT brand_name,
COUNT(*) AS "number_of_devices"
FROM campusx.smartphones
WHERE has_5g = 'True'
AND has_ir_blaster = 'True'
GROUP BY brand_name
ORDER BY number_of_devices DESC;

-- Find all the samsung phones that are 5G Enabled , and Find average price for NFC and non-NFC

SELECT has_nfc,
ROUND(AVG(price)) AS "average_price"
FROM campusx.smartphones 
WHERE brand_name = 'samsung'
AND has_5g = 'True'
GROUP BY has_nfc;

