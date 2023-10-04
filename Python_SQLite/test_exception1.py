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
  one_row = connection.execute("SELECT * FROM users LIMIT 1;") # Faut pas faire des "connection.execute"
except sqlite3.ProgrammingError as e:
  print(e)
finally:
  os.chdir(cwd)