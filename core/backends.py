from django.contrib.auth.backends import BaseBackend
from django.contrib.auth.models import User
from django.contrib.auth.hashers import check_password
from django.db import connection


class UserAccountBackend(BaseBackend):
    """
    Custom authentication backend ที่ตรวจสอบ credentials จาก dbo.USER_ACCOUNT ใน SQL Server
    สร้าง Django shadow user สำหรับจัดการ session โดยอัตโนมัติ
    """

    def authenticate(self, request, username=None, password=None, **kwargs):
        if not username or not password:
            return None

        try:
            with connection.cursor() as c:
                c.execute("""
                    SELECT user_id, username, password_hash, role
                    FROM dbo.USER_ACCOUNT
                    WHERE username = %s
                """, [username])
                row = c.fetchone()
        except Exception:
            # กรณีเชื่อมต่อ SQL Server ไม่ได้ (เช่น Render + SQLite)
            return None

        if not row:
            return None

        user_id, uname, password_hash, role = row

        if not check_password(password, password_hash):
            return None

        # สร้าง/อัปเดต Django shadow user สำหรับ session management
        is_staff_role = role in ('admin', 'vet')
        try:
            django_user = User.objects.get(username=uname)
            if django_user.is_staff != is_staff_role:
                django_user.is_staff = is_staff_role
                django_user.save(update_fields=['is_staff'])
        except User.DoesNotExist:
            django_user = User.objects.create_user(
                username=uname,
                password=None,          
                is_staff=is_staff_role,
                is_active=True,
            )

        return django_user

    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None
