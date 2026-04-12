from django.db import connection


def user_role_context(request):
    """ส่ง user_role และชื่อจริงให้ template ทุกหน้าอัตโนมัติ"""
    if not request.user.is_authenticated:
        return {'user_role': None, 'user_full_name': None}

    user_role = getattr(request, 'user_role', None)
    user_full_name = None

    try:
        with connection.cursor() as c:
            # 1. ถ้ายังไม่มี role ให้ดึงมาก่อน
            if not user_role:
                c.execute("SELECT role FROM dbo.USER_ACCOUNT WHERE username = %s", [request.user.username])
                row = c.fetchone()
                user_role = row[0] if row else None

            # 2. ดึงชื่อจริงตาม Role
            if user_role == 'vet':
                c.execute("""
                    SELECT first_name + ' ' + last_name 
                    FROM dbo.VETERINARIAN v
                    JOIN dbo.USER_ACCOUNT ua ON v.user_id = ua.user_id
                    WHERE ua.username = %s
                """, [request.user.username])
                row = c.fetchone()
                user_full_name = row[0] if row else None
            elif user_role == 'owner':
                c.execute("""
                    SELECT first_name + ' ' + last_name 
                    FROM dbo.OWNER o
                    JOIN dbo.USER_ACCOUNT ua ON o.user_id = ua.user_id
                    WHERE ua.username = %s
                """, [request.user.username])
                row = c.fetchone()
                user_full_name = row[0] if row else None
            elif user_role == 'admin':
                user_full_name = "Staff / เจ้าหน้าที่"
    except Exception:
        pass

    return {
        'user_role': user_role,
        'user_full_name': user_full_name or request.user.username
    }
