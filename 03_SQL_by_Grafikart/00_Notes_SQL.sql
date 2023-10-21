UPDATE recipes
SET
  DATE = 100
WHERE
  id = 2;

SELECT
  COUNT(DATE)
FROM
  recipes;

-- compte les dates non NULL
-- créer une table
CREATE TABLE
  recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT DEFAULT "To be filled later" NOT NULL, -- On met NOT NULL pour que suite à un update il puisse pas être vide
    duration INT DEFAULT 15 NOT NULL,
    online BOOLEAN,
    created_at DATETIME -- timestamp sur https://www.timestamp.fr/
  );

ALTER TABLE posts
RENAME TO post;

-- renomme la table
ALTER TABLE posts RENAME title TO titre;

-- renomme une colonne
ALTER TABLE posts ADD content TEXT;

ALTER TABLE posts
DROP COLUMN content;

-- fonctionne pas
DROP TABLE posts;

-- Supprimer la table
DROP TABLE IF EXISTS recipes;

INSERT INTO
  recipes (
    title,
    slug,
    content,
    duration,
    online,
    created_at
  )
VALUES
  (
    'Soupe 100',
    'soupe',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  ),
  (
    'Soupe 200',
    'soupe',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

DELETE FROM recipes
WHERE
  title = "Soupe 100";

-- Supprime une ligne
DELETE FROM recipes
WHERE
  id = = 2;

DELETE FROM recipes;

-- Supprime tout !
UPDATE recipes
SET
  title = "Soupe de légumes"
WHERE
  title = "Soupe" -- Mise à jour d'un enregistrement
UPDATE recipes
SET
  slug = "soupe100"
WHERE
  id = = 3;

UPDATE recipes
SET
  content = NULL;

-- met tous les contenus à NULL
SELECT
  *
FROM
  recipes
WHERE
  content IS NOT NULL;

CREATE UNIQUE INDEX id_slug ON recipes (slug);

-- Créé un index
EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes
WHERE
  slug = = "soupe1000";

-- La recherche est plus efficace
PRAGMA index_list ('recipes');

-- Supprimer un index
DROP INDEX id_slug;

-- pas besoin de préciser la table l'id_slug est au niveau de la base elle même
DROP TABLE IF EXISTS categories;

-- Attention à l'ordre              
DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER,
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE RESTRICT -- Bien voir le RESTRICT
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE CASCADE  -- Bien voir le CASCADE
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL -- https://www.sqlite.org/lang_createtable.html
  );

SELECT
  *
FROM
  recipes
  JOIN categories ON recipes.category_id = categories.id;

SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  INNER JOIN categories c ON r.category_id = c.id;

-- INNER = default            
SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  LEFT JOIN categories c ON r.category_id = c.id;

SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  LEFT JOIN categories c ON r.category_id = c.id
WHERE
  c.title = "Dessert";

SELECT
  *
FROM
  recipes
  JOIN categories_recipes ON recipes.id = categories_recipes.recipe_id
  JOIN categories ON categories.id = categories_recipes.category_id;

-- Table de liaison categories_recipes
CREATE TABLE
  IF NOT EXISTS categories_recipes (
    recipe_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE, -- quand on supprime une recette faut supprimer la liaison dans la categorie
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE -- quand on supprime une catégorie faut supprimer la liaison dans la categorie
    -- la liaison recipe_id category_id doit être unique
    -- on a pas de clé primaire
    -- la combinaison recipe_id-category_id va servir de clé primaire
    PRIMARY KEY (recipe_id, category_id), -- voir table constraints dans CREATE TABLE
    UNIQUE (recipe_id, category_id)
  );

PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes;