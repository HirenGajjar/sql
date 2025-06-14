SELECT * 
FROM campusx.smartphones;

SELECT model,rating 
FROM campusx.smartphones
WHERE brand_name = "apple"
ORDER BY rating ASC LIMIT 1;


SELECT model,screen_size
FROM campusx.smartphones
WHERE brand_name = "samsung"
ORDER BY screen_size DESC LIMIT 5;


SELECT num_rear_cameras + num_front_cameras AS "Total_camera"
FROM campusx.smartphones
ORDER BY Total_camera DESC;

SELECT model,brand_name , SQRT(resolution_width * resolution_width + resolution_height * resolution_height ) / screen_size AS "PPI"
FROM campusx.smartphones
ORDER BY PPI DESC;

SELECT *
FROM campusx.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

SELECT * 
FROM campusx.smartphones
WHERE brand_name = "samsung"
ORDER BY rating ASC;

SELECT brand_name, model,price,rating
FROM campusx.smartphones
ORDER BY brand_name ASC,
rating ASC;

SELECT brand_name,model,price,rating
FROM campusx.smartphones
ORDER BY brand_name ASC,
price ASC;