from django.db import connection
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myclinic.settings')
django.setup()

def check_schema():
    with connection.cursor() as cursor:
        cursor.execute("SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'VETERINARIAN'")
        columns = cursor.fetchall()
        for col in columns:
            print(f"{col[0]}: {col[1]}")

if __name__ == "__main__":
    check_schema()
