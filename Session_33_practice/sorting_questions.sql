SELECT * 
FROM campusx.smartphones;

-- Worst Rated Apple Phone

SELECT model,rating 
FROM campusx.smartphones
WHERE brand_name = "apple"
ORDER BY rating ASC LIMIT 1;

-- Top 5 Samsung phones with largest screen Size

SELECT model,screen_size
FROM campusx.smartphones
WHERE brand_name = "samsung"
ORDER BY screen_size DESC LIMIT 5;

-- Sort All the given phones based on Number of cameras (Rear + Front)

SELECT num_rear_cameras + num_front_cameras AS "Total_camera"
FROM campusx.smartphones
ORDER BY Total_camera DESC;

-- Sort Phones based on PPI in descending Order

SELECT model,brand_name , SQRT(resolution_width * resolution_width + resolution_height * resolution_height ) / screen_size AS "PPI"
FROM campusx.smartphones
ORDER BY PPI DESC;

--  Find Phone that has Second largest battery capacity

SELECT *
FROM campusx.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

-- Sort All the Samsung phones based on the Ratings

SELECT * 
FROM campusx.smartphones
WHERE brand_name = "samsung"
ORDER BY rating ASC;

-- Sort Brand Names Alphabetically Followed by Rating in Descending Order

SELECT brand_name, model,price,rating
FROM campusx.smartphones
ORDER BY brand_name ASC,
rating DESC;

-- Sort Brand Names Alphabetically Followed by Price in Descending Order

SELECT brand_name,model,price,rating
FROM campusx.smartphones
ORDER BY brand_name ASC,
price ASC;