-- SQLite
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    names VARCHAR(150) NOT NULL
);

insert into users (names) values 
    ("Nom1"),
    ("Nom2");