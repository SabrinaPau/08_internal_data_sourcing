# Connecting to SQL databases

In this repository we will work through the steps necessary for connecting to SQL databases in order to push new data to the database or query and further process data within your Jupyter Notebook.

## Objective
The two main tools of Data Analysts are SQL and Python.
Thus, knowing how to combine them is essential!  

As a Data Analyst your source data often will be in a database.
We will show you how to get it into pandas.
You may also want to push data you have manipulated to a database.  

To do so, you need to build a connection which the following Notebooks will guide you through.  

## Description of files included in this repo & Tasks

The [configdef file](configdef.py) will read the connection details from 'database.ini'.  

1. Create this database.ini file with the following format:

```
[connection_name]  
host = <server_name>  
port = <port_name>  
user = <user_name>  
password = <user_password>  
database = <db_to_use>  
```

For this project we use 'postgresql' as the connection name.   
Further connection details will be shared privately.      


2. Before we start create a new conda environment by using the environment.yml file.  
Use your terminal to navigate to your folder and use the following command:conda 
```conda env create -f environment.yml```  

Activate your new environment by typing:
```conda activate sql-practice```


3. Please work in pairs through all the notebooks in this particular order:

3.1 [Build connection, send data to database](Connect_to_db_1.ipynb)  
3.2 [Prepare more data for sending to database](Connect_to_db_2.ipynb)  
3.3 [Create your own table](Create_own_table.ipynb)  

Keep in mind, you succeed better as a team. There are NO stupid questions! If you already feel comfortable with the concepts, you might even learn more from teaching them!

    
**Find some help/support here**:

https://towardsdatascience.com/coding-and-implementing-a-relational-database-using-mysql-d9bc69be90f5

https://towardsdatascience.com/generating-random-data-into-a-database-using-python-fd2f7d54024e

https://towardsdatascience.com/python-and-postgresql-how-to-access-a-postgresql-database-like-a-data-scientist-b5a9c5a0ea43

https://python.plainenglish.io/how-to-import-a-csv-file-into-a-mysql-database-using-python-script-791b051c5c33

https://realpython.com/python-mysql/#reading-records-using-the-select-statement






