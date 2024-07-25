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
