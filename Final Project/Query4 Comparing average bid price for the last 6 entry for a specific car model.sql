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