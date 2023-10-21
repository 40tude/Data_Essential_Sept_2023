-- SQLite
CREATE TABLE
  users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    names VARCHAR(150) NOT NULL
  );

INSERT INTO
  users (names)
VALUES
  ("Nom1"),
  ("Nom2");