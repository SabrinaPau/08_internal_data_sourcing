# Connecting to PostgreSQL in Python
In this repository you're going to learn how to connect to PostgreSQL and retrieve data using dBeaver and Python.

## Why internal data sourcing?
The two main tools of Data Analysts are SQL and Python. Internal data is often stored in a database. Thus, knowing how to access data in an SQL database is the top skill for a data analyst. Being able to combine SQL and Python in order to access, retrieve and manipulate the data makes you a data rockstar!
## Tasks
Follow the lectures to work through the code-alongs and exercises using dbeaver.

As a final step we will return to working in jupyter notebooks. At this point follow the below instructions: 

For the Data Part-Time bootcamp:  
Create a new virtual environment in your repository based on:  
```pyenv local 3.11.3```  
```python -m venv .venv```  
```source .venv/bin/activate```  
```pip install --upgrade pip```  
```pip install jupyterlab```  
```pip install pandas```  
```pip install python-dotenv```  
```pip install sqlalchemy==1.4.39```   
```pip install psycopg2-binary```  

 
For the Data Analytics bootcamp:  
Create a new conda environment by cloning your nf_base environment.   
```conda create --clone nf_base --name nf_sql```  

Activate your new environment by typing:  
```conda activate nf_sql```

Add the new modules to your environment:  
```conda install -n nf_sql -c conda-forge python-dotenv```  
```conda install -n nf_sql sqlalchemy=1.4.39```  
```conda install -n nf_sql -c conda-forge psycopg2```

Please work in pairs through all the notebooks in this particular order: 

Keep in mind, you succeed better as a team.  
There are NO stupid questions! If you already feel comfortable with the concepts, you might even learn more from teaching them!
    
**Find some help/support here**:

https://towardsdatascience.com/coding-and-implementing-a-relational-database-using-mysql-d9bc69be90f5

https://towardsdatascience.com/generating-random-data-into-a-database-using-python-fd2f7d54024e

https://towardsdatascience.com/python-and-postgresql-how-to-access-a-postgresql-database-like-a-data-scientist-b5a9c5a0ea43

https://python.plainenglish.io/how-to-import-a-csv-file-into-a-mysql-database-using-python-script-791b051c5c33

https://realpython.com/python-mysql/#reading-records-using-the-select-statement






