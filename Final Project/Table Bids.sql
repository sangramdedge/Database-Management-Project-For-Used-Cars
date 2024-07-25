CREATE TABLE Bids(
	bid_id int PRIMARY KEY NOT NULL,
	user_id int NOT NULL,
	ads_id int NOT NULL,
	bid_date date,
	bid_price int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(user_id),
	FOREIGN KEY (ads_id) REFERENCES advertisements(ads_id) 
);