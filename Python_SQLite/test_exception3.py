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

connection = sqlite3.connect('mydb.db') # create it if it does not exist:
connection.close()

# OK ça marche
# try:
#   one_row = connection.execute("SELECT * FROM users LIMIT 1;")
# except sqlite3.ProgrammingError as e:
#   print(e)
# finally:
#   os.chdir(cwd)

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
    cursor 
  except NameError:
    # cursor n'existe pas
    print("Cursor is undefined")
  else:  
    cursor.close() # Z! on peut pas fermer un cursor qui n'existe pas par exemple
  connection.close()
  os.chdir(cwd)



# https://stackoverflow.com/questions/25371636/how-to-get-sqlite-result-error-codes-in-python
# suppose the first column should be unique and there is already a database entry with "John" in the first column. 
# This will throw an IntegrityError,

# import sqlite3
# import traceback
# import sys

# con = sqlite3.connect("mydb.sqlite")
# cur = con.cursor() 
# sql_query = "INSERT INTO user VALUES(?, ?)"     
# sql_data = ("John", "MacDonald")

# try:
#     cur.execute(sql_query, sql_data)
#     con.commit()
# except sqlite3.Error as er:
#     print('SQLite error: %s' % (' '.join(er.args)))
#     print("Exception class is: ", er.__class__)
#     print('SQLite traceback: ')
#     exc_type, exc_value, exc_tb = sys.exc_info()
#     print(traceback.format_exception(exc_type, exc_value, exc_tb))
# #cur.close()
# con.close()


