import pyodbc

class DBConnUtil:
    def get_connection():
        try:
            conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=localhost\\SQLEXPRESS;'
        'DATABASE=LoanDB;'
        'Trusted_Connection=yes;'
    )
            return conn
        except Exception as e:
            print("Database connection failed:", str(e))
            raise

