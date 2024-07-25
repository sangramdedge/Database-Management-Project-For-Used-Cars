SELECT
  ads_id,
  car_brand,
  car_model,
  year_built,
  posting_date,
  price
FROM advertisements AS ads
LEFT JOIN cars
ON ads.car_id = cars.car_id
WHERE car_model LIKE 'Mustang'
ORDER BY price;