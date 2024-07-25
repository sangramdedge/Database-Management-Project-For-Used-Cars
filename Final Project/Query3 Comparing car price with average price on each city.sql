SELECT 
  ads_id,
  city,
  car_brand,
  car_model,
  year_built,
  price,
  AVG(price) OVER(PARTITION BY city) AS avg_price
FROM advertisements as ads
LEFT JOIN users
ON users.user_id = ads.user_id
LEFT JOIN city
ON users.city_id = city.city_id
LEFT JOIN cars
ON ads.car_id = cars.car_id
ORDER BY car_model ASC