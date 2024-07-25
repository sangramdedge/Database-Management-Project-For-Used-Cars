CREATE TABLE City(
	city_id int UNIQUE PRIMARY KEY NOT NUll,
	city varchar(50) NOT NULL,
	province varchar(50),
	postal_code int,
	latitude float(24),
	longitude float(24)
);

CREATE TABLE Users(
	user_id int PRIMARY KEY NOT NUll,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	phone varchar(20) NOT NULL,
	address text NOT NULL,
	city_id int NOT NULL,
	FOREIGN KEY (city_id) REFERENCES City(city_id)
);

CREATE TABLE Cars(
	car_id int PRIMARY KEY NOT NULL,
	car_brand varchar(50) NOT NULL,
	car_model varchar(50) NOT NULL,
	car_type varchar(50) NOT NULL,
	trans_type varchar(50) NOT NULL
);

CREATE TABLE Advertisements(
	ads_id int PRIMARY KEY NOT NUll,
	user_id int NOT NULL,
	car_id int NOT NULL,
	title text NOT NULL,
	posting_date date,
	year_built int NOT NULL,
	color varchar(50) NOT NULL,
	mileage int NOT NULL,
	price int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(user_id),
	FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

CREATE TABLE Bids(
	bid_id int PRIMARY KEY NOT NULL,
	user_id int NOT NULL,
	ads_id int NOT NULL,
	bid_date date,
	bid_price int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(user_id),
	FOREIGN KEY (ads_id) REFERENCES advertisements(ads_id) 
);
 
## queries 

SELECT 
  year_built,
  car_brand,
  car_model,
  price
FROM advertisements AS ads
LEFT JOIN cars
ON ads.car_id = cars.car_id
WHERE year_built >= 2015;

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



WITH bid_entry AS(
 SELECT
  car_brand,
  car_model,
  bid_date,
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS avg_price_6entry,  -- Dummy data provide randomly 6 date entry, not 6 consecutive month entry
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS avg_price_5entry,
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS avg_price_4entry,
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_price_3entry,
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS avg_price_2entry,
  AVG(bid_price) OVER(ORDER BY car_model ASC, bid_date ASC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW) AS avg_price_1entry,
  ROW_NUMBER() OVER(PARTITION BY car_model ORDER BY bid_date DESC) AS row_num
 FROM bids
 LEFT JOIN advertisements as ads
 ON bids.ads_id = ads.ads_id
 LEFT JOIN cars
 ON cars.car_id = ads.car_id
 ORDER BY car_model ASC, bid_date ASC
)
SELECT *
FROM bid_entry
WHERE row_num = 1 -- filter latest entry