import sqlite3
import os
import traceback
import sys

# Create the database close to the script
cwd = os.getcwd()
ScriptDir = os.path.dirname(os.path.realpath(__file__))
os.chdir(ScriptDir)

connection = sqlite3.connect('mydb.db') # create it if it does not exist:
connection.close()

try:
  cursor = connection.cursor()

except sqlite3.Error as err:
  # https://stackoverflow.com/questions/25371636/how-to-get-sqlite-result-error-codes-in-python
  print('SQLite error       : %s' % (' '.join(err.args)))
  print("Exception class is : ", err.__class__)
  print('SQLite traceback   : ')
  exc_type, exc_value, exc_tb = sys.exc_info()
  print(traceback.format_exception(exc_type, exc_value, exc_tb))

finally:
  try:
    cursor # vérifie sir cursor existe
  except NameError:
    # cursor n'existe pas
    print("Cursor is undefined")
  else: 
    # cursor existe 
    cursor.close() # Z! on peut pas fermer un cursor qui n'existe pas par exemple
  connection.close()
  os.chdir(cwd)
