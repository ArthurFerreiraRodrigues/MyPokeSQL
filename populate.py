import os
from mysql.connector import connection
import pandas as pd

host = os.getenv('MYSQL_HOST')
port = os.getenv('MYSQL_PORT')
user = os.getenv('MYSQL_USER')
password = os.getenv('MYSQL_PASSWORD')
database = os.getenv('MYSQL_DATABASE')

conn = connection.MySQLConnection(
    host=host,
    port=int(port),
    user=user,
    passwd=password,
    db=database)

df = pd.read_csv('./scripts/Pokemon.csv')

def insert(table, columns, values):
    query = "INSERT INTO %s (%s) VALUES"
    query = query % (table, columns)
    
    for value in values:
        value = str(value).replace('[', '').replace(']', '').replace('nan', 'NULL')
        query += " (%s)," % value
    
    
    query = query[:-1] + ";"
    file = open('insert.sql', 'w')
    file.write(query)
    cursor = conn.cursor()
    cursor.execute(query)
    conn.commit()
    cursor.close()

columns = str(df.columns.to_list()).replace('[', '').replace(']', '').replace('\'', '')
values = df.values.tolist()
insert('pk_mon', columns, values)