import os
import django
from django.db import connection

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myclinic.settings')
django.setup()

with connection.cursor() as cursor:
    print("Adding min_stock_qty to VACCINE...")
    try:
        cursor.execute("ALTER TABLE dbo.VACCINE ADD min_stock_qty INT DEFAULT 5 WITH VALUES")
    except Exception as e:
        print(f"Column might already exist: {e}")

    print("Creating VW_LOW_STOCK_VACCINE...")
    cursor.execute("""
        IF OBJECT_ID('dbo.VW_LOW_STOCK_VACCINE', 'V') IS NOT NULL
            DROP VIEW dbo.VW_LOW_STOCK_VACCINE;
    """)
    cursor.execute("""
        CREATE VIEW dbo.VW_LOW_STOCK_VACCINE
        AS
        SELECT vaccine_id, name, manufacturer, stock_qty, min_stock_qty, min_stock_qty - stock_qty AS shortage_qty
        FROM dbo.VACCINE
        WHERE (stock_qty < min_stock_qty) AND (is_active = 1)
    """)
    print("Done!")
