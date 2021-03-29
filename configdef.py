import sys
from configparser import ConfigParser
from sqlalchemy import create_engine

def config(filename='database.ini', section='postgres'):
    # create a parser
    parser = ConfigParser()
    # read config file
    parser.read(filename)
 
    # get section, default to postgresql
    db = {}
    
    # Checks to see if section (postgresql) parser exists
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
         
    # Returns an error if a parameter is called that is not listed in the initialization file
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))
 
    return db

def pg_engine_connection(host, port, user, password, database):
    try:
        engine = create_engine(f'postgres+psycopg2://{user}:{password}@{host}:{port}/{database}')
        print("Postgres Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return engine 