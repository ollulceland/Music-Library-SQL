-- Project for CFG
-- A music database

-- Q1) Create 8 tables

CREATE DATABASE music;
USE music;

CREATE table record_label (label_ID int NOT NULL, label_name VARCHAR(50) NOT NULL, 
constraint PK_label primary key (label_ID));

CREATE table genre (genre_ID int NOT NULL, genre_name VARCHAR(50) NOT NULL,
constraint PK_genre primary key (genre_ID));

CREATE table award (award_ID int NOT NULL, award_name VARCHAR(50),
constraint PK_award_ID primary key (award_ID));

CREATE table artist (artist_ID int NOT NULL, artist_name VARCHAR(50) NOT NULL,
constraint PK_artist primary key(artist_ID));

CREATE table album (album_ID int NOT NULL, album_name VARCHAR(50) NOT NULL,
artist_ID int NOT NULL, label_ID int NOT NULL, genre_ID int NOT NULL, award_ID int NULL,
constraint PK_album primary key (album_ID), constraint FK_artist_album foreign key (artist_ID)
REFERENCES artist (artist_ID),
constraint FK_album_label foreign key (label_ID) REFERENCES record_label (label_ID),
constraint FK_album_genre foreign key (genre_ID) REFERENCES genre (genre_ID),
constraint FK_album_award foreign key (award_ID) REFERENCES award (award_ID));

CREATE table song (song_ID int NOT NULL, song_name VARCHAR(50) NOT NULL, album_ID int NOT NULL,
constraint PK_song primary key (song_ID), constraint FK_album_song foreign key (album_ID)
REFERENCES album (album_ID));

CREATE table album_price (album_ID int NOT NULL, price decimal(5,2),
constraint PK_album primary key (album_ID), constraint FK_album_price foreign key (album_ID)
REFERENCES album (album_ID));

CREATE table album_release_year (album_ID int NOT NULL, release_year year,
constraint PK_album primary key (album_ID), constraint FK_album_release foreign key (album_ID)
REFERENCES album (album_ID));

-- Q2) insert values into tables

INSERT into record_label (label_ID, label_name) VALUES (1, "Columbia Records"), (2, "Island Records"),
(3, "Aftermath Entertainment"), (4, "Neighbourhood"), (5, "Sony Music Entertainment"),
(6, "Jive Record"), (7, "Roadrunner Records");

INSERT into genre (genre_ID, genre_name) VALUES (1, "Soul"), (2, "Hip-Hop"), (3, "UK Rap"),
(4, "Pop"), (5, "Rock");

INSERT into award (award_ID, award_name) VALUES (1, "Grammy"), (2, "Billboard"),
(3, "Brit Award"), (4, "Juno Award"), (5, null);

INSERT INTO artist (artist_ID, artist_name) VALUES (1, "50 Cent"), (2, "Amy Winehouse"), (3, "Britney Spears"),
(4, "Dave"), (5, "John Legend"),(6, "Journey"), (7, "Michael Jackson"), (8, "Nickleback");

INSERT into album (album_ID, album_name, artist_ID, label_ID, genre_ID, award_ID) VALUES
(1, "Love in the Future", 5, 1, 1, 5), (2, "Back to Black", 2, 2, 1, 1), (3, "Get Rich or Die Tryin'", 1, 3, 2, 2),
(4, "Psychodrama", 4, 4, 3, 3), (5, "Bad", 7, 5, 4, 1), (6, "In the Zone", 3, 6, 4, 2),
(7, "All the Right Reasons", 8, 7, 5, 4), (8, "Escape", 6, 1, 5, 5);

INSERT into song (song_ID, song_name, album_ID) VALUES (1, "All of Me", 1),
(2, "Rehab", 2), (3, "Many Men", 3), (4, "Location", 4), (5, "Smooth Criminal", 5), (6, "Toxic", 6),
(7, "Rockstar", 7), (8, "Don't Stop Belivin'", 8);

INSERT into album_price (album_ID, price) VALUES (1, 8.99), (2, 11.99), (3, 7.99), (4, 8.99),
(5, 12.99), (6, 9.99), (7, 6.99), (8, 6.99);

INSERT into album_release_year (album_ID, release_year) VALUES (1, 2013), (2, 2006), (3, 2003), (4, 2019),
(5, 1987), (6, 2003), (7, 2005), (8, 1981);

-- Q3) join tables

-- join artist name with album

SELECT art.artist_name, al.album_name
FROM artist art
LEFT JOIN album al
ON art.artist_ID = al.artist_ID;

-- join artists with album and release year ascending order

SELECT art.artist_name, al.album_name, r.release_year
FROM artist art
LEFT JOIN album al
ON art.artist_ID = al.artist_ID
LEFT JOIN album_release_year r
ON al.album_ID = r.album_ID
ORDER BY release_year asc;


-- Q4) Create a stored function
-- add price rate to album prices, show album name price and price rate

DELIMITER //
CREATE FUNCTION price_range(
    price DECIMAL
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE rate VARCHAR(20);
    IF price > 10.99 THEN
        SET rate = 'HIGH';
    ELSEIF price >= 8.99 AND price <= 10.99 THEN
        SET rate = 'MEDIUM';
    ELSEIF price < 8.99 THEN
        SET rate = 'LOW';
    END IF;
    RETURN (rate);
END//
DELIMITER ;

SELECT pr.album_ID, al.album_name, price, price_range(price)
FROM album_price pr
LEFT JOIN album al
ON al.album_ID = pr.album_id
ORDER BY price desc;

-- drop function price_range;


-- Q5) subquery
-- select only the Grammy winning albums

SELECT art.artist_name, al.album_name, aw.award_name
FROM artist art
LEFT JOIN album al
ON art.artist_ID = al.artist_ID
LEFT JOIN award aw
ON al.award_ID = aw.award_ID
WHERE award_name IN (
SELECT award_name FROM award WHERE award_name = "Grammy");

-- artist name, album name and any awards (subquery and order by)

SELECT art.artist_name, al.album_name, aw.award_name
FROM artist art
LEFT JOIN album al
ON art.artist_ID = al.artist_ID
LEFT JOIN award aw
ON al.award_ID = aw.award_ID
ORDER BY album_name asc;

-- select albums that won an award, not just nominated

SELECT art.artist_name, al.album_name, aw.award_name
FROM artist art
LEFT JOIN album al
ON art.artist_ID = al.artist_ID
LEFT JOIN award aw
ON al.award_ID = aw.award_ID
WHERE aw.award_ID != "5";

-- Q6) Download screenshot of EER diagram

-- Q7) Create stored pocedure and show how it runs
-- insert new artist id and name into artist table

SELECT * FROM artist;

DELIMITER //
-- Create Stored Procedure
CREATE PROCEDURE InsertValue(
IN artist_id INT,
IN artist_name VARCHAR(50))

BEGIN
INSERT INTO artist(artist_id, artist_name)
VALUES (artist_ID, artist_name);
END//

DELIMITER ;
CALL InsertValue (9, 'Adele');

SELECT * FROM artist;
-- SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM artist WHERE artist_name = "Adele"


-- Q8) In your database, create a trigger and demonstrate how it runs
-- capitalise all letters in any artist names entered into tables

SELECT * FROM artist;
DELIMITER //

CREATE TRIGGER Before_Insert
BEFORE INSERT on artist
FOR EACH ROW
BEGIN
    SET NEW.artist_name = UPPER(NEW.artist_name);
END//
DELIMITER ;
INSERT INTO artist (artist_ID, artist_name)
VALUES (10, "drake");

SELECT * FROM artist;
-- drop trigger before_insert;


-- Q9) Create an event and demonstrate how it works ??????

SET GLOBAL event_scheduler = ON; -- enable event scheduler.
USE music;

CREATE TABLE monitoring_release_year
(ID INT NOT NULL AUTO_INCREMENT,
Last_Update TIMESTAMP,
PRIMARY KEY (ID));
INSERT INTO monitoring_release_year (id, last_update)
VALUES
	(1,now());
DELIMITER //

CREATE EVENT myevent
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 10 second
DO begin
      UPDATE music.monitoring_release_year SET Last_update = Last_update + 10;
show events from monitoring_release_year;
END//
DELIMITER ;
-- Select data again after 10 seconds
SELECT * FROM monitoring_release_year;

-- DROP TABLE monitoring_release_year;      
-- DROP EVENT myevent;


-- Q10) Create a view that uses at least 3-4 base tables (hmm...)
-- Create view showing all pre2010 albums that cost at least £7.99

CREATE VIEW pre2010 AS
SELECT art.artist_name, al.album_name, res.release_year, pr.price
FROM artist art
LEFT JOIN album al
ON art.artist_id = al.artist_id
LEFT JOIN album_release_year res
ON al.album_id = res.album_id
LEFT JOIN album_price pr
ON al.album_id = pr.album_id
WHERE release_year < 2010
AND price >= 7.99
ORDER BY price desc;

SELECT * FROM music.pre2010;


-- Q11) Use a group by query
-- count number of albums under each genre (count albums in each genre), order by count size

SELECT genre_name, COUNT(album_ID) AS Count
FROM album al
LEFT JOIN genre gen
ON al.genre_ID = gen.genre_ID
GROUP BY genre_name 
HAVING Count >= 1
ORDER BY Count desc;

