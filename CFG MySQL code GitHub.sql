-- Project for CFG
-- A music database

CREATE DATABASE music;
USE music;

CREATE table record_label (label_ID int NOT NULL auto_increment, label_name VARCHAR(50) NOT NULL, 
constraint PK_label primary key (label_ID));

CREATE table artist (artist_ID int NOT NULL auto_increment, artist_name VARCHAR(50) NOT NULL,
constraint PK_artist primary key(artist_ID));

CREATE table album (album_ID int NOT NULL auto_increment, album_name VARCHAR(50) NOT NULL,
artist_ID int NOT NULL, label_ID int NOT NULL,
constraint PK_album primary key(album_ID), constraint FK_artist_album foreign key (artist_ID)
REFERENCES artist (artist_ID),
constraint FK_label_album foreign key (label_ID) REFERENCES record_label (label_ID));

CREATE table song (song_ID int NOT NULL auto_increment, song_name VARCHAR(50) NOT NULL, release_year date NOT NULL,
album_ID int NOT NULL,
constraint PK_song primary key (song_ID), constraint FK_album_song foreign key (album_ID) REFERENCES album (album_ID));

CREATE table genre (genre_ID int NOT NULL auto_increment, genre_name VARCHAR(50) NOT NULL, album_ID int NOT NULL,
constraint PK_genre primary key (genre_ID), constraint FK_album_genre foreign key (album_ID)
REFERENCES album (album_ID));

-- insert artists names

INSERT INTO artist (artist_name) VALUES ("John Legend");
INSERT INTO artist (artist_name) VALUES ("Amy Winehouse");

