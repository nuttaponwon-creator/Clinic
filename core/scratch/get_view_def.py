import os
import django
from django.db import connection

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myclinic.settings')
django.setup()

with connection.cursor() as cursor:
    cursor.execute("SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('dbo.VW_LOW_STOCK_MEDICINE')")
    row = cursor.fetchone()
    if row:
        print(row[0])
    else:
        print("View not found.")
