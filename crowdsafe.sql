DROP DATABASE IF EXISTS crowdsafeDB;

CREATE DATABASE crowdsafeDB;
USE crowdsafeDB;

CREATE TABLE user(
    user_id varchar(10),
    username varchar(20), /*tentative*/
    primary key(user_id)
);

CREATE TABLE location(
    location_id varchar(10),
    location_name varchar(65),
    address varchar(65),
    latitude double,
    longitude double,
    primary key(location_id)
);

CREATE TABLE visits(
    user_id varchar(10),
    location_id varchar(10),
    time_visited datetime,
    primary key(user_id, location_id),
    foreign key(user_id) references user(user_id) on update cascade on delete cascade
);

CREATE TABLE leaves(
    user_id varchar(10),
    location_id varchar(10),
    time_left datetime,
    primary key(user_id, location_id),
    foreign key(user_id) references user(user_id) on update cascade on delete cascade
);

INSERT INTO location (location_id, location_name, address, latitude, longitude) VALUES
    ("LOC0", "National Water Commission Collections Dept", "4 Marescaux Rd, Kingston", 17.991606910203775, -76.78519997609531),
    ("LOC1", "Students' Loan Bureau", "Sagicor Sigma Building 63-67, 5 Knutsford Blvd, Kingston", 18.00663598885496, -76.78669102883579),
    ("LOC2", "Macau Gaming Lounge & Bar", "28 Lindsay Crescent, Kingston", 18.02678195222603, -76.80260228279565),
    ("LOC3", "HiLo Supermarket", "Old Hope Rd, Kingston", 17.9956393157131, -76.78747059325401);