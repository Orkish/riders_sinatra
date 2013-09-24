CREATE TABLE riders (
id serial primary key,
name varchar(25),
age smallint,
gender varchar(6)
);

CREATE TABLE bikes (
id serial primary key,
bike_type varchar(25),
bike_material varchar(25),
rider_id serial,
FOREIGN KEY (rider_id)
	REFERENCES riders(id)
);


