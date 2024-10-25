---------------------------------------------------------
-- Database creation and connection
---------------------------------------------------------

DROP DATABASE IF EXISTS "FSAD2024_Records";
CREATE DATABASE "FSAD2024_Records";
\c FSAD2024_Records;


CREATE TABLE artist 
(
artistID serial PRIMARY KEY,
firstname varchar(50) NOT NULL,
lastname varchar(50)
);

CREATE TABLE genre 
(
name varchar (50) PRIMARY KEY
);

CREATE TABLE record
(
recordID serial PRIMARY KEY,
title varchar (255) NOT NULL,
label varchar (50),
artistID int REFERENCES artist(artistID) NOT NULL,
genre varchar(50) REFERENCES genre(name),
rrp decimal(6, 2) not null check(rrp > 0) -- Recommended retailer price
);


CREATE TABLE recordshop 
(
recordshopID serial PRIMARY KEY,
name varchar(50) NOT NULL,
city varchar(30), 
country varchar(30) 
);

CREATE TABLE recordcopy 
(
recordID int REFERENCES record(recordID) NOT NULL,
recordshopID int REFERENCES recordshop(recordshopID) NOT NULL,
copyID int, -- Allows for several copies in the same recordshop
digital boolean DEFAULT FALSE,
onLoan boolean DEFAULT FALSE,
PRIMARY KEY (recordID, recordshopID, copyID)
);


---------------------------------------------------------
-- Database population
---------------------------------------------------------


INSERT INTO artist (firstname,lastname) (
VALUES ('Beyonce','Beyonce'),
('Kendrick','Lamar'),
('Taylor','Swift'),
('Bob','Dylan'),
('Freddie','Mercury'),
('Wolfgang','Mozart'),
('Nina','Simone'),
('Ed','Sheeran'),
('Daft','Punk'),
('Queen','Latifah'),
('Adele','Adele'),
('Johnny','Cash'),
('Pink','Floyd'),
('David','Bowie'),
('Frank','Sinatra'),
('Metallica','Metallica'),
('Aretha','Franklin'),
('Bob','Marley'),
('Tame','Impala')
);

INSERT INTO genre (
VALUES ('Pop'), 
('Hip Hop'),
('Folk'), 
('Rock'),
('Classical'),
('Jazz'),
('Electronic'),
('Rap'),
('Soul'),
('Reggae'),
('Indie')
);


INSERT INTO record (artistID, title, label, genre, rrp)
(
VALUES (1, 'Single Ladies', 'Columbia', 'Pop', 7.99),
(1, 'Halo', 'Columbia', 'Pop', 6.99),
(1, 'Crazy in Love', 'Columbia', 'Pop', 10.99),
(1, 'Irreplaceable', 'Columbia', 'Pop', 9.99),
(1, 'Formation', 'Columbia', 'Pop', 4.99),
(1, 'Drunk in Love', 'Columbia', 'Pop', 9.99),
(1, 'Love On Top', 'Columbia', 'Pop', 5.99),
(1, 'Run the World', 'Columbia', 'Pop', 7.99),
(1, 'If I Were a Boy', 'Columbia', 'Pop', 4.99),
(1, 'Partition', 'Columbia', 'Pop', 4.99),
(2, 'HUMBLE.', 'Top Dawg Entertainment', 'Hip Hop', 5.99),
(2, 'Alright', 'Top Dawg Entertainment', 'Hip Hop', 9.99),
(2, 'DNA.', 'Top Dawg Entertainment', 'Hip Hop', 8.99),
(2, 'Swimming Pools', 'Top Dawg Entertainment', 'Hip Hop', 5.99),
(2, 'King Kunta', 'Top Dawg Entertainment', 'Hip Hop', 9.99),
(2, 'LOYALTY.', 'Top Dawg Entertainment', 'Hip Hop', 5.99),
(2, 'Money Trees', 'Top Dawg Entertainment', 'Hip Hop', 4.99),
(3, 'Shake It Off', 'Republic Records', 'Pop', 4.99),
(3, 'Love Story', 'Republic Records', 'Pop', 7.99),
(3, 'Blank Space', 'Republic Records', 'Pop', 9.99),
(3, 'You Belong with Me', 'Republic Records', 'Pop', 7.99),
(4, 'Blood on the Tracks', 'Columbia', 'Folk', 4.99),
(5, 'Bohemian Rhapsody', 'EMI', 'Rock', 5.99),
(6, 'Eine kleine Nachtmusik', 'N/A', 'Classical', 4.99),
(7, 'Feeling Good', 'Bethlehem Records', 'Jazz', 8.99),
(8, 'Shape of You', 'Asylum Records', 'Pop', 10.99),
(9, 'Get Lucky', 'Daft Life', 'Electronic', 7.99),
(10, 'U.N.I.T.Y.', 'Tommy Boy Records', 'Rap', 8.99),
(10, 'Ladies First', 'Tommy Boy Records', 'Rap', 11.99),
(11, 'Hello', 'XL Recordings', 'Pop', 12.99),
(11, 'Rolling in the Deep', 'XL Recordings', 'Pop', 15.99),
(12, 'Ring of Fire', 'Sun Records', 'Folk', 21.99),
(13, 'Another Brick in the Wall', 'Harvest Records', 'Rock', 12.99),
(13, 'Wish You Were Here', 'Harvest Records', 'Rock', 15.79),
(14, 'Space Oddity', 'Philips Records', 'Rock', 11.79),
(15, 'My Way', 'Capitol Records', 'Jazz', 12.99),
(16, 'Enter Sandman', 'Elektra Records', 'Rock', 13.79),
(17, 'Respect', 'Columbia', 'Soul', 17.80),
(18, 'One Love', 'Island Records', 'Reggae', 18.79),
(19, 'The Less I Know the Better', 'Modular Recordings', 'Indie', 19.79),
(19, 'Elephant', 'Modular Recordings', 'Indie', 20.79),
(19, 'Feels Like We Only Go Backwards', 'Modular Recordings', 'Indie', 22.55)
);


INSERT INTO recordshop (name, city, country) (
VALUES ('Amoeba Music', 'Los Angeles','USA'),
('Spillers Records', 'Cardiff','United Kingdom'),
('Diskunion Club','Tokyo','Japan'),
('The Record Store Berlin','Berlin','Germany'),
('Rough Trade East', 'London','United Kingdom'),
('Soundscapes', 'Ontario','Canada'),
('Concerto', 'Amsterdam','Netherlands'), 
('Academy Records Annex', 'Brooklyn','New York'), 
('La Cuve A Son', 'Paris','France')
);



INSERT INTO recordcopy (recordID,recordshopID,copyID,digital,onloan) (
VALUES (1,1,1,FALSE,FALSE),
(1,1,2,FALSE,FALSE),
(1,1,3,FALSE,FALSE),
(1,2,1,FALSE,TRUE),
(1,3,1,FALSE,FALSE),
(1,4,1,FALSE,FALSE),
(1,4,2,FALSE,FALSE),
--
(2,2,1,FALSE,FALSE),
(2,2,2,FALSE,FALSE),
(2,3,1,FALSE,FALSE),
(2,4,1,FALSE,TRUE),
(2,5,1,FALSE,FALSE),
(2,6,1,FALSE,FALSE),
(2,6,2,FALSE,TRUE),
(2,8,1,FALSE,FALSE),
--
(3,1,1,FALSE,FALSE),
(3,1,2,FALSE,FALSE),
(3,1,3,FALSE,FALSE),
(3,1,4,FALSE,FALSE),
(3,2,1,FALSE,FALSE),
(3,2,2,FALSE,TRUE),
(3,3,1,FALSE,FALSE),
(3,4,1,FALSE,TRUE),
(3,4,2,FALSE,FALSE),
(3,4,3,FALSE,FALSE),
(3,5,1,FALSE,NULL),
(3,5,2,NULL,NULL),
(3,6,1,NULL,FALSE),
(3,6,2,FALSE,FALSE),
(3,7,2,FALSE,FALSE),
(3,8,2,FALSE,FALSE),
(3,8,3,FALSE,TRUE),
(3,9,1,FALSE,FALSE),
(3,9,2,FALSE,FALSE),
--
(4,1,1,FALSE,FALSE),
(4,1,3,FALSE,FALSE),
(4,2,1,FALSE,FALSE),
(4,2,3,FALSE,TRUE),
(4,3,1,FALSE,FALSE),
(4,3,2,FALSE,FALSE),
(4,4,1,FALSE,FALSE),
(4,4,2,FALSE,FALSE),
(4,4,3,FALSE,FALSE),
(4,6,1,FALSE,FALSE),
(4,6,2,FALSE,FALSE),
(4,6,3,FALSE,FALSE),
(4,7,1,FALSE,FALSE),
(4,7,2,FALSE,FALSE),
(4,7,3,FALSE,TRUE),
(4,8,2,FALSE,FALSE),
(4,9,1,FALSE,FALSE),
(4,9,3,FALSE,FALSE),
--
(5,2,1,FALSE,TRUE),
(5,3,1,FALSE,FALSE),
(5,3,2,FALSE,FALSE),
(5,3,3,FALSE,FALSE),
(5,4,2,FALSE,FALSE),
(5,5,1,FALSE,TRUE),
(5,5,2,FALSE,FALSE),
(5,5,3,FALSE,FALSE),
(5,6,1,FALSE,FALSE),
(5,6,3,FALSE,FALSE),
(5,7,1,FALSE,FALSE),
(5,7,2,FALSE,FALSE),
(5,7,3,FALSE,FALSE),
(5,8,1,FALSE,FALSE),
(5,8,2,FALSE,FALSE),
(5,8,3,FALSE,TRUE),
(5,9,1,FALSE,FALSE),
(5,9,2,FALSE,FALSE),
--
(6,1,1,FALSE,FALSE),
(6,1,2,FALSE,FALSE),
(6,2,1,FALSE,FALSE),
(6,3,1,FALSE,FALSE),
(6,4,1,FALSE,FALSE),
(6,4,2,FALSE,FALSE),
(6,4,3,FALSE,TRUE),
(6,5,1,FALSE,FALSE),
(6,5,2,FALSE,FALSE),
(6,6,1,FALSE,TRUE),
(6,7,3,FALSE,FALSE),
(6,9,3,FALSE,TRUE),
--
(7,1,1,FALSE,TRUE),
(7,1,2,FALSE,FALSE),
(7,2,2,FALSE,FALSE),
(7,3,1,FALSE,FALSE),
(7,3,3,FALSE,FALSE),
(7,4,3,FALSE,FALSE),
(7,5,2,FALSE,FALSE),
(7,5,3,FALSE,FALSE),
(7,6,1,FALSE,FALSE),
(7,6,3,NULL,FALSE),
(7,7,1,FALSE,FALSE),
(7,7,2,FALSE,FALSE),
(7,7,3,FALSE,FALSE),
(7,8,1,FALSE,NULL),
(7,8,2,FALSE,NULL),
(7,9,1,FALSE,FALSE),
(7,9,2,FALSE,FALSE),
(7,9,3,FALSE,TRUE),
--
(8,1,1,FALSE,TRUE),
(8,1,2,FALSE,FALSE),
(8,2,1,FALSE,FALSE),
(8,2,2,FALSE,FALSE),
(8,2,3,FALSE,FALSE),
(8,3,1,FALSE,FALSE),
(8,3,2,FALSE,FALSE),
(8,4,2,FALSE,FALSE),
(8,4,3,FALSE,FALSE),
(8,5,1,FALSE,TRUE),
(8,5,3,FALSE,FALSE),
(8,6,1,FALSE,FALSE),
(8,6,2,FALSE,FALSE),
(8,6,3,FALSE,TRUE),
(8,7,1,FALSE,TRUE),
(8,7,2,FALSE,FALSE),
(8,8,1,FALSE,FALSE),
(8,8,2,FALSE,TRUE),
(8,9,2,FALSE,FALSE),
(8,9,3,FALSE,FALSE),
--
(9,1,1,FALSE,FALSE),
(9,1,2,FALSE,FALSE),
(9,1,3,FALSE,FALSE),
(9,2,1,FALSE,FALSE),
(9,5,3,FALSE,FALSE),
(9,6,1,FALSE,FALSE),
(9,6,2,FALSE,TRUE),
(9,6,3,FALSE,FALSE),
(9,7,2,FALSE,FALSE),
(9,8,1,FALSE,TRUE),
(9,8,2,FALSE,TRUE),
(9,8,3,FALSE,FALSE),
(9,8,4,FALSE,TRUE),
(9,8,5,FALSE,FALSE),
(9,8,6,FALSE,FALSE),
--
(10,1,1,FALSE,FALSE),
(10,1,2,FALSE,FALSE),
(10,1,3,FALSE,TRUE),
(10,2,1,NULL,FALSE),
(10,2,2,FALSE,TRUE),
(10,2,3,FALSE,FALSE),
(10,3,1,FALSE,FALSE),
(10,3,2,FALSE,FALSE),
(10,3,3,FALSE,FALSE),
(10,4,1,NULL,FALSE),
(10,4,2,FALSE,FALSE),
(10,4,3,FALSE,FALSE),
(10,5,1,FALSE,FALSE),
(10,5,2,FALSE,FALSE),
(10,5,3,FALSE,FALSE),
(10,6,1,FALSE,FALSE),
(10,6,2,FALSE,TRUE),
(10,6,3,FALSE,FALSE),
(10,7,1,FALSE,FALSE),
(10,7,2,FALSE,FALSE),
(10,7,3,FALSE,FALSE),
(10,8,1,FALSE,FALSE),
(10,8,2,FALSE,FALSE),
(10,8,3,FALSE,FALSE),
(10,9,1,FALSE,FALSE),
(10,9,2,NULL,FALSE),
(10,9,3,FALSE,FALSE),
--
(11,1,1,FALSE,TRUE),
(11,1,2,FALSE,TRUE),
(11,1,3,FALSE,TRUE),
(11,2,1,FALSE,TRUE),
(11,3,1,FALSE,TRUE),
(11,4,1,FALSE,FALSE),
(11,4,2,FALSE,FALSE),
--
(12,2,1,FALSE,FALSE),
(12,2,2,FALSE,FALSE),
(12,3,1,FALSE,FALSE),
(12,4,1,FALSE,FALSE),
(12,6,1,FALSE,FALSE),
(12,6,2,FALSE,FALSE),
(12,6,3,FALSE,FALSE),
(12,6,4,FALSE,FALSE),
(12,6,5,FALSE,FALSE),
(12,6,6,FALSE,FALSE),
--
(13,3,2,FALSE,FALSE),
(13,3,3,FALSE,FALSE),
(13,4,3,FALSE,FALSE),
(13,5,2,FALSE,FALSE),
(13,5,3,FALSE,FALSE),
(13,6,1,FALSE,FALSE),
(13,6,2,FALSE,FALSE),
(13,6,3,FALSE,FALSE),
(13,7,1,FALSE,FALSE),
(13,7,2,FALSE,FALSE),
(13,7,3,FALSE,FALSE),
(13,8,2,FALSE,FALSE),
(13,8,3,FALSE,FALSE),
(13,9,1,FALSE,FALSE),
(13,9,3,FALSE,FALSE),
--
(14,1,1,FALSE,FALSE),
(14,1,2,FALSE,FALSE),
(14,1,3,FALSE,FALSE),
(14,2,1,FALSE,FALSE),
(14,2,2,FALSE,FALSE),
(14,2,3,FALSE,FALSE),
(14,3,1,FALSE,FALSE),
(14,3,2,FALSE,FALSE),
(14,3,3,FALSE,FALSE),
(14,3,4,FALSE,FALSE),
(14,4,1,FALSE,FALSE),
(14,4,2,FALSE,FALSE),
(14,4,3,FALSE,FALSE),
(14,5,1,FALSE,FALSE),
(14,5,2,FALSE,FALSE),
(14,5,3,FALSE,FALSE),
(14,5,4,FALSE,FALSE),
(14,6,1,FALSE,FALSE),
(14,6,2,FALSE,TRUE),
(14,6,3,FALSE,FALSE),
(14,7,1,FALSE,FALSE),
(14,7,2,FALSE,FALSE),
(14,7,3,FALSE,TRUE),
(14,7,4,FALSE,FALSE),
(14,7,5,FALSE,FALSE),
(14,8,1,FALSE,FALSE),
(14,8,2,FALSE,FALSE),
(14,8,3,FALSE,TRUE),
(14,9,1,FALSE,TRUE),
(14,9,2,FALSE,FALSE),
(14,9,3,FALSE,FALSE),
--
(15,1,1,FALSE,FALSE),
(15,1,2,FALSE,FALSE),
(15,1,3,FALSE,FALSE),
(15,2,1,FALSE,FALSE),
(15,2,2,FALSE,FALSE),
(15,2,3,FALSE,FALSE),
(15,3,1,FALSE,FALSE),
(15,3,2,FALSE,FALSE),
(15,3,3,FALSE,FALSE),
(15,4,1,FALSE,FALSE),
(15,4,2,FALSE,FALSE),
(15,4,3,FALSE,FALSE),
(15,5,1,FALSE,FALSE),
(15,5,2,FALSE,FALSE),
(15,5,3,FALSE,FALSE),
(15,6,1,FALSE,FALSE),
(15,6,2,FALSE,FALSE),
(15,6,3,FALSE,FALSE),
(15,7,1,FALSE,FALSE),
(15,7,2,FALSE,FALSE),
(15,8,1,FALSE,FALSE),
(15,9,1,FALSE,FALSE),
(15,9,2,FALSE,FALSE),
(15,9,3,FALSE,FALSE),
--
(16,1,1,FALSE,FALSE),
(16,1,2,FALSE,FALSE),
(16,1,3,FALSE,FALSE),
(16,2,1,FALSE,TRUE),
(16,2,2,FALSE,FALSE),
(16,2,3,FALSE,FALSE),
(16,3,1,FALSE,FALSE),
(16,3,2,FALSE,FALSE),
(16,3,3,FALSE,TRUE),
(16,4,1,FALSE,FALSE),
(16,4,2,FALSE,FALSE),
(16,4,3,FALSE,FALSE),
(16,5,1,FALSE,FALSE),
(16,6,3,FALSE,FALSE),
(16,7,1,FALSE,FALSE),
(16,7,2,FALSE,FALSE),
(16,8,1,FALSE,FALSE),
(16,8,2,FALSE,FALSE),
(16,9,1,FALSE,FALSE),
(16,9,2,FALSE,FALSE),
(16,9,3,FALSE,FALSE),
--
(17,1,1,FALSE,FALSE),
(17,1,2,FALSE,TRUE),
(17,1,3,FALSE,FALSE),
(17,1,4,FALSE,FALSE),
(17,1,5,FALSE,FALSE),
(17,3,1,TRUE,TRUE),
(17,3,2,FALSE,FALSE),
(17,3,3,FALSE,FALSE),
(17,4,1,FALSE,FALSE),
(17,4,2,TRUE,FALSE),
(17,4,3,FALSE,FALSE),
(17,6,1,FALSE,FALSE),
(17,6,2,TRUE,FALSE),
(17,6,3,FALSE,TRUE),
(17,8,1,FALSE,TRUE),
(17,8,2,FALSE,FALSE),
(17,9,1,FALSE,FALSE),
(17,9,2,FALSE,FALSE),
(17,9,3,FALSE,FALSE),
--
(18,1,1,FALSE,FALSE),
(18,1,2,FALSE,FALSE),
(18,1,3,FALSE,FALSE),
(18,2,1,FALSE,FALSE),
(18,2,2,FALSE,FALSE),
(18,3,1,FALSE,FALSE),
(18,3,2,FALSE,FALSE),
(18,3,3,FALSE,FALSE),
(18,4,1,FALSE,FALSE),
(18,4,2,FALSE,TRUE),
(18,5,1,FALSE,FALSE),
(18,5,2,FALSE,FALSE),
(18,5,3,FALSE,TRUE),
(18,6,1,FALSE,FALSE),
(18,6,2,FALSE,FALSE),
(18,7,1,FALSE,FALSE),
(18,7,2,FALSE,FALSE),
(18,7,3,FALSE,FALSE),
(18,8,1,FALSE,FALSE),
(18,8,2,FALSE,FALSE),
(18,8,3,FALSE,TRUE),
(18,9,1,FALSE,TRUE),
(18,9,2,FALSE,FALSE),
(18,9,3,FALSE,FALSE),
--
(19,1,1,FALSE,FALSE),
(19,1,2,FALSE,FALSE),
(19,1,3,FALSE,FALSE),
(19,2,1,FALSE,FALSE),
(19,2,2,FALSE,FALSE),
(19,2,3,FALSE,FALSE),
(19,3,1,FALSE,FALSE),
(19,3,2,FALSE,FALSE),
(19,3,3,FALSE,FALSE),
(19,4,1,FALSE,FALSE),
(19,4,2,FALSE,FALSE),
(19,4,3,FALSE,FALSE),
(19,4,4,FALSE,FALSE),
(19,4,5,FALSE,FALSE),
(19,4,6,FALSE,FALSE),
(19,4,7,FALSE,FALSE),
(19,6,1,FALSE,FALSE),
(19,6,2,FALSE,FALSE),
(19,6,3,FALSE,FALSE),
(19,7,1,FALSE,FALSE),
(19,7,2,FALSE,FALSE),
(19,7,3,FALSE,FALSE),
(19,8,1,FALSE,FALSE),
(19,8,2,FALSE,FALSE),
(19,8,3,FALSE,FALSE),
(19,9,1,FALSE,FALSE),
(19,9,2,FALSE,FALSE),
(19,9,3,FALSE,FALSE),
--
(20,1,1,FALSE,FALSE),
(20,2,1,FALSE,FALSE),
(20,3,1,FALSE,FALSE),
(20,4,1,FALSE,TRUE),
(20,5,1,FALSE,FALSE),
(20,6,1,FALSE,TRUE),
(20,7,1,FALSE,FALSE),
(20,8,1,FALSE,TRUE),
(20,9,1,FALSE,TRUE),
--
(21,1,1,FALSE,FALSE),
(21,1,2,FALSE,FALSE),
(21,2,1,FALSE,FALSE),
(21,3,1,FALSE,FALSE),
(21,4,1,FALSE,FALSE),
(21,7,2,FALSE,FALSE),
--
(22,2,1,FALSE,FALSE),
(22,2,2,FALSE,FALSE),
(22,3,1,FALSE,FALSE),
(22,4,1,FALSE,FALSE),
(22,5,1,FALSE,FALSE),
(22,6,1,FALSE,FALSE),
(22,6,2,FALSE,FALSE),
(22,7,1,FALSE,FALSE),
(22,7,2,FALSE,FALSE),
(22,7,3,FALSE,FALSE),
(22,7,4,FALSE,FALSE),
(22,8,1,FALSE,FALSE),
--
(23,6,1,TRUE,FALSE),
(23,6,2,TRUE,FALSE),
--
(24,1,1,FALSE,FALSE),
(24,2,1,FALSE,FALSE),
(24,2,2,FALSE,FALSE),
(24,3,1,FALSE,FALSE),
(24,3,2,FALSE,TRUE),
(24,3,3,FALSE,FALSE),
(24,4,1,FALSE,FALSE),
(24,4,2,FALSE,FALSE),
(24,5,1,FALSE,FALSE),
(24,5,2,FALSE,FALSE),
(24,5,3,FALSE,FALSE),
(24,6,1,FALSE,FALSE),
(24,6,2,FALSE,TRUE),
(24,6,3,FALSE,TRUE),
(24,7,1,FALSE,FALSE),
(24,8,1,FALSE,FALSE),
(24,8,2,FALSE,FALSE),
(24,8,3,FALSE,FALSE),
(24,9,1,FALSE,FALSE),
--
(25,1,1,FALSE,FALSE),
(25,1,2,FALSE,FALSE),
(25,1,3,FALSE,FALSE),
(25,2,1,FALSE,FALSE),
(25,2,2,FALSE,FALSE),
(25,2,3,FALSE,FALSE),
(25,3,1,FALSE,FALSE),
(25,3,2,FALSE,FALSE),
(25,4,1,FALSE,FALSE),
(25,4,2,FALSE,FALSE),
(25,4,3,FALSE,FALSE),
(25,5,1,FALSE,FALSE),
(25,6,1,FALSE,FALSE),
(25,7,1,FALSE,FALSE),
(25,7,2,FALSE,FALSE),
(25,7,3,FALSE,FALSE),
(25,8,1,FALSE,FALSE),
(25,8,2,FALSE,FALSE),
(25,8,3,FALSE,FALSE),
(25,9,1,FALSE,FALSE),
(25,9,3,FALSE,FALSE),
--
(26,1,1,FALSE,FALSE),
(26,1,2,FALSE,FALSE),
(26,2,3,FALSE,FALSE),
(26,3,1,FALSE,FALSE),
(26,3,2,FALSE,FALSE),
(26,3,3,FALSE,FALSE),
(26,4,1,FALSE,FALSE),
(26,4,2,FALSE,FALSE),
(26,5,2,FALSE,FALSE),
(26,5,3,FALSE,FALSE),
(26,6,1,FALSE,FALSE),
(26,7,1,FALSE,FALSE),
(26,7,2,FALSE,FALSE),
(26,7,3,FALSE,FALSE),
(26,8,1,FALSE,FALSE),
(26,8,2,FALSE,FALSE),
(26,8,3,FALSE,FALSE),
(26,9,2,FALSE,FALSE),
(26,9,3,FALSE,FALSE),
--
(27,1,1,FALSE,FALSE),
(27,1,2,TRUE,FALSE),
(27,1,3,FALSE,FALSE),
(27,2,1,FALSE,FALSE),
(27,2,2,FALSE,FALSE),
(27,2,3,FALSE,FALSE),
(27,3,2,FALSE,TRUE),
(27,3,3,FALSE,FALSE),
(27,4,1,FALSE,FALSE),
(27,4,3,FALSE,TRUE),
(27,5,1,FALSE,FALSE),
(27,5,2,FALSE,FALSE),
(27,5,3,TRUE,FALSE),
(27,6,1,FALSE,FALSE),
(27,6,2,FALSE,FALSE),
(27,6,3,FALSE,FALSE),
(27,7,2,FALSE,TRUE),
(27,7,3,FALSE,FALSE),
(27,8,3,FALSE,FALSE),
(27,9,1,FALSE,FALSE),
(27,9,2,FALSE,FALSE),
(27,9,3,FALSE,FALSE),
--
(28,1,1,FALSE,FALSE),
(28,1,2,FALSE,FALSE),
(28,1,3,FALSE,FALSE),
(28,2,3,FALSE,FALSE),
(28,3,3,FALSE,TRUE),
(28,4,1,FALSE,FALSE),
(28,4,2,FALSE,TRUE),
(28,4,3,FALSE,FALSE),
(28,5,1,FALSE,TRUE),
(28,5,2,FALSE,FALSE),
(28,5,3,FALSE,FALSE),
(28,6,1,FALSE,FALSE),
(28,6,2,FALSE,FALSE),
(28,7,1,FALSE,TRUE),
(28,7,2,FALSE,TRUE),
(28,7,3,FALSE,TRUE),
(28,8,1,FALSE,TRUE),
(28,8,2,FALSE,FALSE),
(28,8,3,FALSE,FALSE),
(28,9,1,FALSE,FALSE),
(28,9,2,FALSE,TRUE),
(28,9,3,FALSE,FALSE),
--
(29,1,1,FALSE,FALSE),
(29,1,2,FALSE,FALSE),
(29,1,3,FALSE,FALSE),
(29,2,1,FALSE,FALSE),
(29,2,2,FALSE,FALSE),
(29,2,3,FALSE,TRUE),
(29,3,1,FALSE,FALSE),
(29,3,2,FALSE,FALSE),
(29,4,1,FALSE,FALSE),
(29,4,3,FALSE,FALSE),
(29,5,1,FALSE,FALSE),
(29,5,2,FALSE,FALSE),
(29,5,3,FALSE,FALSE),
(29,6,1,FALSE,FALSE),
(29,6,2,FALSE,FALSE),
(29,6,3,TRUE,FALSE),
(29,7,1,FALSE,FALSE),
(29,7,2,FALSE,FALSE),
(29,7,3,FALSE,TRUE),
(29,8,1,FALSE,FALSE),
(29,8,2,FALSE,FALSE),
(29,8,3,FALSE,TRUE),
(29,9,1,FALSE,FALSE),
(29,9,2,FALSE,FALSE),
(29,9,3,FALSE,FALSE),
--
(30,2,1,FALSE,FALSE),
(30,2,2,FALSE,TRUE),
(30,2,3,FALSE,FALSE),
(30,3,1,FALSE,FALSE),
(30,3,2,FALSE,FALSE),
(30,3,3,FALSE,FALSE),
(30,4,1,FALSE,FALSE),
(30,4,2,FALSE,FALSE),
(30,4,3,TRUE,FALSE),
(30,5,1,TRUE,FALSE),
(30,5,2,TRUE,TRUE),
(30,5,3,TRUE,FALSE),
(30,6,1,FALSE,FALSE),
(30,6,2,FALSE,FALSE),
(30,6,3,FALSE,FALSE),
(30,7,1,FALSE,FALSE),
(30,7,2,FALSE,FALSE),
(30,7,3,FALSE,FALSE),
(30,8,1,FALSE,FALSE),
(30,8,2,FALSE,FALSE),
(30,8,3,FALSE,FALSE),
(30,9,1,FALSE,FALSE),
(30,9,2,FALSE,FALSE),
--
(31,1,1,TRUE,TRUE),
(31,1,2,TRUE,TRUE),
(31,1,3,TRUE,TRUE),
(31,2,1,TRUE,TRUE),
(31,3,1,TRUE,TRUE),
(31,4,1,TRUE,TRUE),
(31,4,2,TRUE,TRUE),
--
(32,2,1,FALSE,FALSE),
(32,2,2,FALSE,FALSE),
(32,3,1,FALSE,FALSE),
(32,4,1,FALSE,FALSE),
(32,5,1,FALSE,FALSE),
(32,6,1,FALSE,FALSE),
(32,6,2,FALSE,FALSE),
(32,8,1,FALSE,FALSE),
(32,8,2,FALSE,FALSE),
(32,8,3,FALSE,FALSE),
(32,9,1,FALSE,FALSE),
(32,9,2,FALSE,FALSE),
--
(33,1,1,FALSE,FALSE),
(33,1,2,FALSE,FALSE),
(33,1,3,FALSE,FALSE),
(33,2,1,FALSE,FALSE),
(33,2,2,FALSE,FALSE),
(33,2,3,FALSE,FALSE),
(33,3,1,FALSE,FALSE),
(33,3,2,FALSE,FALSE),
(33,3,3,FALSE,FALSE),
(33,4,1,FALSE,FALSE),
(33,4,2,FALSE,FALSE),
(33,4,3,FALSE,FALSE),
(33,5,1,FALSE,FALSE),
(33,5,2,FALSE,FALSE),
(33,5,3,FALSE,FALSE),
(33,6,1,FALSE,FALSE),
(33,7,1,FALSE,FALSE),
(33,7,2,FALSE,FALSE),
(33,7,3,FALSE,FALSE),
(33,8,1,FALSE,FALSE),
(33,8,2,FALSE,FALSE),
(33,9,1,FALSE,FALSE),
(33,9,2,FALSE,FALSE),
--
(34,1,1,FALSE,FALSE),
(34,1,2,FALSE,FALSE),
(34,2,1,FALSE,FALSE),
(34,2,2,FALSE,FALSE),
(34,3,1,FALSE,FALSE),
(34,3,2,FALSE,FALSE),
(34,4,1,FALSE,FALSE),
(34,4,2,FALSE,FALSE),
(34,5,1,FALSE,FALSE),
(34,5,2,FALSE,FALSE),
(34,6,1,FALSE,FALSE),
(34,6,2,FALSE,FALSE),
(34,7,1,FALSE,FALSE),
(34,7,2,FALSE,FALSE),
(34,8,1,FALSE,FALSE),
(34,8,2,FALSE,FALSE),
(34,9,1,FALSE,FALSE),
(34,9,2,FALSE,FALSE),
--
(35,1,1,FALSE,TRUE),
(35,2,1,FALSE,TRUE),
(35,3,1,FALSE,TRUE),
(35,4,1,FALSE,TRUE),
(35,5,1,FALSE,TRUE),
(35,6,1,FALSE,TRUE),
(35,7,1,FALSE,TRUE),
(35,8,1,FALSE,TRUE),
(35,9,1,FALSE,TRUE),
--
(36,1,1,FALSE,FALSE),
(36,1,2,FALSE,TRUE),
(36,1,3,FALSE,FALSE),
(36,2,1,FALSE,FALSE),
(36,2,2,FALSE,FALSE),
(36,2,3,FALSE,FALSE),
(36,3,1,FALSE,FALSE),
(36,3,2,FALSE,TRUE),
(36,3,3,FALSE,FALSE),
(36,4,1,FALSE,FALSE),
(36,4,3,FALSE,TRUE),
(36,5,1,FALSE,FALSE),
(36,5,2,FALSE,FALSE),
(36,5,3,FALSE,FALSE),
(36,6,2,FALSE,FALSE),
(36,6,3,FALSE,FALSE),
(36,7,1,FALSE,FALSE),
(36,7,3,FALSE,FALSE),
(36,8,1,FALSE,FALSE),
(36,8,2,FALSE,FALSE),
(36,8,3,FALSE,FALSE),
(36,9,2,FALSE,FALSE),
(36,9,3,FALSE,FALSE),
--
(37,1,1,FALSE,FALSE),
(37,1,2,FALSE,FALSE),
(37,1,3,FALSE,FALSE),
(37,2,1,FALSE,FALSE),
(37,2,2,FALSE,FALSE),
(37,2,3,FALSE,TRUE),
(37,3,1,FALSE,TRUE),
(37,3,2,FALSE,FALSE),
(37,5,1,FALSE,FALSE),
(37,5,2,FALSE,FALSE),
(37,5,3,FALSE,TRUE),
(37,6,1,FALSE,FALSE),
(37,6,2,FALSE,FALSE),
(37,6,3,FALSE,TRUE),
(37,7,1,FALSE,FALSE),
(37,7,3,FALSE,FALSE),
(37,9,2,FALSE,FALSE),
(37,9,3,FALSE,FALSE),
--
(38,1,1,FALSE,FALSE),
(38,1,2,FALSE,FALSE),
(38,1,3,FALSE,FALSE),
(38,2,1,FALSE,FALSE),
(38,5,1,FALSE,FALSE),
(38,5,2,FALSE,FALSE),
(38,5,3,FALSE,FALSE),
(38,6,1,FALSE,FALSE),
(38,8,1,FALSE,FALSE),
(38,8,2,FALSE,FALSE),
(38,8,3,FALSE,FALSE),
--
(39,1,1,FALSE,FALSE),
(39,1,2,FALSE,FALSE),
(39,1,3,TRUE,FALSE),
(39,2,1,FALSE,FALSE),
(39,2,2,FALSE,FALSE),
(39,2,3,FALSE,FALSE),
(39,2,4,FALSE,FALSE),
(39,2,5,FALSE,FALSE),
(39,2,6,FALSE,FALSE),
(39,3,1,FALSE,FALSE),
(39,3,2,FALSE,FALSE),
(39,3,3,FALSE,FALSE),
(39,4,1,FALSE,FALSE),
(39,4,2,FALSE,FALSE),
(39,4,3,FALSE,FALSE),
(39,5,1,FALSE,FALSE),
(39,5,2,FALSE,FALSE),
(39,5,3,FALSE,FALSE),
(39,5,4,FALSE,FALSE),
(39,5,5,FALSE,FALSE),
(39,5,6,FALSE,FALSE),
(39,6,1,FALSE,FALSE),
(39,6,2,FALSE,FALSE),
(39,6,3,FALSE,TRUE),
(39,6,4,TRUE,TRUE),
(39,6,5,TRUE,FALSE),
(39,7,1,FALSE,FALSE),
(39,7,2,FALSE,FALSE),
(39,7,3,FALSE,FALSE),
(39,8,1,FALSE,FALSE),
(39,8,2,FALSE,TRUE),
(39,8,3,FALSE,FALSE),
(39,9,1,FALSE,FALSE),
(39,9,2,FALSE,FALSE),
(39,9,3,FALSE,FALSE),
(39,9,4,FALSE,FALSE),
(39,9,5,FALSE,FALSE),
--
(40,1,1,FALSE,FALSE),
(40,1,2,FALSE,FALSE),
(40,1,3,FALSE,FALSE),
(40,1,4,FALSE,FALSE),
(40,2,1,FALSE,FALSE),
(40,2,2,FALSE,FALSE),
(40,2,3,FALSE,FALSE),
(40,3,1,FALSE,FALSE),
(40,3,2,FALSE,FALSE),
(40,3,3,FALSE,FALSE),
(40,4,1,FALSE,FALSE),
(40,4,2,FALSE,FALSE),
(40,4,3,FALSE,FALSE),
(40,5,1,FALSE,FALSE),
(40,5,2,FALSE,FALSE),
(40,5,3,FALSE,FALSE),
(40,6,1,FALSE,FALSE),
(40,6,2,FALSE,FALSE),
(40,6,3,FALSE,FALSE),
(40,6,4,FALSE,FALSE),
(40,7,1,FALSE,FALSE),
(40,7,2,FALSE,FALSE),
(40,8,1,FALSE,FALSE),
(40,8,2,FALSE,FALSE),
(40,8,3,FALSE,FALSE),
(40,8,4,FALSE,FALSE),
(40,9,1,FALSE,FALSE),
(40,9,2,FALSE,FALSE),
(40,9,3,FALSE,FALSE),
--
(41,1,1,FALSE,FALSE),
(41,1,2,FALSE,FALSE),
(41,1,3,FALSE,FALSE),
(41,2,1,FALSE,FALSE),
(41,2,2,FALSE,FALSE),
(41,2,3,FALSE,FALSE),
(41,3,1,FALSE,FALSE),
(41,3,2,FALSE,FALSE),
(41,3,3,FALSE,FALSE),
(41,4,1,FALSE,FALSE),
(41,4,2,TRUE,FALSE),
(41,4,3,TRUE,FALSE),
(41,5,1,TRUE,FALSE),
(41,5,2,FALSE,FALSE),
(41,5,3,TRUE,FALSE),
(41,5,4,FALSE,FALSE),
(41,6,1,FALSE,FALSE),
(41,9,1,FALSE,FALSE),
(41,9,2,FALSE,FALSE),
(41,9,3,FALSE,FALSE),
--
(42,1,1,FALSE,FALSE),
(42,1,2,FALSE,FALSE),
(42,1,3,FALSE,FALSE),
(42,2,1,FALSE,FALSE),
(42,2,2,FALSE,FALSE),
(42,2,3,FALSE,FALSE),
(42,3,1,FALSE,FALSE),
(42,3,2,TRUE,TRUE),
(42,3,3,TRUE,TRUE),
(42,4,2,FALSE,TRUE),
(42,4,3,FALSE,FALSE),
(42,5,1,FALSE,FALSE),
(42,5,2,FALSE,FALSE),
(42,5,3,FALSE,FALSE),
(42,6,1,FALSE,FALSE),
(42,7,1,FALSE,FALSE),
(42,7,2,FALSE,FALSE),
(42,7,3,FALSE,FALSE),
(42,8,1,FALSE,FALSE),
(42,8,2,FALSE,FALSE),
(42,8,3,FALSE,FALSE),
(42,9,1,FALSE,TRUE),
(42,9,2,FALSE,FALSE),
(42,9,3,FALSE,FALSE)
);
