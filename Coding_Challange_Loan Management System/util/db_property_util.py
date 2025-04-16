import configparser

def get_connection_string(file_name):
    try:
        config = configparser.ConfigParser()
        config.read(file_name)
        
        db_url = config.get('Database', 'db.url')
        
        return db_url
    except Exception as e:
        print(f"Error reading properties file: {e}")
        raise
