PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS tva;

CREATE TABLE tva (
    id      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    taux    INTEGER 
);

INSERT INTO tva(taux) VALUES
    (10),
    (20),
    (30);

-- SELECT * from tva;

CREATE TABLE produits (
    id      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nom     VARCHAR(100) NOT NULL UNIQUE,
    tva_id  INTEGER,
    FOREIGN KEY (tva_id) REFERENCES tva(id) ON DELETE CASCADE
);

INSERT INTO produits (nom, tva_id) VALUES
    ("Produit 1", 1),
    ("Produit 2", 2),
    ("Produit 3", 3),
    ("Produit 4", 1),
    ("Produit 5", 2),
    ("Produit 6", 3);
    
--SELECT * from produits;

--SELECT nom from produits;

SELECT nom, tva.taux 
FROM produits
JOIN tva ON tva.id = tva_id;

SELECT nom, tva.taux 
FROM produits
INNER JOIN tva ON tva.id = tva_id;

SELECT nom, tva.taux 
FROM produits
LEFT JOIN tva ON tva.id = tva_id;
