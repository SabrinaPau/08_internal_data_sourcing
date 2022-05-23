# We import a method from the  modules to address environment variables and 
# we use that method to save the variables from .env to a dictionary we call sql_config
from dotenv import dotenv_values

sql_config = dotenv_values(".env")

# Import the Python packages for get_data() function - worry about this only when we say so in the notebook


# Insert the get_data() function definition below - worry about this only when we say so in the notebook
