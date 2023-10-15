import sqlite3
import os
import traceback
import sys

# ScriptDir = os.path.dirname(os.path.realpath(__file__))
# print(f"Le répertoire du script : {ScriptDir}")
# cwd = os.getcwd()
# print(f"Current working directory: {cwd}")

# os.chdir(ScriptDir)
# print(f"Now the current working directory: {os.getcwd()}")


# Create the database close to the script
cwd = os.getcwd()
ScriptDir = os.path.dirname(os.path.realpath(__file__))
os.chdir(ScriptDir)

try:
  connection = sqlite3.connect('mydb.db') # implicitly creating it if it does not exist:
  cursor = connection.cursor()

  req = """
    DROP TABLE IF EXISTS users;
  """
  cursor.execute (req)


  req = """
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      names VARCHAR(150) NOT NULL
    )
  """
  cursor.execute (req)


  req = """
    insert into users values 
      (1, "Riri"),
      (2, "Fifi"),
      (3, "Loulou")
  """
  cursor.execute (req)

  req = """
    insert into users (names) values 
      ("Donald"),
      ("Dingo")
  """
  cursor.execute (req)

  Nom = ("Daisy",)
  req = """
      insert into users (names) values 
      (?)
    """
  cursor.execute (req, Nom)


  DesNoms = [
    ("Picsou",), 
    ("Zoubida",)
  ]
  req = """
      insert into users (names) values 
      (?)
    """
  cursor.executemany (req, DesNoms)

  connection.commit()




  req = """
    select * from users
  """
  cursor.execute (req)

  result = cursor.fetchall()
  # print(result)

  for record in result :
    print (f"Le prénom est : {record[1]}")




except sqlite3.Error as err:
  # https://stackoverflow.com/questions/25371636/how-to-get-sqlite-result-error-codes-in-python
  print('SQLite error: %s' % (' '.join(err.args)))
  print("Exception class is: ", err.__class__)
  print('SQLite traceback: ')
  exc_type, exc_value, exc_tb = sys.exc_info()
  print(traceback.format_exception(exc_type, exc_value, exc_tb))

finally:
  cursor.close() # Z! on peut pas fermer un cursor qui n'est pas fermé
  connection.close() # on peut fermer une connection déjà fermée
  os.chdir(cwd)


