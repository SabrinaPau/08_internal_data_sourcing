import sys
from configparser import ConfigParser
import psycopg2
from psycopg2 import OperationalError, errorcodes, errors
from sqlalchemy import create_engine

def config(filename='database.ini', section='MySQL'):
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

def show_psycopg2_exception(err):
    # get details about the exception
    err_type, err_obj, traceback = sys.exc_info()    # get the line number when exception occured
    line_n = traceback.tb_lineno    # print the connect() error
    print ("\npsycopg2 ERROR:", err, "on line number:", line_n)
    print ("psycopg2 traceback:", traceback, "-- type:", err_type)    # psycopg2 extensions.Diagnostics object attribute
    print ("\nextensions.Diagnostics:", err.diag)    # print the pgcode and pgerror exceptions
    print ("pgerror:", err.pgerror)
    print ("pgcode:", err.pgcode, "\n")
    
def connect(conn_params_dic):
    conn = None
    try:
        print('Connecting to the PostgreSQL...........')
        conn = psycopg2.connect(**conn_params_dic)
        print("Connection successful..................")
        
    except OperationalError as err:
        # passing exception to function
        show_psycopg2_exception(err)        # set the connection to 'None' in case of error
        conn = None
    
    return conn

def pg_engine_connection(host, port, user, password, database):
    try:
        engine = create_engine(f'postgres+psycopg2://{user}:{password}@{host}:{port}/{database}')
        print("Postgres Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return engine