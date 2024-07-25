CREATE TABLE City(
	city_id int UNIQUE PRIMARY KEY NOT NUll,
	city varchar(50) NOT NULL,
	province varchar(50),
	postal_code int,
	latitude float(24),
	longitude float(24)
);
