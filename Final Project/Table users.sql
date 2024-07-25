CREATE TABLE Users(
	user_id int PRIMARY KEY NOT NUll,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	phone varchar(20) NOT NULL,
	address text NOT NULL,
	city_id int NOT NULL,
	FOREIGN KEY (city_id) REFERENCES City(city_id)
);
