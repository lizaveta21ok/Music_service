-- albums определение

CREATE TABLE albums (
  albumId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  albumTitle VARCHAR(30) NOT NULL,
  albumCreation DATETIME NOT NULL,
  songsAmount INTEGER NOT NULL,
  isSingle BOOLEAN
);


-- genre определение

CREATE TABLE genre (
  genreId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  genreTitle VARCHAR(30) NOT NULL,
  genreDescription VARCHAR(250)
);


-- persons определение

CREATE TABLE persons (
  personId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  personName VARCHAR(30) NOT NULL,
  personEmail VARCHAR(30) NOT NULL,
  hashed_password VARCHAR(30) NOT NULL,
  dateOfRegistration datetime NOT NULL
);


-- playlists определение

CREATE TABLE "playlists" (
	"playlisId"	INTEGER NOT NULL,
	"playlistTitle"	VARCHAR(50) NOT NULL,
	"publicity"	BOOLEAN NOT NULL,
	"playlistCreation"	DATETIME,
	PRIMARY KEY("playlisId" AUTOINCREMENT)
);


-- album_genre определение

CREATE TABLE album_genre (
  albumId INTEGER NOT NULL,
  genreId INTEGER NOT NULL,
  FOREIGN KEY (albumId) REFERENCES albums (albumId),
  FOREIGN KEY (genreId) REFERENCES genre (genreId)
);


-- artist определение

CREATE TABLE artist (
  artistId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  responsiblePersonId INTEGER NOT NULL,
  artistName VARCHAR(50),
  isGroup BOOLEAN,
  FOREIGN KEY (responsiblePersonId) REFERENCES persons (personId)
);


-- artist_album определение

CREATE TABLE artist_album (
  artistId INTEGER NOT NULL,
  albumId INTEGER NOT NULL,
  FOREIGN KEY (artistId) REFERENCES artist (artistId),
  FOREIGN KEY (albumId) REFERENCES albums (albumId)
);


-- artist_genre определение

CREATE TABLE artist_genre (
  artistId INTEGER NOT NULL,
  genreId INTEGER NOT NULL,
  FOREIGN KEY (artistId) REFERENCES artist (artistId),
  FOREIGN KEY (genreId) REFERENCES genre (genreId)
);


-- groups определение

CREATE TABLE groups (
  artistId INTEGER NOT NULL PRIMARY KEY,
  creationDate DATE NOT NULL,
  description VARCHAR(2000) NOT NULL,
  FOREIGN KEY (artistId) REFERENCES artist (artistId)
);


-- listener определение

CREATE TABLE listener (
  listenerId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  personId INTEGER NOT NULL,
  subscriptionType varchar(30) NOT NULL,
  FOREIGN KEY (personId) REFERENCES persons (personId)
);


-- listener_playlist определение

CREATE TABLE listener_playlist (
  listenerId INTEGER NOT NULL,
  playlistId INTEGER NOT NULL,
  FOREIGN KEY (listenerId) REFERENCES listener (listenerId),
  FOREIGN KEY (playlistId) REFERENCES playlists (playlisId)
);


-- onePersonArtist определение

CREATE TABLE onePersonArtist (
  artistId INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  country VARCHAR(50),
  bio VARCHAR(2000),
  FOREIGN KEY (artistId) REFERENCES artist (artistId)
);


-- songs определение

CREATE TABLE songs (
	songId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	albumId INTEGER NOT NULL,
	songName VARCHAR NOT NULL,
	songDateCreation DATE NOT NULL,
	songDateAdding DATETIME,
	songDuration TIME,
	songAuthor VARCHAR,
	genreId INTEGER,
	CONSTRAINT FK_songs_albums FOREIGN KEY (albumId) REFERENCES albums(albumId),
	CONSTRAINT songs_genre_FK FOREIGN KEY (genreId) REFERENCES genre(genreId)
);


-- songTexts определение

CREATE TABLE songTexts (
  songId INTEGER NOT NULL PRIMARY KEY,
  text VARCHAR(2500) NOT NULL,
  language VARCHAR(30),
  FOREIGN KEY (songId) REFERENCES songs (songId)
);


-- artist_song определение

CREATE TABLE artist_song (
  artistId INTEGER NOT NULL,
  songId INTEGER NOT NULL,
  FOREIGN KEY (artistId) REFERENCES artist (artistId),
  FOREIGN KEY (songId) REFERENCES songs (songId)
);


-- history определение

CREATE TABLE history (
  listenerId integer NOT NULL,
  songId integer NOT NULL,
  longitudeOfListening integer NOT NULL,
  numberInListening integer NOT NULL,
  FOREIGN KEY (listenerId) REFERENCES listener (listenerId),
  FOREIGN KEY (songId) REFERENCES songs (songId)
);


-- song_playlist определение

CREATE TABLE song_playlist (
  playlistId INTEGER NOT NULL,
  songId INTEGER NOT NULL,
  FOREIGN KEY (playlistId) REFERENCES playlists (playlisId),
  FOREIGN KEY (songId) REFERENCES songs (songId)
);