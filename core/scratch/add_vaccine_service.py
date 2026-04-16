import os
import django
from django.db import connection

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myclinic.settings')
django.setup()

with connection.cursor() as cursor:
    # Check if Vaccine service exists
    cursor.execute("SELECT service_id FROM dbo.SERVICE WHERE service_name LIKE '%วัคซีน%'")
    row = cursor.fetchone()
    if not row:
        print("Adding Vaccine service...")
        cursor.execute("""
            INSERT INTO dbo.SERVICE (service_name, price, is_active)
            VALUES (N'ฉีดวัคซีน', 0, 1)
        """)
        print("Success!")
    else:
        print("Vaccine service already exists.")
