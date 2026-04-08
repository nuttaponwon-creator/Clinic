from django.db import connection
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myclinic.settings')
django.setup()

def check_images():
    with connection.cursor() as cursor:
        cursor.execute("SELECT vet_id, profile_image FROM dbo.VETERINARIAN")
        rows = cursor.fetchall()
        for row in rows:
            print(f"ID: {row[0]}, Image: {row[1]}")

if __name__ == "__main__":
    check_images()
