-- Project for CFG
-- A music database

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

-- insert values into tables

INSERT into record_label (label_ID, label_name) VALUES (1, "Columbia Records"), (2, "Island Records"),
(3, "Aftermath Entertainment"), (4, "Neighbourhood"), (5, "Sony Music Entertainment"),
(6, "Jive Record"), (7, "Roadrunner Records");

INSERT into genre (genre_ID, genre_name) VALUES (1, "Soul"), (2, "Hip-Hop"), (3, "UK Rap"),
(4, "Pop"), (5, "Rock");

INSERT into award (award_ID, award_name) VALUES (1, "Grammy"), (2, "Billboard"),
(3, "Brit Award"), (4, "Juno Award"), (5, "Only nominated");

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

