/*
Commentaires sur plrs lignes
 */
-- Commentaire sur une ligne
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 01 : Qu'est ce que le SQL ?
-- Voir le fichier OneNote
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 02 : Démarrer avec SQLite sur VSCode
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 03 : Démarrer avec SQLite dans le terminal
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 04 : Démarrer avec SQLite sur TablePlus
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- 05 : Créer sa première table
-- Pas oublier les ';' en fin de commande
CREATE TABLE
  posts (
    title VARCHAR(150),
    content TEXT,
    category VARCHAR(50),
    create_at DATETIME
  );

-- Fonctionne pas
ALTER TABLE posts
DROP content;

-- Fonctionne pas non plus
ALTER TABLE posts
DROP COLUMN content;

-- Je m'en sors dans le terminal en lancant sqlite3 et en tapant
ALTER TABLE posts
DROP content;

-- À vérifier
ALTER TABLE posts ADD content TEXT;

-- Renomme la table
ALTER TABLE posts
RENAME TO post;

ALTER TABLE post
RENAME TO posts;

-- Renomme une colonne
ALTER TABLE posts RENAME title TO titre;
ALTER TABLE posts RENAME titre TO title;

-- Supprimer la table
DROP TABLE posts;

-- datatype :  https://www.sqlite.org/datatype3.html
CREATE TABLE
  recipes (
    title VARCHAR(150),
    slug VARCHAR(50),
    content TEXT,
    duration INT,
    online BOOLEAN,
    create_at DATETIME
  );

ALTER TABLE recipes RENAME create_at TO created_at;

-- A tester
-- https://alvinalexander.com/android/sqlite-default-datetime-field-current-time-now/
-- last_update fonctionne pas comme je veux
-- Faut peut être un trigger quand on va faire un update
CREATE TABLE
  projects (
    _id INTEGER PRIMARY key autoincrement,
    name text NOT NULL,
    description text,
    date_created datetime DEFAULT CURRENT_TIMESTAMP,
    last_updated datetime DEFAULT CURRENT_TIMESTAMP
  );

INSERT INTO
  projects (name, description)
VALUES
  ('Project 1', 'Next excellent project');

-- lire https://www.sqlite.org/lang_insert.html
-- Pour le timestamp voir : https://www.timestamp.fr/
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
    'Soupe',
    'soupe',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

-- Ajout de 2 lignes en même temps
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

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 06 : SELECT, UPDATE & INSERT
SELECT
  title,
  duration
FROM
  recipes;

SELECT
  *
FROM
  recipes
WHERE
  duration < 20;

-- Lire doc des expression sur https://www.sqlite.org/lang_select.html
SELECT
  *
FROM
  recipes
WHERE
  duration BETWEEN 25 AND 35;

SELECT
  *
FROM
  recipes
WHERE
  slug IN ('soupe', 'zoubida', 'meat');

SELECT
  *
FROM
  recipes
WHERE
  slug != 'soupe';

SELECT
  *
FROM
  recipes
WHERE
  slug = = 'soupe'
  AND duration <= 10;

-- ILIKE insensible à la casse
SELECT
  *
FROM
  recipes
WHERE
  slug LIKE 'salade%';

SELECT
  *
FROM
  recipes
WHERE
  slug LIKE '%oup%';

DELETE FROM recipes
WHERE
  title = = "Soupe 200";

DELETE FROM recipes
WHERE
  title = "Soupe 100";

-- DELETE FROM recipes;                          -- Supprime tout !
-- UPDATE
UPDATE recipes
SET
  title = "Soupe de légumes"
WHERE
  title = "Soupe";

SELECT
  *
FROM
  recipes;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 07 : Clés primaires et index
-- Clé primaire
DROP TABLE recipes;

CREATE TABLE
  recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150),
    slug VARCHAR(50),
    content TEXT,
    duration INT,
    online BOOLEAN,
    created_at DATETIME
  );

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
  id = = 2;

-- Les Id sont 3 et 4
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

EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes;

EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes
WHERE
  title = = 'Soupe';

EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes
WHERE
  id = = 3;

-- Création d'un index sur les slugs
SELECT
  *
FROM
  recipes;

UPDATE recipes
SET
  slug = "soupe100"
WHERE
  id = = 3;

UPDATE recipes
SET
  slug = "soupe300"
WHERE
  id = = 4;

SELECT
  *
FROM
  recipes;

-- les slugs sont uniques
CREATE UNIQUE INDEX id_slug ON recipes (slug);

SELECT
  *
FROM
  recipes;

-- On voit rien dans la table MAIS on peut plus insérer une ligne avec un slug qui existe déjà
-- Fonctionne pas
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
    'Soupe 1000',
    'soupe100',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

-- Fonctionne
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
    'Soupe 1000',
    'soupe1000',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

-- La recherche est plus efficace
EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recipes
WHERE
  slug = = "soupe1000";

-- Supprimer un index
PRAGMA index_list ('recipes');

-- pas besoin de préciser la table l'id_slug est au niveau de la base elle même
DROP INDEX id_slug;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 08 : La valeur NULL
-- On insère mais on oublie le slug
INSERT INTO
  recipes (title, content, duration, online, created_at)
VALUES
  (
    'Soupe 10 000',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

SELECT
  *
FROM
  recipes;

-- Y a NULL dans le slug
-- Si on veut interdire ce cas il faut donner des contrainte lors de la création
DROP TABLE recipes;

-- Dans create table voir column constraint 
-- CREATE TABLE recipes(
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   title VARCHAR(150), 
--   slug VARCHAR(50),
--   content TEXT,
--   duration INT,
--   online BOOLEAN,
--   created_at DATETIME
-- );
CREATE TABLE
  recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    duration INT,
    online BOOLEAN,
    created_at DATETIME
  );

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
    'Soupe 10 000',
    'soupe10000',
    'Test de contenu',
    10,
    FALSE,
    1690978150
  );

INSERT INTO
  recipes (title, slug, duration, online, created_at)
VALUES
  ('Soupe 1', 'soupe1', 10, FALSE, 1690978150);

-- Utilisable dans les requêtes
SELECT
  *
FROM
  recipes
WHERE
  content IS NULL;

SELECT
  *
FROM
  recipes
WHERE
  content IS NOT NULL;

-- met tous les contenus à NULL
UPDATE recipes
SET
  content = NULL;

-- Valeur par defaut
-- On met NOT NULL pour que suite à un update il puisse pas être vide
DROP TABLE recipes;

CREATE TABLE
  recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT DEFAULT "To be filled later" NOT NULL,
    duration INT DEFAULT 15 NOT NULL,
    online BOOLEAN,
    created_at DATETIME
  );

INSERT INTO
  recipes (title, slug, online, created_at)
VALUES
  ('Soupe 1', 'soupe1', FALSE, 1690978150);

-- DELETE FROM recipes WHERE id == 1;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 9 : Clés étrangères et jointures
PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

INSERT INTO
  categories (title, description)
VALUES
  ("Plat", "Description du plat"),
  ("Dessert", "Description du dessert");

-- V1
-- CREATE TABLE IF NOT EXISTS recipes (
--   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--   title VARCHAR(150) NOT NULL,
--   slug VARCHAR(50) NOT NULL UNIQUE,
--   content TEXT,
--   category_id INTEGER
-- );
-- V2
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories (id) -- https://www.sqlite.org/lang_createtable.html
  );

INSERT INTO
  recipes (title, slug, category_id) -- pas de content
VALUES
  ("Crème", "creme", 2),
  ("Soupe", "soupe", 1),
  ("Salade de fruits", "salade_fruits", 2);

-- si on met 3 c'est une erreur mais ça passe
-- ajouter une contrainte (voir V2)
SELECT
  *
FROM
  recipes;

SELECT
  *
FROM
  recipes
  JOIN categories ON recipes.category_id = categories.id;

SELECT
  *
FROM
  recipes r
  JOIN categories c ON r.category_id = c.id;

-- utilise des alias r et c
SELECT
  r.id,
  r.title,
  c.title
FROM
  recipes r
  JOIN categories c ON r.category_id = c.id;

SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  JOIN categories c ON r.category_id = c.id;

-- Pour parler des contraintes sur le JOIN
PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
DROP TABLE IF EXISTS categories;

-- Bug. Si besoin, executer cette ligne puis tout relancer
DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

INSERT INTO
  categories (title, description)
VALUES
  ("Plat", "Description du plat"),
  ("Dessert", "Description du dessert");

CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER, -- Bien voir que NULL est possible
    FOREIGN KEY (category_id) REFERENCES categories (id) -- https://www.sqlite.org/lang_createtable.html
  );

INSERT INTO
  recipes (title, slug, category_id) -- pas de content
VALUES
  ("Crème", "creme", 2),
  ("Soupe", "soupe", 1),
  ("Salade de fruits", "salade_fruits", NULL);

-- Voir le NULL
-- LIRE : https://www.diffen.com/difference/Inner_Join_vs_Outer_Join
-- Par défaut le JOIN est un INNER JOIN 
-- Penser à 2 ensembles avec une intersection au milieu
-- On ne retient par défaut que l'intersection
-- Qu'est-ce qui se passe si une recette n'a pas de catégorie ?
-- Exemple Salade de fruits avec une catégorie NULL (pas de catégorie)
-- Quand dans la recette il n'y a pas de catégorie, il ne la retient pas
-- Il ne retient dans la table de gauche que les éléments qui sont joints à la table de droite
-- Il ne va afficher que 2 lignes sur 3
SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  JOIN categories c ON r.category_id = c.id;

SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  INNER JOIN categories c ON r.category_id = c.id;

-- INNER = default            
-- Un LEFT JOIN ou OUTER JOIN selectionne les éléments qui ont une liaison ainsi que ceux qui 
-- n'en ont pas
-- Avec les ensembles il retient tous les éléments de l'ensemble de gauche (le premier nommé , recipes)
-- ainsi que les éléments de l'intersection
-- Il va afficher 3 lignes
SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  LEFT JOIN categories c ON r.category_id = c.id;

-- Dans d'autres bases il existe le RIGHT JOIN
-- Qu'est ce qui se passe si on supprime une catégorie ?
PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
DROP TABLE IF EXISTS categories;

-- Bug. Si besoin, executer cette ligne puis tout relancer
DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

INSERT INTO
  categories (title, description)
VALUES
  ("Plat", "Description du plat"),
  ("Dessert", "Description du dessert");

CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER, -- Bien voir que NULL est possible
    FOREIGN KEY (category_id) REFERENCES categories (id) -- https://www.sqlite.org/lang_createtable.html
  );

INSERT INTO
  recipes (title, slug, category_id) -- pas de content
VALUES
  ("Crème", "creme", 2),
  ("Soupe", "soupe", 1),
  ("Salade de fruits", "salade_fruits", 2);

DELETE FROM categories
WHERE
  id = 2;

SELECT
  *
FROM
  recipes;

-- bizarre on voit toujours les categories 2
SELECT
  *
FROM
  categories;

-- alors qu'elles ne sont plus dans la base categories
-- Faut ajouter des contraintes au niveau de FOREIGN KEY
-- Voir ON DELETE, ON UPDATE dans la partie foreign key 
-- On les retrouve dans la partie CREATE TABLE
-- Par defaut c'est NO ACTION
-- RESTRICT interdit la suppression si la clé est utilisée
-- SET NULL
-- SET DEFAULT
-- CASCADE : supprime la catégorie 2 ainsi que les recettes de la catégorie en question
PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
DROP TABLE IF EXISTS categories;

-- Bug. Si besoin, executer cette ligne puis tout relancer
DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

INSERT INTO
  categories (title, description)
VALUES
  ("Plat", "Description du plat"),
  ("Dessert", "Description du dessert");

CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER,
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE RESTRICT -- Bien voir le RESTRICT
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE CASCADE  -- Bien voir le CASCADE
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
  );

INSERT INTO
  recipes (title, slug, category_id) -- pas de content
VALUES
  ("Crème", "creme", 2),
  ("Soupe", "soupe", 1),
  ("Salade de fruits", "salade_fruits", 2);

DELETE FROM categories
WHERE
  id = 2;

SELECT
  *
FROM
  recipes;

-- Le ON UPDATE peut être utile si on a pas lié sur une clé primaire mais sur un champ qui peut être modifié
-- Comment récupérer les recettes qui sont dans la catégorie dessert ?
PRAGMA foreign_keys = ON;

-- spécifique SQLite (voir doc)
DROP TABLE IF EXISTS categories;

-- Bug. Si besoin, executer cette ligne puis tout relancer
DROP TABLE IF EXISTS recipes;

CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT
  );

INSERT INTO
  categories (title, description)
VALUES
  ("Plat", "Description du plat"),
  ("Dessert", "Description du dessert");

CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER,
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE RESTRICT -- Bien voir le RESTRICT
    -- FOREIGN KEY (category_id) REFERENCES categories(id)  ON DELETE CASCADE  -- Bien voir le CASCADE
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
  );

INSERT INTO
  recipes (title, slug, category_id) -- pas de content
VALUES
  ("Crème", "creme", 2),
  ("Soupe", "soupe", 1),
  ("Salade de fruits", "salade_fruits", 2);

-- DELETE FROM categories WHERE id = 2;
-- SELECT * from recipes;  
SELECT
  r.id,
  r.title,
  c.title AS "Catégorie"
FROM
  recipes r
  LEFT JOIN categories c ON r.category_id = c.id
WHERE
  c.title = "Dessert";

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 10 : Schématiser avec les MCD & MLD
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 11 : TP Conversion du MLD
-- On supprime et on recréé un fichier db.sqlite
-- Clic droit sur le nom de fichier et "Open Database" pour afficher SQL Explorer
-- Créer les requêtes pour le MLD précédent
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

SELECT
  *
FROM
  recipes;

-- On ajoute des colonnes avec une jointure
-- On ajoute le contenu de la table categories_recipes
-- Quand l'id de recipes correspond au recipe_id de categories_recipes
SELECT
  *
FROM
  recipes
  JOIN categories_recipes ON categories_recipes.recipe_id = recipes.id;

-- même chose mais je trouve plus facile à relire
SELECT
  *
FROM
  recipes
  JOIN categories_recipes ON recipes.id = categories_recipes.recipe_id;

-- On peut avoir plus d'une jointure
SELECT
  *
FROM
  recipes
  JOIN categories_recipes ON recipes.id = categories_recipes.recipe_id
  JOIN categories ON categories.id = categories_recipes.category_id;

SELECT
  recipes.title,
  categories.title AS "category"
FROM
  recipes
  JOIN categories_recipes ON recipes.id = categories_recipes.recipe_id
  JOIN categories ON categories.id = categories_recipes.category_id;

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf");

--CREATE TABLE IF NOT EXISTS ingredients_recipes (
--  recipe_id     INTEGER NOT NULL,
--  ingredient_id INTEGER NOT NULL,
--  quantity      INTEGER,
--  unit          VARCHAR (20),
--  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,         -- quand on supprime une recette faut supprimer l'entrée associée dans la table de liaison
--  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE, -- quand on supprime un ingrédient d'une recette faut supprimer l'entrée associée dans la table de liaison
--  PRIMARY KEY (recipe_id, ingredient_id),
--  UNIQUE (recipe_id, ingredient_id)
--);
-- Z! Z! C'est pas une bonne idée de mettre des commentaires (longs?) dans une requête
CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"), -- "g" se repette? On aurait dû faire une table avec les unités
  (2, 2, 200, "g"),
  (2, 3, 8, "g"), -- Y a une erreur volontaire ici (3, 2... au lieu de (2, 3...
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL);

-- NULL car pas d'unité 
-- Retrouver les recettes où il y a des oeufs
SELECT
  *
FROM
  ingredients
WHERE
  name = "Oeuf";

SELECT
  *
FROM
  ingredients
WHERE
  ingredients.name = "Oeuf";

SELECT
  *
FROM
  ingredients
  JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients.name = "Oeuf";

SELECT
  *
FROM
  ingredients
  JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  ingredients.name = "Oeuf";

SELECT
  recipes.title AS "Recette avec des oeufs"
FROM
  ingredients
  JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  ingredients.name = "Oeuf";

-- Retrouver les recettes où il n'y a pas d'ingrédient
SELECT
  *
FROM
  recipes;

SELECT
  *
FROM
  recipes
  JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id;

-- clé etrangère = id sur la table ciblée
SELECT
  *
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id;

SELECT
  *
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  ingredients_recipes.recipe_id IS NULL;

SELECT
  *
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  recipe_id IS NULL;

SELECT
  recipes.title AS "Recettes sans ingrédient"
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  ingredients_recipes.recipe_id IS NULL;

-- -------------------------------------------- --
-- -------------------------------------------- --
--         RELECTURE POUR CHEAT SHEET           --
-- -------------------------------------------- --
-- -------------------------------------------- --
-- Etablir la liste des ingrédients d'une recette
SELECT
  *
FROM
  recipes
  JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id;

-- Mettre à jour une des quantités
-- Le second JOIN permet d'accéder au nom de l'ingrédient
-- On commence par afficher la recette avec ses ingrédients
SELECT
  recipes.title,
  ingredients_recipes.quantity,
  ingredients_recipes.unit,
  ingredients.name AS "Ingrédient"
FROM
  recipes
  JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id;

UPDATE ingredients_recipes
SET
  quantity = 10
WHERE
  recipe_id = 2
  AND ingredient_id = 3;

-- pas de clé primaire simple, faut préciser les 2
-- Montre que la quantité a bien été mise à jour
SELECT
  recipes.title,
  ingredients_recipes.quantity,
  ingredients_recipes.unit,
  ingredients.name AS "Ingrédient"
FROM
  recipes
  JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id;

-- Afficher une recette avec la liste des ingrédients
-- Voir une solution plus haut
SELECT
  *
FROM
  recipes
WHERE
  id = 2;

-- On fait pas un double left join depuis les recettes (trop lourd, moins efficace)
-- On part de la table de liaison ingredients_recipes
SELECT
  *
FROM
  ingredients_recipes;

SELECT
  *
FROM
  ingredients_recipes
  JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id -- clé étrangère puis clé primaire
WHERE
  ingredients_recipes.recipe_id = 2;

SELECT
  ingredients_recipes.quantity,
  ingredients_recipes.unit,
  ingredients.name
FROM
  ingredients_recipes
  JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id -- clé étrangère puis clé primaire
WHERE
  ingredients_recipes.recipe_id = 2;

-- Supprimer la levure chimique
-- Voir ingredients_recipes = 3 à la ligne 3
SELECT
  *
FROM
  ingredients_recipes;

DELETE FROM ingredients
WHERE
  id = 3;

-- La levure est toujours dans la table ingredients_recipes
-- En fait en mode exécution ligne à ligne les pragma sont pas exécutées
-- On exécute toutes la requete SQL dans VSCode
-- Là, la levure a disparue
-- La suppression en CASCADE fonctionne donc bien
SELECT
  *
FROM
  ingredients_recipes;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 12 : Agréger les données
-- Fusionner des lignes pour obtenir : somme, total, nb etc.
-- Lire https://www.sqlite.org/lang_aggfunc.html
-- On repart de l'exemple précédent
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"), -- "g" se repette? On aurait dû faire une table avec les unités
  (2, 2, 200, "g"),
  (2, 3, 8, "g"), -- Y a une erreur volontaire ici (3, 2... au lieu de (2, 3...
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL);

-- NULL car pas d'unité 
-- check qu'on retrouve ce que l'on avait
SELECT
  ingredients_recipes.quantity,
  ingredients_recipes.unit,
  ingredients.name
FROM
  ingredients_recipes
  JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id -- clé étrangère puis clé primaire
WHERE
  ingredients_recipes.recipe_id = 2;

-- On veut le nb de recettes
SELECT
  COUNT(id)
FROM
  recipes;

-- Le dates sont nulles
SELECT
  *
FROM
  recipes;

-- On fixe une date
UPDATE recipes
SET
  DATE = 100
WHERE
  id = 2;

SELECT
  *
FROM
  recipes;

SELECT
  COUNT(DATE)
FROM
  recipes;

-- 1 seule date n'est pas nulle
SELECT
  COUNT(*)
FROM
  recipes;

SELECT
  SUM(duration) AS "Durée Totale (min.)"
FROM
  recipes;

SELECT
  GROUP_CONCAT (title, "--")
FROM
  recipes;

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Salade de fruits", "salade-de-fruits", 10, 1);

SELECT
  GROUP_CONCAT (title, "--")
FROM
  recipes;

-- Afficher en fonction de la durée
-- Z! Dans le SELECT d'une requête où il y a un GROUP BY on ne peut afficher
-- Que des aggrégations : COUNT(id) 
-- Dans champs qui sont agrégés duration (duration est dans le GROUP BY)
SELECT
  COUNT(id),
  duration
FROM
  recipes
GROUP BY
  duration;

-- SELECT title, COUNT(id), duration FROM recipes GROUP BY duration; -- devrait sortir une erreur
-- Sortir la même liste mais n'afficher que les lignes dont le count est sup à 2
-- Fonctionne pas car count est déterminé avant le GROUP BY
-- En fait on voudrait que la condition s'effectue après le GROUP BY
-- SELECT COUNT(id) as count, duration 
-- FROM recipes 
-- WHERE count >= 2
-- GROUP BY duration;
SELECT
  COUNT(id) AS COUNT,
  duration
FROM
  recipes
GROUP BY
  duration
HAVING
  COUNT >= 2;

SELECT
  COUNT(id),
  duration
FROM
  recipes
GROUP BY
  duration
HAVING
  COUNT(id) >= 2;

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (3, 1, 50, "g");

-- On met que 50 gr de sucre de recette 3 
INSERT INTO
  ingredients (name)
VALUES
  ("Miel");

-- Miel est utilisé dans aucune recette
-- Sucre apparait 2 fois car il est lié à 2 recettes (la 2 et la 3)
-- Miel apparaît pas
SELECT
  *
FROM
  ingredients
  JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id;

-- Miel apparaît
SELECT
  *
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id;

-- Compter le nb de recettes où les ingrédients apparaissent
SELECT
  ingredients.name,
  COUNT(id)
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
GROUP BY
  ingredients.name;

-- Z! Bizarre miel apparaît comme utilisé dans une recette alors que c'est pas le cas
-- C'est à cause du id utilisé par COUNT qui n'est jamais null
-- Dorénvant on voit bien que miel n'est pas utilisé
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id)
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
GROUP BY
  ingredients.name;

-- On peut avoir un GROUP BY avec des expressions séparées par des virgules
-- On veut savoir dans combien de recettes de même durée sont utilisé les ingrédients
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count",
  recipes.duration
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name,
  recipes.duration;

-- Si on veut "juste" éviter les duplications vaut mieu utiliser DISTINCT
-- On utilise GROUP BY que ssi on utilise une fonction d'aggrégation SUM, MIN, MAX...
-- On veut tous les ingrédients qui ont au moins une recette
SELECT
  *
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id;

SELECT
  *
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IS NOT NULL;

-- On a 2 fois sucre
-- Par exemple, ça c'est pas pratique
SELECT
  ingredients.name
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IS NOT NULL;

SELECT DISTINCT
  ingredients.name
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IS NOT NULL;

-- Sucre est visible 2 fois car on a 2 recettes avec des durées différentes
-- C'est les combinaison name et duration qui sont distinctes
SELECT DISTINCT
  ingredients.name,
  recipes.duration
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE
  ingredients_recipes.recipe_id IS NOT NULL;

SELECT DISTINCT
  ingredients.name
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IS NOT NULL;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 13 : Order et Limit
-- Retrouver les 3 premiers ingrédients les plus utilisés dans l'ordre décropissants
-- Dans SELECT on peut ajouter ORDER et/ou LIMIT    
-- On repart de ce que l'on avait
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"), -- "g" se repette? On aurait dû faire une table avec les unités
  (2, 2, 200, "g"),
  (2, 3, 8, "g"), -- Y a une erreur volontaire ici (3, 2... au lieu de (2, 3...
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL);

-- NULL car pas d'unité 
-- On fixe une date
UPDATE recipes
SET
  DATE = 100
WHERE
  id = 2;

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Salade de fruits", "salade-de-fruits", 10, 1);

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (3, 1, 50, "g");

-- On met que 50 gr de sucre de recette 3 
INSERT INTO
  ingredients (name)
VALUES
  ("Miel");

-- Miel est utilisé dans aucune recette
-- check qu'on retrouve ce que l'on avait
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name;

-- Par nb de recette décroissant
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name
ORDER BY
  COUNT DESC
LIMIT
  3;

-- Ordre alphabétique normal 
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name
ORDER BY
  ingredients.name ASC
LIMIT
  5;

-- Tous les ingredients, par nb de recette puis par ordre alpha si besoin 
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name
ORDER BY
  COUNT DESC,
  ingredients.name ASC;

SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name
ORDER BY
  COUNT DESC,
  ingredients.name ASC
LIMIT
  3;

-- Affiche la seconde serie de 3
SELECT
  ingredients.name,
  COUNT(ingredients_recipes.recipe_id) AS "Count"
FROM
  ingredients
  LEFT JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
  LEFT JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
GROUP BY
  ingredients.name
ORDER BY
  COUNT DESC,
  ingredients.name ASC
LIMIT
  3
OFFSET
  3;

-- Offset == index en fait. Affiche les 3 à partir de l'index 3
-- Bien retenir l'ordre : SELECT FROM WHERE GROUP BY ORDER LIMIT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 14 : Requêtes imbriquées
-- Un champ peut être remplacé par une sous-requête
-- Ou dans le FROM
-- Ou dans les conditions du WHERE
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"), -- "g" se repette? On aurait dû faire une table avec les unités
  (2, 2, 200, "g"),
  (2, 3, 8, "g"), -- Y a une erreur volontaire ici (3, 2... au lieu de (2, 3...
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL);

-- NULL car pas d'unité 
-- On fixe une date
UPDATE recipes
SET
  DATE = 100
WHERE
  id = 2;

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Salade de fruits", "salade-de-fruits", 10, 1);

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (3, 1, 50, "g");

-- On met que 50 gr de sucre de recette 3 
INSERT INTO
  ingredients (name)
VALUES
  ("Miel");

-- Miel est utilisé dans aucune recette
-- Check qu'on retrouve ce que l'on avait
-- Remet la data de la recette Madeleine à NULL comme dans la vidéo
UPDATE recipes
SET
  DATE = NULL
WHERE
  id = 2;

SELECT
  *
FROM
  recipes;

-- Sous requête entre parenthèses
-- L'exemple ci-dessous n'a pas de sens mais bon...
SELECT
  *,
  (
    SELECT
      COUNT(*)
    FROM
      ingredients_recipes
  )
FROM
  recipes;

SELECT
  *,
  (
    SELECT
      COUNT(*)
    FROM
      ingredients_recipes
  ) AS "Compteur"
FROM
  recipes;

-- On veut ne nb d'ingrédients par recette
-- On parle de sous-requete correlée
-- Z! Impact sur les perfs
SELECT
  *,
  (
    SELECT
      COUNT(*)
    FROM
      ingredients_recipes
    WHERE
      recipe_id = recipes.id
  ) AS "Compteur"
FROM
  recipes;

-- A priori, peu utilisé
-- Sous requête dans le FROM
SELECT
  MyRecette.title
FROM
  (
    SELECT
      *
    FROM
      recipes
  ) AS "MyRecette";

SELECT
  MyRecette.MyCounter
FROM
  (
    SELECT
      COUNT(id) AS "MyCounter"
    FROM
      recipes
  ) AS "MyRecette";

-- Sous requête dans les conditions
-- On veut les ingrédients des desserts
SELECT
  *
FROM
  categories;

SELECT
  *
FROM
  categories
WHERE
  categories.title = "Dessert";

-- Maintenant on veut les recettes liées
SELECT
  *
FROM
  categories
  LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
WHERE
  categories.title = "Dessert";

-- On voit l'id de la recette à l'écran
-- On n'affiche que les id des recettes
SELECT
  categories_recipes.recipe_id
FROM
  categories
  LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
WHERE
  categories.title = "Dessert";

-- Maintenant on affiche les ingrédients
SELECT
  *
FROM
  recipes
WHERE
  id IN (1, 2, 3);

SELECT
  *
FROM
  recipes
WHERE
  id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories.title = "Dessert"
  );

SELECT
  *
FROM
  ingredients_recipes
WHERE
  ingredients_recipes.recipe_id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories.title = "Dessert"
  );

-- On veut voir les noms des ingrédients => JOIN
SELECT
  ingredients.*
FROM
  ingredients_recipes
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories.title = "Dessert"
  );

SELECT
  ingredients.*
FROM
  ingredients_recipes
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories.title NOT IN ("Dessert", "Gâteau")
  );

-- Très souvent un JOIN est plus efficace qu'une sous requête
-- Surtout avec les requêtes corrélées
-- Penser à EXPLAIN QUERY PLAN
EXPLAIN QUERY PLAN
SELECT
  ingredients.*
FROM
  ingredients_recipes
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories.title NOT IN ("Dessert", "Gâteau")
  );

-- L'exemple n'a pas de sens mais ça montre qu'il détecte une requête corrélée
EXPLAIN QUERY PLAN
SELECT
  ingredients.*
FROM
  ingredients_recipes
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
WHERE
  ingredients_recipes.recipe_id IN (
    SELECT
      categories_recipes.recipe_id
    FROM
      categories
      LEFT JOIN categories_recipes ON categories.id = categories_recipes.category_id -- on met à dte la clé étrangère
    WHERE
      categories_recipes.recipe_id = ingredients_recipes.recipe_id
  );

-- Faut privilégier les JOIN
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 15 : Les transactions
-- Permettent de regrouper des requêtes
-- Revenir en arrière si problème
-- Penser aux insertions de données
-- "Fais tout d'un coup on ne fait rien"
-- Lire la doc : https://www.sqlite.org/lang_transaction.html
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"), -- "g" se repette? On aurait dû faire une table avec les unités
  (2, 2, 200, "g"),
  (2, 3, 8, "g"), -- Y a une erreur volontaire ici (3, 2... au lieu de (2, 3...
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL);

-- NULL car pas d'unité 
-- On fixe une date
UPDATE recipes
SET
  DATE = 100
WHERE
  id = 2;

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Salade de fruits", "salade-de-fruits", 10, 1);

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (3, 1, 50, "g");

-- On met que 50 gr de sucre de recette 3 
INSERT INTO
  ingredients (name)
VALUES
  ("Miel");

-- Miel est utilisé dans aucune recette
-- Check qu'on retrouve ce que l'on avait
-- Remet la date de la recette Madeleine à NULL comme dans la vidéo
UPDATE recipes
SET
  DATE = NULL
WHERE
  id = 2;

SELECT
  *
FROM
  recipes;

-- On veut supprimer une recette mais mettre tout ça dans une transaction
-- SELECT * FROM recipes;
-- DELETE FROM recipes WHERE id = 1;
-- SELECT * FROM recipes;
-- A l'exécution on voit bien que la table revient à son état original
BEGIN TRANSACTION;

SELECT
  *
FROM
  recipes;

DELETE FROM recipes
WHERE
  id = 1;

SELECT
  *
FROM
  recipes;

ROLLBACK TRANSACTION;

SELECT
  *
FROM
  recipes;

-- Si on est satisfait on peut faire un COMMIT TRANSACTION;
BEGIN TRANSACTION;

SELECT
  *
FROM
  recipes;

DELETE FROM recipes
WHERE
  id = 1;

SELECT
  *
FROM
  recipes;

COMMIT TRANSACTION;

SELECT
  *
FROM
  recipes;

-- Utile avec les contraintes sur les clés étrangère et les contraintes d'unicité
-- Suite à une insertion qui serait pas bonne
-- Dans la doc faire une recherche sur foreign key et sur la page rechercher ROLLBACK
-- Voir 4.2 ici : https://www.sqlite.org/foreignkeys.html
-- Deferred Foreign Key Constraints
-- Des contraintes sur des clés étrangères vont pas être vérifiées de suite mais à la fin d'une transaction
-- Utile si on insère pas les données dans le bon ordre
-- On veut que la validité des données ne soit vérifiées qu'une fois toutes les insertions faites
-- Dans la doc faire une recherche sur ON CONFLICT
-- Lire : https://www.sqlite.org/lang_conflict.html
-- Possibilité de faire un ROLLBACK si un conflit arrive lors d'une transaction
-- Z! C'est spécifique à SQLite
-- Important d'utiliser des transaction quand on insère des données
-- Ici dans la trasaction on supprime la recette 2 et on fait une erreur
-- Sur l'erreur y a un ROLLBACK
-- A la fin la l'intégrité de la table n'est pas affectée
BEGIN TRANSACTION;

SELECT
  *
FROM
  recipes;

DELETE FROM recipes
WHERE
  id = 2;

SELECT
  *
FROM
  recipes
WHERE
  Dummy = 42;

COMMIT TRANSACTION;

SELECT
  *
FROM
  recipes;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 16 : Les vues
-- Tables viteulles issues de requêtes particulières
-- Evite les sous requêtes
-- Impact sur les perfs
-- Doc CREATE VIEW : https://www.sqlite.org/lang_createview.html
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1),
  ("Salade de fruits", "salade-de-fruits", 10, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf"),
  ("Miel");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"),
  (2, 2, 200, "g"),
  (2, 3, 8, "g"),
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL),
  (3, 1, 150, "g");

-- Check que tout est OK
SELECT
  *
FROM
  recipes;

-- On veut a liste des ingrédients concaténés
SELECT
  *
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id;

-- On veut le titre de la recette et les ingrédients qui la compose
SELECT
  recipes.title,
  GROUP_CONCAT (ingredients.name, ", ")
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
GROUP BY
  recipes.id;

SELECT
  recipes.title,
  GROUP_CONCAT (ingredients.name, ", ") AS "Ingrédients"
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
GROUP BY
  recipes.id;

-- On utilise souvent cette requete
-- On en fait une vue
-- A l'exécution on a pas d'affichage
-- Dans SQL Explorer y a une table "recette_avec_ingredients" avec une loupe
CREATE VIEW
  recette_avec_ingredients AS
SELECT
  recipes.title,
  GROUP_CONCAT (ingredients.name, ", ") AS "Ingrédients"
FROM
  recipes
  LEFT JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
  LEFT JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id
GROUP BY
  recipes.id;

-- Dorénavant on peut utiliser cette "table" comme une table normale
SELECT
  *
FROM
  recette_avec_ingredients;

-- Les recettes avec de la farine
SELECT
  *
FROM
  recette_avec_ingredients
WHERE
  Ingrédients LIKE "%farine%";

-- Pas oublier que la requête est plus complexe
-- A chaque intérrogation de la vue il relance la requête de création de vue
EXPLAIN QUERY PLAN
SELECT
  *
FROM
  recette_avec_ingredients
WHERE
  Ingrédients LIKE "%farine%";

-- Utile pour les dashboard
-- Attention aux perfs si on commence à vouloir faire des JOIN sur des vues etc.
-- Supprimer la vue
DROP VIEW recette_avec_ingredients;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 17 : Les triggers
-- Ajoute de la logique quand des ops sont effectuées sur la BdD
-- Exemple sur ajout, modif ou suppression de ligne
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS recipes;

-- On a le système de CASCADE mais en général, faire attention à l'ordre de suppression
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS ingredients;

-- Table users
CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_name VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
  );

-- Table recipes
CREATE TABLE
  IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    DATE INTEGER,
    user_id INTGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- supprime les recettes du user quand ce dernier est supprimé
  );

-- Table categories
CREATE TABLE
  IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
  );

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

-- Insertion de quelque données
INSERT INTO
  users (user_name, email)
VALUES
  ("Riri", "riri@xx.com");

INSERT INTO
  categories (title)
VALUES
  ("Plat"),
  ("Dessert"),
  ("Gâteau");

INSERT INTO
  recipes (title, slug, duration, user_id)
VALUES
  ("Soupe", "soupe", 10, 1),
  ("Madeleine", "madeleine", 30, 1),
  ("Salade de fruits", "salade-de-fruits", 10, 1);

-- Insère une liaison
INSERT INTO
  categories_recipes (recipe_id, category_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 3);

CREATE TABLE
  IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50)
  );

INSERT INTO
  ingredients (name)
VALUES
  ("Sucre"),
  ("Farine"),
  ("Levure"),
  ("Beurre"),
  ("Lait"),
  ("Oeuf"),
  ("Miel");

CREATE TABLE
  IF NOT EXISTS ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
  );

INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (2, 1, 150, "g"),
  (2, 2, 200, "g"),
  (2, 3, 8, "g"),
  (2, 4, 100, "g"),
  (2, 5, 50, "g"),
  (2, 6, 3, NULL),
  (3, 1, 150, "g");

-- Check que tout est OK
SELECT
  *
FROM
  recipes;

-- On veut savoir combien de fois les ingrédients sont utilisés
-- On faisait les LEFT JOIN
-- On veut ajouter un champ "usage count" dans la table ingrédient et qu'il se mette à jour automatiquement
ALTER TABLE ingredients
ADD COLUMN usage_count INTEGER DEFAULT 0;

SELECT
  *
FROM
  ingredients;

-- Lire doc CREATE TRIGGER : https://www.sqlite.org/lang_createtrigger.html
-- Bien voir NEW et OLD dans la doc
CREATE TRIGGER update_usage_count_on_ingredients_linked AFTER INSERT ON ingredients_recipes BEGIN
UPDATE ingredients
SET
  usage_count = usage_count + 1
WHERE
  id = NEW.ingredient_id;

END;

-- On voit rien pour l'instant
SELECT
  *
FROM
  ingredients;

-- La façon de lister les triggers dépend de la BdD
-- SQLite => voir la talbe masquée sql_master
SELECT
  *
FROM
  sqlite_master;

-- On veut voir que le type trigger
SELECT
  *
FROM
  sqlite_master
WHERE
  type = "trigger";

-- On rajoute du miel dans la soupe
INSERT INTO
  ingredients_recipes (recipe_id, ingredient_id, quantity, unit)
VALUES
  (1, 7, 10, "g");

-- Maintenant on voit que usage_count de miel a été mis à jour correctement
SELECT
  *
FROM
  ingredients;

-- Faut créer un trigger pour les cas où on enlève des ingrédients
CREATE TRIGGER decrement_usage_count_on_ingredients_unlinked AFTER DELETE ON ingredients_recipes BEGIN
UPDATE ingredients
SET
  usage_count = usage_count - 1
WHERE
  id = OLD.ingredient_id;

END;

-- DROP TRIGGER decrement_usage_count_on_ingredients_unlinked; 
--  SELECT * 
-- FROM sqlite_master
-- WHERE type = "trigger";
DELETE FROM ingredients_recipes
WHERE
  recipe_id = 1
  AND ingredient_id = 7;

-- Miel est bien reppassé à 0
SELECT
  *
FROM
  ingredients;

-- Attnetion les triggers insèrent de la logique dans la BdD
-- On préfère souvant laisser la logique dans le code
-- Ici les compteurs seraient mis à jour via du code 
-- Les triggers ralentissent les insertions et suppriessions par exemple
-- Vider une base peut devenir très lent
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 18 : Requête récursive 
CREATE TABLE
  IF NOT EXISTS categories2 (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES categories2 (id) ON DELETE CASCADE
  );

DELETE FROM categories2;

INSERT INTO
  categories2
VALUES
  (1, "Mamifère", NULL),
  (2, "Chien", 1),
  (3, "Chat", 1),
  (4, "Singe", 1),
  (5, "Gorille", 4),
  (6, "Chimpanzé", 4),
  (7, "Shiba", 2),
  (8, "Corgi", 2),
  (9, "Labrador", 2),
  (10, "Poisson", NULL),
  (11, "Requin", 10),
  (12, "Requin Blanc", 11),
  (13, "Grand Requin Blanc", 12),
  (14, "Petit Requin Blanc", 12),
  (15, "Requin Marteau", 11),
  (16, "Requin Tigre", 11),
  (17, "Poisson rouge", 10),
  (18, "Poisson chat", 10);

SELECT
  *
FROM
  categories2;

-- Doc, chercher WITH clause : https://www.sqlite.org/lang_with.html
-- With permet d'utilsier des vues temporaires utilisables dans la requête principale
-- Là on crée une table temporaire avec WITH
-- Ensuite à la fin de la requête, on peut utiliser alors le nom de la table
WITH
  temp_table AS (
    SELECT
      id,
      name
    FROM
      categories2
  )
SELECT
  name
FROM
  temp_table;

-- Y a bien 1 seul ;
-- On cherche les categories parentes du petit requin blanc
-- Marche pas car il cherche temp_table.parent_id
WITH RECURSIVE
  temp_table AS (
    SELECT
      *
    FROM
      categories2
    WHERE
      id = 14 -- Ca c'est la ligne qui initie la récursion
    UNION ALL -- On concatène toutes les lignes : https://www.sqlitetutorial.net/sqlite-union/
    SELECT
      *
    FROM
      categories2
    WHERE
      id = temp_table.parent_id -- La seconde requete peut utiliser la vue
  )
SELECT
  *
FROM
  temp_table;

-- Une fois qu'on a la vue on l'utilise dans la requête principale
-- Marche pas car nom ambigu sur id
WITH RECURSIVE
  temp_table AS (
    SELECT
      *
    FROM
      categories2
    WHERE
      id = 14
    UNION ALL
    SELECT
      *
    FROM
      categories2,
      temp_table
    WHERE
      id = temp_table.parent_id
  )
SELECT
  *
FROM
  temp_table;

-- Marche pas car "SELECTs to the left and right of UNION ALL do not have the same number of result columns"
WITH RECURSIVE
  temp_table AS (
    SELECT
      *
    FROM
      categories2
    WHERE
      id = 14
    UNION ALL
    SELECT
      *
    FROM
      categories2,
      temp_table
    WHERE
      categories2.id = temp_table.parent_id
  )
SELECT
  *
FROM
  temp_table;

WITH RECURSIVE
  temp_table AS (
    SELECT
      id,
      name,
      parent_id
    FROM
      categories2
    WHERE
      id = 14
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id
    FROM
      categories2,
      temp_table
    WHERE
      categories2.id = temp_table.parent_id
  )
SELECT
  *
FROM
  temp_table;

-- On veut sortir toutes les catégories enfants de requin (l'inverse quoi)
WITH RECURSIVE
  temp_table AS (
    SELECT
      id,
      name,
      parent_id
    FROM
      categories2
    WHERE
      id = 11
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id
    FROM
      categories2,
      temp_table
    WHERE
      categories2.parent_id = temp_table.id
  )
SELECT
  *
FROM
  temp_table;

-- On veut afficher le niveau
-- Marche pas car on a pas le même nombre de colonne
WITH RECURSIVE
  temp_table AS (
    SELECT
      id,
      name,
      parent_id,
      0 AS "Niveau"
    FROM
      categories2
    WHERE
      id = 11
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id
    FROM
      categories2,
      temp_table
    WHERE
      categories2.parent_id = temp_table.id
  )
SELECT
  *
FROM
  temp_table;

-- On a renommé la table children
WITH RECURSIVE
  children AS (
    SELECT
      id,
      name,
      parent_id,
      0 AS "Niveau"
    FROM
      categories2
    WHERE
      id = 11
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id,
      children.Niveau + 1 AS "Niveau"
    FROM
      categories2,
      children
    WHERE
      categories2.parent_id = children.id
  )
SELECT
  id,
  name,
  Niveau
FROM
  children;

WITH RECURSIVE
  children AS (
    SELECT
      id,
      name,
      parent_id,
      0 AS level,
      "" AS path
    FROM
      categories2
    WHERE
      id = 11
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id,
      children.level + 1 AS level,
      children.path || children.name || " > " AS path -- Vérifier mais || est certainement spécifique à SQLite
    FROM
      categories2,
      children
    WHERE
      categories2.parent_id = children.id
  )
SELECT
  id,
  name,
  level,
  path
FROM
  children;

-- On précise ce qui va être vu
-- Donne de la lisibilité au départ
-- Permet de supprimer les "AS path" et "AS level" car c'est l'indice du paramètre qui compte
WITH RECURSIVE
  children (id, name, parent_id, level, path) AS (
    SELECT
      id,
      name,
      parent_id,
      0,
      ""
    FROM
      categories2
    WHERE
      id = 11
    UNION ALL
    SELECT
      categories2.id,
      categories2.name,
      categories2.parent_id,
      children.level + 1,
      children.path || children.name || " > " -- Vérifier mais || est certainement spécifique à SQLite
    FROM
      categories2,
      children
    WHERE
      categories2.parent_id = children.id
  )
SELECT
  id,
  name,
  level,
  path
FROM
  children;

-- Z! Attention aux perfs
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 19 : Fonction de fenêtrage
-- Voir 
-- https://grafikart.fr/tutoriels/window-function-sql-2045
-- https://youtu.be/y1KCM8vbYe4
-- Les partition fonctionnent comme les aggrégations mais au lieu d'un résultat on va garder
-- l'ensemble des lignes en plus du résultat de l'agrégation sur la colonne demandée
-- Je vois pas comment faire un product breakdown par pays par exemple !!!!! 
-- Liées aux fonction d'aggrégation
-- Exemple SUM ci-dessous
CREATE TABLE
  IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    YEAR INTEGER,
    country VARCHAR(255),
    product VARCHAR(255),
    profit INTEGER
  );

INSERT INTO
  sales (YEAR, country, product, profit)
VALUES
  (2000, 'Finland', 'Computer', 1500),
  (2000, 'Finland', 'Phone', 100),
  (2001, 'Finland', 'Phone', 10),
  (2000, 'India', 'Calculator', 75),
  (2000, 'India', 'Calculator', 75),
  (2000, 'India', 'Computer', 1200),
  (2000, 'USA', 'Calculator', 75),
  (2000, 'USA', 'Computer', 1500),
  (2001, 'USA', 'Calculator', 50),
  (2001, 'USA', 'Computer', 1500),
  (2001, 'USA', 'Computer', 1200),
  (2001, 'USA', 'TV', 150),
  (2001, 'USA', 'TV', 100);

SELECT
  *,
  SUM(profit) AS total
FROM
  sales;

SELECT
  SUM(profit) AS total
FROM
  sales;

-- On a une seule information
-- On va utiliser les fonction de partition/fenêtrage
-- Lire https://www.sqlite.org/windowfunctions.html para 3 pour les built in functions
SELECT
  *,
  SUM(profit) OVER () -- la partition est entre les parenthèses. Ici on fait la somme sur toutes les lignes
FROM
  sales;

SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
  ) -- le fenêtre est sur chaque pays
FROM
  sales;

SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
  ) AS total_country,
  ROW_NUMBER() OVER (
    PARTITION BY
      country
  ) AS row_country
FROM
  sales;

-- Par pays on classe par profit decroissant et on affiche le rang
-- Voir Id 4 et 5 à 75 mais avec des row numbers différents
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
  ) AS total_country,
  ROW_NUMBER() OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  ) AS row_country
FROM
  sales;

-- Classement des produits par pays
-- RANK() tient compte des égalités
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
  ) AS total_country,
  RANK() OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  ) AS rank_country
FROM
  sales;

-- Bien voir que dans la requête précédente, aux US les RANKS sont 1, 1 puis 3
-- DENSE_RANK affiche bien 1, 1, 2 ....
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
  ) AS total_country,
  DENSE_RANK() OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  ) AS rank_country
FROM
  sales;

-- Z! Bien voir que total_country change d'une ligne à l'autre et devient une sorte de somme 
-- "cumulée"
-- Voir par exemple les id 6, 4 et 5 où on passe de 1200 à 1350 en faisant 1200 + 2x75
-- Je ne comprends pas ce qui se passe !!!!!
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  ) AS total_country,
  DENSE_RANK() OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  ) AS rank_country
FROM
  sales;

-- On peut nommer une fenêtre si elle se repette
SELECT
  *,
  SUM(profit) OVER my_window AS total_country, -- pas de parenthèse autour de w
  DENSE_RANK() OVER my_window AS rank_country
FROM
  sales
WINDOW
  my_window AS (
    PARTITION BY
      country
    ORDER BY
      profit DESC
  );

SELECT
  id,
  YEAR,
  country,
  product,
  profit,
  SUM(profit) OVER (
    ORDER BY
      id ASC
  ) AS running_total
FROM
  sales
ORDER BY
  id ASC;

-- La somme cummulée totale quand les montants sont classés en décroissant par pays
SELECT
  id,
  YEAR,
  country,
  product,
  profit,
  SUM(profit) OVER (
    ORDER BY
      country ASC,
      profit DESC
  ) AS running_total
FROM
  sales;

-- La somme cummulée par pays. Les montants sont classés en décroissant par pays
SELECT
  id,
  YEAR,
  country,
  product,
  profit,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      profit DESC,
      id DESC
  ) AS running_local
FROM
  sales;

-- Somme avec la ligne suivante
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      Profit DESC
  ) AS total_country,
  SUM(profit) OVER (
    PARTITION BY
      country ROWS BETWEEN CURRENT ROW
      AND 1 FOLLOWING
  ) AS "total_with_next"
FROM
  sales;

-- Somme avec la ligne précédente
-- Marche pas
-- SELECT
--  *,
--  SUM(profit) OVER (PARTITION BY country ORDER BY Profit DESC) AS total_country,
--  SUM(profit) OVER (PARTITION BY country ROWS BETWEEN CURRENT ROW AND 1 PRECEDING) AS running_total 
-- FROM sales; 
-- Top 3 par pays
-- Affiche bien le classement
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      Profit DESC
  ) AS "total_country",
  ROW_NUMBER() OVER (
    PARTITION BY
      country
    ORDER BY
      Profit DESC
  ) AS "row_number"
FROM
  sales;

-- Faut retenir les 3 premiers
-- Marche pas
SELECT
  *,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      Profit DESC
  ) AS "total_country",
  ROW_NUMBER() OVER (
    PARTITION BY
      country
    ORDER BY
      Profit DESC
  ) AS "row_number"
FROM
  sales
WHERE
  ROW_NUMBER < 4;

-- Faut transformer la requête précédente en sous-requête
SELECT
  *
FROM
  (
    SELECT
      *,
      SUM(profit) OVER (
        PARTITION BY
          country
        ORDER BY
          Profit DESC
      ) AS "total_country",
      ROW_NUMBER() OVER (
        PARTITION BY
          country
        ORDER BY
          Profit DESC
      ) AS "row_number"
    FROM
      sales
  ) AS ma_table
WHERE
  ma_table.row_number < 4;

-- Le Top 3 par produit
SELECT
  *
FROM
  (
    SELECT
      *,
      SUM(profit) OVER w AS "total",
      ROW_NUMBER() OVER w AS "row_number"
    FROM
      sales
    WINDOW
      w AS (
        PARTITION BY
          product
        ORDER BY
          Profit DESC
      )
  ) AS ma_table
WHERE
  ma_table.row_number < 4;

-- Running total - Somme cumulative
-- Window function permettent de faire des calculs sur différentes colonnes
-- Typiquement c'est un groupe de mot clé qui s'ajoute à une requete existante
SELECT
  id,
  profit
FROM
  sales
ORDER BY
  id ASC;

-- window_function (expression)
-- OVER(                            -- Indique que la fonction est à utilser comme window function
--  [PARTITION BY partion_clause]   -- precise les lignes à prendre en compte. La fenêtre peut être le produit, le pays...
--  [ORDER BY order_clause]         -- le cas echéant, précise comment ordoner les lignes de la fenêtre
-- )
-- Ici on utilise SUM() et on ajoute les mots clé OVER, ORDER BY... pour en faire une window function
-- Je ne comprends pas pourquoi pourquoi la somme est cummulative quand on utilise ORDER BY
SELECT
  id,
  profit,
  SUM(profit) OVER (
    ORDER BY
      id ASC
  ) AS running_total
FROM
  sales
ORDER BY
  id ASC;

-- s'assure qu'on affiche les données dans l'ordre dans lequel ont été fait les calculs
-- A priori ça se passe bien si à la fin on a DESC au lieu de ASC
SELECT
  id,
  profit,
  SUM(profit) OVER (
    ORDER BY
      id ASC
  ) AS running_total
FROM
  sales
ORDER BY
  id DESC;

-- Somme cumulée par Id croissant, regroupée par pays
SELECT
  id,
  profit,
  country,
  SUM(profit) OVER (
    PARTITION BY
      country
    ORDER BY
      id ASC
  ) AS running_total
FROM
  sales
ORDER BY
  country ASC;

-- Somme cumulée par Id croissant, regroupée par produit
SELECT
  id,
  profit,
  country,
  product,
  SUM(profit) OVER (
    PARTITION BY
      product
    ORDER BY
      id ASC
  ) AS running_total
FROM
  sales
ORDER BY
  product ASC;

-- Somme cumulée regroupée par produit, par profit decroissant 
-- ???????????????? 
-- En fait ça marche pas car pour le calculator, les 3 premiers montants
-- sont tous à 75. Il fait 3x75 = 225 
SELECT
  id,
  profit,
  country,
  product,
  SUM(profit) OVER (
    PARTITION BY
      product
    ORDER BY
      profit DESC
  ) AS running_total
FROM
  sales;

-- Ca marche 
-- Somme cumulée regroupée par produit par profit decroissant
-- Voir qu'à chaque fois qu'on change de produit la somme est remise à 0
SELECT
  id,
  profit,
  country,
  product,
  SUM(profit) OVER (
    PARTITION BY
      product
    ORDER BY
      profit DESC,
      id ASC
  ) AS running_total
FROM
  sales;

-- Comment sortir un product breakdown ????
-- Ca c'est ce que l'on veut
-- Manque juste une colonne "As %"
SELECT
  product,
  SUM(profit),
FROM
  sales
GROUP BY
  product;

SELECT
  product,
  SUM(profit) AS revenue,
  SUM(profit) * 1.0 / (
    SELECT
      SUM(profit)
    FROM
      sales
  ) AS breakdown
FROM
  sales
GROUP BY
  product
ORDER BY
  revenue DESC;

-- Country breakdown
SELECT
  country,
  SUM(profit) AS revenue,
  SUM(profit) * 1.0 / (
    SELECT
      SUM(profit)
    FROM
      sales
  ) AS breakdown
FROM
  sales
GROUP BY
  country
ORDER BY
  revenue DESC;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Voir https://www.youtube.com/watch?v=y1KCM8vbYe4
CREATE TABLE
  IF NOT EXISTS employees (
    emp_no INTEGER PRIMARY KEY AUTOINCREMENT,
    department VARCHAR(100),
    salary INTEGER
  );

INSERT INTO
  employees (department, salary)
VALUES
  ("engineering", 80000),
  ("engineering", 69000),
  ("engineering", 70000),
  ("engineering", 103000),
  ("engineering", 67000),
  ("engineering", 89000),
  ("engineering", 91000),
  ("sales", 59000),
  ("sales", 70000),
  ("sales", 159000),
  ("sales", 72000),
  ("sales", 60000),
  ("sales", 61000),
  ("sales", 61000),
  ("customer service", 38000),
  ("customer service", 45000),
  ("customer service", 61000),
  ("customer service", 40000),
  ("customer service", 31000),
  ("customer service", 56000),
  ("customer service", 55000);

-- aggregate functions & GROUP BY
-- https://www.sqlite.org/lang_aggfunc.html
-- Prends un certains nombre de lignes et synthetise un seul nombre
-- Exemple
SELECT
  department,
  AVG(salary)
FROM
  employees
GROUP BY
  department;

-- window functions perform aggregate operation on groups of rows but they
-- produce a result for each row
-- ON peut utiliser toutes les aggregate functions : https://www.sqlite.org/lang_aggfunc.html
-- avg(), min(), group_concat()///
-- Ainsi que certaines fonctions spécifiques aux fenêtres : voir : https://www.sqlite.org/windowfunctions.html
-- rank(), row_number()...
-- Exemple : c'est bien OVER qui declenche la window function
-- On a bien un dept_avg sur chaque ligne
SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER (
    PARTITION BY
      department
  ) AS dept_avg
FROM
  employees;

-- la clause OVER() construit une fenêtre
-- Si vide (sans partition) alors la fenêtre contient tous les enregistrements
SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER () AS enterprise_avg
FROM
  employees;

-- On utilise PARTITION BY pour former un sous groupe
-- Au lieu d'appliquer AVG sur toutes les lignes on ne l'applique qu'à un sous ensemble
-- Exemple où on calcule la moyenne par département
SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER (
    PARTITION BY
      department
  ) AS dept_avg
FROM
  employees;

-- On utilise MIN et MAX
SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER (
    PARTITION BY
      department
  ) AS dept_avg,
  MIN(salary) OVER (
    PARTITION BY
      department
  ) AS dept_min,
  MAX(salary) OVER (
    PARTITION BY
      department
  ) AS dept_max
FROM
  employees;

-- On utilise rank()
-- ORDER BY permet de changer l'ordre au sein de la fenêtre
SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER (
    PARTITION BY
      department
  ) AS dept_avg,
  MIN(salary) OVER (
    PARTITION BY
      department
  ) AS dept_min,
  MAX(salary) OVER (
    PARTITION BY
      department
  ) AS dept_max,
  -- Bien voir qu'il n'y a pas de partition dans le OVER, donc le RANK est calculé
  -- sur toutes les lignes
  -- Comme on determine le rang faut le faire sur des lignes triées d'où le ORDER BY
  RANK() OVER (
    ORDER BY
      salary DESC
  ) AS global_rank
FROM
  employees;

SELECT
  emp_no,
  department,
  salary,
  AVG(salary) OVER (
    PARTITION BY
      department
  ) AS dept_avg,
  MIN(salary) OVER (
    PARTITION BY
      department
  ) AS dept_min,
  MAX(salary) OVER (
    PARTITION BY
      department
  ) AS dept_max,
  RANK() OVER (
    ORDER BY
      salary DESC
  ) AS global_rank,
  -- Le RANK est calculé par département
  RANK() OVER (
    PARTITION BY
      department
    ORDER BY
      salary DESC
  ) AS dept_rank
FROM
  employees;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- -- Cas pratique
-- -- Recupérer les 5 derniers commentaires de chaques post sur un site web
-- SELECT * FROM posts;
-- SELECT * FROM comments; -- Y a un champ post_id
-- SELECT id, title FROM posts ORDER id DESC LIMIT 5; --
-- 
-- -- On veut les 5 derniers commentaires de ces 5 derniers articles groupés par article
-- SELECT
--   *,
--   ROW_NUMBER() OVER (PARTITION BY post_id) AS row_number
-- FROM comments;
-- 
-- -- affiche post_id et row_number en premier
-- -- On voit tous les commentaires sur chaque article
-- SELECT
--   post_id, 
--   ROW_NUMBER() OVER (PARTITION BY post_id) AS row_number
--   *
-- FROM comments;
-- 
-- -- On utilise le résultat de la 1ere requete avec les 5 derniers articles
-- -- Mais on a tous les commentaires des articles 16...20
-- SELECT
--   post_id, 
--   ROW_NUMBER() OVER (PARTITION BY post_id) AS row_number
--   *
-- FROM comments
-- WHERE post_id IN (20, 19, 18, 17, 16); -- On pourrait faire une sous requete pour avoir les N°
-- 
-- 
-- -- On veut les 5 derniers comments
-- -- => Sous requête
-- -- Là on a bien les 5 derniers commentaires de chaque article
-- SELECT * FROM (
--   SELECT
--     post_id, 
--     ROW_NUMBER() OVER (PARTITION BY post_id) AS row_number
--     *
--   FROM comments
--   WHERE post_id IN (20, 19, 18, 17, 16); -- On pourrait faire une sous requete pour avoir les N°
-- ) AS t
-- WHERE t.row_number < 6;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 20 : Interlude, que faire maintenant ?