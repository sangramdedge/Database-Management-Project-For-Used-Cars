SELECT 
  year_built,
  car_brand,
  car_model,
  price
FROM advertisements AS ads
LEFT JOIN cars
ON ads.car_id = cars.car_id
WHERE year_built >= 2015;