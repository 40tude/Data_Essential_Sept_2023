/*
SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
FROM mytable
JOIN another_table
ON mytable.column = another_table.column
WHERE constraint_expression
GROUP BY column
HAVING constraint_expression
ORDER BY column ASC/DESC
LIMIT count OFFSET COUNT;
 */
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

SELECT
  *
FROM
  projects;

INSERT INTO
  projects (name, description)
VALUES
  ('Project 02', 'Formidable'),
  ('Project 300', 'Brillant !');

INSERT INTO
  projects (name, description)
VALUES
  ('Project 200', 'Brillant !');

SELECT
  *
FROM
  projects
UPDATE projects
SET
  description = 'Great !'
WHERE
  _id = 3
  -- Vérifier le last_update
SELECT
  *
FROM
  projects
DROP TABLE projects;

-- OR (LENGTH(description)=MIN(LENGTH(description)))
-- , MAX(projet)
--WHERE LENGTH(description)=MAX(description)
SELECT
  (MAX(name), LENGTH (name))
  AND (MIN(name), LENGTH (name))
FROM
  projects
ORDER BY
  name ASC;

SELECT
  name,
  LENGTH (name)
FROM
  projects
WHERE
  name = MAX(name)
  OR name = MIN(name);

SELECT
  MAX(name),
  LENGTH (name)
FROM
  projects;

SELECT
  MAX(name),
  LENGTH (MAX(NAME))
FROM
  (
    SELECT
      *
    FROM
      projects
    ORDER BY
      name ASC
  );

SELECT
  MIN(name),
  LENGTH (MIN(NAME))
FROM
  (
    SELECT
      *
    FROM
      projects
    ORDER BY
      name ASC
  );

SELECT
  *
FROM
  projects
ORDER BY
  name ASC;

CREATE TABLE
  STATION (CITY text);

INSERT INTO
  STATION (CITY)
VALUES
  ('WXY'),
  ('DEF'),
  ('ABC');

INSERT INTO
  STATION (CITY)
VALUES
  ('PQRS');

SELECT
  *
FROM
  STATION;

SELECT
  MIN(CITY),
  LENGTH (MIN(CITY))
FROM
  (
    SELECT
      *
    FROM
      STATION
    ORDER BY
      CITY ASC
  );

SELECT
  MAX(CITY),
  LENGTH (MAX(CITY))
FROM
  (
    SELECT
      *
    FROM
      STATION
    ORDER BY
      CITY ASC
  );

SELECT
  CITY,
  LENGTH (CITY) AS MyLen,
  MAX(MyLen)
FROM
  STATION;

SELECT
  CITY,
  MIN(LENGTH (CITY))
FROM
  (
    SELECT
      *
    FROM
      STATION
    ORDER BY
      CITY ASC
  ) AS SUB
GROUP BY
  CITY;

SELECT
  CITY,
  MAX(LENGTH (CITY))
FROM
  (
    SELECT
      *
    FROM
      STATION
    ORDER BY
      CITY ASC
  ) AS SUB
GROUP BY
  CITY;