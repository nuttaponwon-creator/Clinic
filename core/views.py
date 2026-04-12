from functools import wraps
from django.db import connection, transaction
from django.shortcuts import render, redirect
from django.contrib import messages
from datetime import datetime
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status


# ===== Helper: get_user_role =====
def get_user_role(username):
    """ดึง role จาก USER_ACCOUNT (admin / vet / owner)"""
    try:
        with connection.cursor() as c:
            c.execute("SELECT role FROM dbo.USER_ACCOUNT WHERE username = %s", [username])
            row = c.fetchone()
            if row:
                return row[0]
    except Exception:
        pass
    return None


def get_vet_id_from_user(request):
    """ดึง vet_id สำหรับ User ที่ Login อยู่ (ถ้ามี)"""
    try:
        with connection.cursor() as c:
            c.execute("""
                SELECT v.vet_id 
                FROM dbo.VETERINARIAN v
                JOIN dbo.USER_ACCOUNT l ON v.user_id = l.user_id
                WHERE l.username = %s
            """, [request.user.username])
            row = c.fetchone()
            if row:
                return row[0]
    except Exception:
        pass
    return None


# ===== Staff Required Decorator =====
def staff_required(view_func):
    """อนุญาตเฉพาะ role admin และ vet เท่านั้น + ส่ง user_role ไปให้ template"""
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('login')
        if not request.user.is_staff:
            messages.error(request, 'คุณไม่มีสิทธิ์เข้าถึงหน้านี้')
            return redirect('home')
        # แนบ role ไว้กับ request เพื่อส่งต่อไป template
        request.user_role = get_user_role(request.user.username)
        return view_func(request, *args, **kwargs)
    return wrapper


# ===== Admin Only Decorator =====
def admin_only(view_func):
    """อนุญาตเฉพาะ role admin เท่านั้น (เจ้าหน้าที่)"""
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('login')
        role = get_user_role(request.user.username)
        if role != 'admin':
            messages.error(request, 'เฉพาะเจ้าหน้าที่เท่านั้นที่เข้าถึงหน้านี้ได้')
            return redirect('dashboard')
        request.user_role = role
        return view_func(request, *args, **kwargs)
    return wrapper


# ===== Helper: get_owner_by_user =====
def get_owner_by_user(username):
    """ดึงข้อมูล OWNER ที่ผูกกับ USER_ACCOUNT.username นั้น"""
    try:
        with connection.cursor() as c:
            c.execute("""
                SELECT o.*
                FROM dbo.OWNER o
                JOIN dbo.USER_ACCOUNT ua ON o.user_id = ua.user_id
                WHERE ua.username = %s
            """, [username])
            row = c.fetchone()
            if row:
                cols = [col[0] for col in c.description]
                return dict(zip(cols, row))
    except Exception:
        pass
    return None



def dictfetchall(cursor):
    columns = [col[0] for col in cursor.description]
    return [dict(zip(columns, row)) for row in cursor.fetchall()]


def dictfetchone(cursor):
    columns = [col[0] for col in cursor.description]
    row = cursor.fetchone()
    return dict(zip(columns, row)) if row else None


def clean_value(val, val_type='str'):
    """แปลงค่าจาก form ให้เหมาะกับ SQL Server"""
    if val is None or val == '':
        return None
    if val_type == 'int':
        try:
            return int(val)
        except (ValueError, TypeError):
            return None
    if val_type == 'float':
        try:
            return float(val)
        except (ValueError, TypeError):
            return None
    if val_type == 'date':
        return val if val else None
    if val_type == 'datetime':
        return val.replace('T', ' ') if val else None
    return val


# ===========================================================
#  AUTH — Login / Register / Logout
# ===========================================================
def user_login(request):
    if request.user.is_authenticated:
        return redirect('home')

    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth_login(request, user)
            return redirect('home')
        else:
            return render(request, 'auth/login.html', {
                'error': 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'
            })

    return render(request, 'auth/login.html')


def user_register(request):
    if request.user.is_authenticated:
        return redirect('home')

    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '')
        password2 = request.POST.get('password2', '')

        form_data = request.POST.dict()

        first_name = request.POST.get('first_name', '').strip()
        last_name = request.POST.get('last_name', '').strip()
        email = request.POST.get('email', '').strip() or None
        phone = request.POST.get('phone', '').strip()

        if not username or not password or not phone:
            return render(request, 'auth/register.html', {
                'error': 'กรุณากรอกชื่อผู้ใช้ รหัสผ่าน และเบอร์โทรศัพท์',
                'form_data': form_data,
            })

        if password != password2:
            return render(request, 'auth/register.html', {
                'error': 'รหัสผ่านไม่ตรงกัน',
                'form_data': form_data,
            })

        if len(password) < 6:
            return render(request, 'auth/register.html', {
                'error': 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร',
                'form_data': form_data,
            })

        # ตรวจสอบใน USER_ACCOUNT (ไม่ใช่ Django auth)
        with connection.cursor() as c:
            c.execute("SELECT COUNT(*) FROM dbo.USER_ACCOUNT WHERE username = %s", [username])
            if c.fetchone()[0] > 0:
                return render(request, 'auth/register.html', {
                    'error': f'ชื่อผู้ใช้ "{username}" ถูกใช้ไปแล้ว',
                    'form_data': form_data,
                })

        # สร้าง USER_ACCOUNT ด้วย role = 'owner' และเอา user_id มาสร้าง/ลิงก์ OWNER
        try:
            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")
                c.execute("""
                    INSERT INTO dbo.USER_ACCOUNT
                        (username, password_hash, role, created_at)
                    OUTPUT inserted.user_id
                    VALUES (%s, %s, 'owner', GETDATE())
                """, [username, make_password(password)])
                user_id = int(c.fetchone()[0])

                # ตรวจสอบว่าเบอร์โทรนี้มี OWNER อยู่รึเปล่า
                c.execute("SELECT owner_id, user_id FROM dbo.OWNER WHERE phone = %s", [phone])
                owner_row = c.fetchone()
                if owner_row:
                    owner_id = owner_row[0]
                    # ควบรวมถ้ายังไม่มี user_id
                    c.execute("""
                        UPDATE dbo.OWNER SET first_name = %s, last_name = %s, 
                        email = COALESCE(%s, email), user_id = %s
                        WHERE owner_id = %s
                    """, [first_name, last_name, email, user_id, owner_id])
                else:
                    # สร้าง OWNER ใหม่
                    c.execute("""
                        INSERT INTO dbo.OWNER (first_name, last_name, phone, email, user_id)
                        VALUES (%s, %s, %s, %s, %s)
                    """, [first_name, last_name, phone, email, user_id])
            return render(request, 'auth/login.html', {
                'success': 'สมัครสมาชิกสำเร็จ! กรุณาเข้าสู่ระบบ'
            })
        except Exception as e:
            return render(request, 'auth/register.html', {
                'error': f'เกิดข้อผิดพลาด: {e}',
                'form_data': form_data,
            })

    return render(request, 'auth/register.html')


def user_logout(request):
    auth_logout(request)
    return redirect('home')


# ===========================================================
#  DASHBOARD
# ===========================================================
@staff_required
def dashboard(request):
    with connection.cursor() as c:
        c.execute("SELECT COUNT(*) FROM dbo.PET WHERE is_active = 1")
        total_pets = c.fetchone()[0]

        c.execute("SELECT COUNT(*) FROM dbo.OWNER")
        total_owners = c.fetchone()[0]

        c.execute("SELECT COUNT(*) FROM dbo.VETERINARIAN WHERE is_active = 1")
        total_vets = c.fetchone()[0]

        c.execute("SELECT COUNT(*) FROM dbo.VW_UPCOMING_APPOINTMENTS")
        total_appointments = c.fetchone()[0]

        c.execute("SELECT TOP 5 * FROM dbo.VW_UPCOMING_APPOINTMENTS ORDER BY appt_datetime")
        upcoming_appointments = dictfetchall(c)

        c.execute("SELECT TOP 10 * FROM dbo.VW_VACCINE_DUE_SOON ORDER BY days_until_due")
        vaccine_due_soon = dictfetchall(c)

        c.execute("SELECT * FROM dbo.VW_LOW_STOCK_MEDICINE ORDER BY shortage_qty DESC")
        low_stock_medicine = dictfetchall(c)

        c.execute("SELECT first_name + ' ' + last_name as name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1")
        active_vets = dictfetchall(c)

    return render(request, 'dashboard.html', {
        'active_page': 'dashboard',
        'total_pets': total_pets,
        'total_owners': total_owners,
        'total_vets': total_vets,
        'total_appointments': total_appointments,
        'upcoming_appointments': upcoming_appointments,
        'vaccine_due_soon': vaccine_due_soon,
        'low_stock_medicine': low_stock_medicine,
        'active_vets': active_vets,
    })


# ===========================================================
#  PETS — List
# ===========================================================
@staff_required
def pet_list(request):
    show_all = request.GET.get('show_all') == '1'
    with connection.cursor() as c:
        query = """
            SELECT v.*, p.is_active, dbo.FN_PET_AGE(p.date_of_birth) AS age_display 
            FROM dbo.VW_PET_FULL v
            JOIN dbo.PET p ON v.pet_id = p.pet_id
        """
        if not show_all:
            query += " WHERE p.is_active = 1"
        query += " ORDER BY v.pet_id"
        c.execute(query)
        pets = dictfetchall(c)

    return render(request, 'pets.html', {
        'active_page': 'pets',
        'pets': pets,
        'show_all': show_all,
    })


# ===========================================================
#  PETS — Add
# ===========================================================
@staff_required
def pet_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    INSERT INTO dbo.PET
                        (owner_id, name, species_id, breed_id, date_of_birth,
                         gender, weight_kg, is_neutered, primary_vet_id, is_active)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, 1)
                """, [
                    clean_value(request.POST['owner_id'], 'int'),
                    request.POST['name'],
                    clean_value(request.POST['species_id'], 'int'),
                    clean_value(request.POST.get('breed_id'), 'int'),
                    clean_value(request.POST.get('date_of_birth'), 'date'),
                    request.POST.get('gender') or 'U',
                    clean_value(request.POST.get('weight_kg'), 'float'),
                    clean_value(request.POST.get('is_neutered', '0'), 'int'),
                    clean_value(request.POST.get('primary_vet_id'), 'int'),
                ])
            messages.success(request, 'เพิ่มสัตว์เลี้ยงสำเร็จ!')
            return redirect('pet_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    # GET — โหลดข้อมูลสำหรับ dropdown
    with connection.cursor() as c:
        c.execute("SELECT owner_id, first_name, last_name, phone FROM dbo.OWNER ORDER BY first_name")
        owners = dictfetchall(c)
        c.execute("SELECT species_id, species_name FROM dbo.SPECIES WHERE is_active = 1 ORDER BY species_name")
        species = dictfetchall(c)
        c.execute("SELECT breed_id, species_id, breed_name FROM dbo.BREED WHERE is_active = 1 ORDER BY breed_name")
        breeds = dictfetchall(c)
        c.execute("SELECT vet_id, first_name, last_name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'pet_form.html', {
        'active_page': 'pets',
        'owners': owners,
        'species': species,
        'breeds': breeds,
        'vets': vets,
        'pet': None,
    })


# ===========================================================
#  PETS — Edit
# ===========================================================
@staff_required
def pet_edit(request, pet_id):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    UPDATE dbo.PET SET
                        owner_id = %s, name = %s, species_id = %s, breed_id = %s,
                        date_of_birth = %s, gender = %s, weight_kg = %s,
                        is_neutered = %s, primary_vet_id = %s, is_active = %s
                    WHERE pet_id = %s
                """, [
                    clean_value(request.POST['owner_id'], 'int'),
                    request.POST['name'],
                    clean_value(request.POST['species_id'], 'int'),
                    clean_value(request.POST.get('breed_id'), 'int'),
                    clean_value(request.POST.get('date_of_birth'), 'date'),
                    request.POST.get('gender') or 'U',
                    clean_value(request.POST.get('weight_kg'), 'float'),
                    clean_value(request.POST.get('is_neutered', '0'), 'int'),
                    clean_value(request.POST.get('primary_vet_id'), 'int'),
                    clean_value(request.POST.get('is_active', '1'), 'int'),
                    pet_id,
                ])
            messages.success(request, 'แก้ไขข้อมูลสัตว์เลี้ยงสำเร็จ!')
            return redirect('pet_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    # GET — โหลดข้อมูลย้อนกลับ
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.PET WHERE pet_id = %s", [pet_id])
        pet = dictfetchone(c)
        c.execute("SELECT owner_id, first_name, last_name, phone FROM dbo.OWNER ORDER BY first_name")
        owners = dictfetchall(c)
        c.execute("SELECT species_id, species_name FROM dbo.SPECIES WHERE is_active = 1 ORDER BY species_name")
        species = dictfetchall(c)
        c.execute("SELECT breed_id, species_id, breed_name FROM dbo.BREED WHERE is_active = 1 ORDER BY breed_name")
        breeds = dictfetchall(c)
        c.execute("SELECT vet_id, first_name, last_name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'pet_form.html', {
        'active_page': 'pets',
        'pet': pet,
        'owners': owners,
        'species': species,
        'breeds': breeds,
        'vets': vets,
    })


# ===========================================================
#  OWNERS — List
# ===========================================================
@staff_required
def owner_list(request):
    show_all = request.GET.get('show_all') == '1'
    with connection.cursor() as c:
        query = "SELECT * FROM dbo.OWNER"
        if not show_all:
            query += " WHERE is_active = 1"
        query += " ORDER BY owner_id"
        c.execute(query)
        owners = dictfetchall(c)

    return render(request, 'owners.html', {
        'active_page': 'owners',
        'owners': owners,
        'show_all': show_all,
    })


# ===========================================================
#  OWNERS — Add
# ===========================================================
@staff_required
def owner_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    INSERT INTO dbo.OWNER (first_name, last_name, phone, email, address)
                    VALUES (%s, %s, %s, %s, %s)
                """, [
                    request.POST['first_name'],
                    request.POST['last_name'],
                    request.POST['phone'],
                    request.POST.get('email') or None,
                    request.POST.get('address') or None,
                ])
            messages.success(request, 'เพิ่มเจ้าของสำเร็จ!')
            return redirect('owner_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return render(request, 'owner_form.html', {
        'active_page': 'owners',
        'owner': None,
    })


# ===========================================================
#  OWNERS — Edit
# ===========================================================
@staff_required
def owner_edit(request, owner_id):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    UPDATE dbo.OWNER SET
                        first_name = %s, last_name = %s, phone = %s,
                        email = %s, address = %s
                    WHERE owner_id = %s
                """, [
                    request.POST['first_name'],
                    request.POST['last_name'],
                    request.POST['phone'],
                    request.POST.get('email') or None,
                    request.POST.get('address') or None,
                    owner_id,
                ])
            messages.success(request, 'แก้ไขข้อมูลเจ้าของสำเร็จ!')
            return redirect('owner_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.OWNER WHERE owner_id = %s", [owner_id])
        owner = dictfetchone(c)

    return render(request, 'owner_form.html', {
        'active_page': 'owners',
        'owner': owner,
    })


# ===========================================================
#  APPOINTMENTS — List
# ===========================================================
@staff_required
def appointment_list(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VW_UPCOMING_APPOINTMENTS ORDER BY appt_datetime")
        appointments = dictfetchall(c)

    return render(request, 'appointments.html', {
        'active_page': 'appointments',
        'appointments': appointments,
    })


# ===========================================================
#  APPOINTMENTS — Add
# ===========================================================
@staff_required
def appointment_add(request):
    if request.method == 'POST':
        try:
            appt_date = request.POST.get('appt_date', '').strip()
            appt_time = request.POST.get('appt_time', '').strip()
            appt_datetime_str = f"{appt_date} {appt_time}" if appt_date and appt_time else None

            with connection.cursor() as c:
                # ถ้าไม่เลือกหมอ และคนจองเป็น Vet -> ให้หมอนั้นเป็นคนรับผิดชอบทันที
                vet_id = clean_value(request.POST.get('vet_id'), 'int')
                if not vet_id and request.user_role == 'vet':
                    vet_id = get_vet_id_from_user(request)

                # อัปเดตเพศสัตว์ถ้ามีการระบุมา (เพื่อความสะดวกในการจัดการข้อมูล)
                gender = request.POST.get('gender')
                pet_id = clean_value(request.POST['pet_id'], 'int')
                if gender in ['M', 'F']:
                    c.execute("UPDATE dbo.PET SET gender = %s WHERE pet_id = %s", [gender, pet_id])

                c.execute("""
                    INSERT INTO dbo.APPOINTMENT (pet_id, vet_id, appt_datetime, reason, notes)
                    VALUES (%s, %s, %s, %s, %s)
                """, [
                    pet_id,
                    vet_id,
                    clean_value(appt_datetime_str, 'datetime'),
                    request.POST.get('reason') or None,
                    request.POST.get('notes') or None,
                ])
            messages.success(request, 'สร้างนัดหมายสำเร็จ!')
            return redirect('appointment_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    with connection.cursor() as c:
        c.execute("""
            SELECT p.pet_id, p.name,
                   o.first_name + ' ' + o.last_name AS owner_name
            FROM dbo.PET p
            JOIN dbo.OWNER o ON p.owner_id = o.owner_id
            WHERE p.is_active = 1
            ORDER BY p.name
        """)
        pets = dictfetchall(c)
        c.execute("SELECT vet_id, first_name, last_name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'appointment_form.html', {
        'active_page': 'appointments',
        'pets': pets,
        'vets': vets,
    })


# ===========================================================
#  VETS — List (Admin only)
# ===========================================================
@admin_only
def vet_list(request):
    show_all = request.GET.get('show_all') == '1'
    with connection.cursor() as c:
        # ใช้ VW_VET_WORKLOAD แต่เช็ค is_active จาก VETERINARIAN
        query = """
            SELECT vw.*, v.is_active 
            FROM dbo.VW_VET_WORKLOAD vw
            JOIN dbo.VETERINARIAN v ON vw.vet_id = v.vet_id
        """
        if not show_all:
            query += " WHERE v.is_active = 1"
        query += " ORDER BY vw.vet_id"
        
        c.execute(query)
        vets = dictfetchall(c)

    return render(request, 'vets.html', {
        'active_page': 'vets',
        'vets': vets,
        'show_all': show_all,
    })


# ===========================================================
#  VETS — Add (Admin only)
# ===========================================================
@admin_only
def vet_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    INSERT INTO dbo.VETERINARIAN
                        (first_name, last_name, specialization, phone, email, is_active)
                    VALUES (%s, %s, %s, %s, %s, 1)
                """, [
                    request.POST['first_name'],
                    request.POST['last_name'],
                    request.POST.get('specialization') or None,
                    request.POST.get('phone') or None,
                    request.POST.get('email') or None,
                ])
            messages.success(request, 'เพิ่มข้อมูลสัตวแพทย์สำเร็จ!')
            return redirect('vet_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return render(request, 'vet_form.html', {
        'active_page': 'vets',
    })


# ===========================================================
#  VETS — Edit (Admin only)
# ===========================================================
@admin_only
def vet_edit(request, vet_id):
    if request.method == 'POST':
        try:
            is_active = 1 if request.POST.get('is_active') else 0
            with connection.cursor() as c:
                c.execute("""
                    UPDATE dbo.VETERINARIAN SET
                        first_name = %s, last_name = %s, specialization = %s,
                        phone = %s, email = %s, is_active = %s
                    WHERE vet_id = %s
                """, [
                    request.POST['first_name'],
                    request.POST['last_name'],
                    request.POST.get('specialization') or None,
                    request.POST.get('phone') or None,
                    request.POST.get('email') or None,
                    is_active,
                    vet_id,
                ])
            messages.success(request, 'อัปเดตข้อมูลสัตวแพทย์สำเร็จ!')
            return redirect('vet_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VETERINARIAN WHERE vet_id = %s", [vet_id])
        vet = dictfetchone(c)

    return render(request, 'vet_form.html', {
        'active_page': 'vets',
        'vet': vet,
    })


# ===========================================================
#  APPOINTMENTS — Update Status (admin + vet)
# ===========================================================
@staff_required
def appointment_update_status(request, appt_id):
    if request.method == 'POST':
        new_status = request.POST.get('status')
        allowed_statuses = ['Scheduled', 'Completed', 'Cancelled', 'No-show']
        if new_status in allowed_statuses:
            try:
                with connection.cursor() as c:
                    # ถ้าคนกดอัปเดตเป็นสัตวแพทย์ ให้บันทึกว่าเป็นคนดูแลเคสนี้ (ถ้ายังไม่มี หรือต้องการเปลี่ยน)
                    if request.user_role == 'vet':
                        vet_id_acting = get_vet_id_from_user(request)
                        if vet_id_acting:
                            c.execute("""
                                UPDATE dbo.APPOINTMENT SET status = %s, vet_id = %s WHERE appt_id = %s
                            """, [new_status, vet_id_acting, appt_id])
                        else:
                            c.execute("UPDATE dbo.APPOINTMENT SET status = %s WHERE appt_id = %s", [new_status, appt_id])
                    else:
                        c.execute("UPDATE dbo.APPOINTMENT SET status = %s WHERE appt_id = %s", [new_status, appt_id])
                status_labels = {
                    'Scheduled': 'รอยืนยัน/จองแล้ว',
                    'Completed': 'เสร็จสิ้น',
                    'Cancelled': 'ยกเลิก',
                    'No-show': 'ไม่มาตามนัด',
                }
                messages.success(request, f'อับเดตสถานะเป็น "{status_labels.get(new_status, new_status)}" แล้ว!')
            except Exception as e:
                messages.error(request, f'เกิดข้อผิดพลาด: {e}')
        else:
            messages.error(request, 'สถานะไม่ถูกต้อง')
    return redirect('appointment_list')


# ===========================================================
#  MEDICAL RECORDS — Record Treatment & Prescription
# ===========================================================
@staff_required
def record_treatment(request, appt_id):
    with connection.cursor() as c:
        # ดึงรายละเอียดการนัดหมาย
        c.execute("""
            SELECT a.appt_id, a.pet_id, a.vet_id, a.appt_datetime, a.reason,
                   p.name as pet_name, s.species_name as species,
                   v.first_name + ' ' + v.last_name as vet_name
            FROM dbo.APPOINTMENT a
            JOIN dbo.PET p ON a.pet_id = p.pet_id
            JOIN dbo.SPECIES s ON p.species_id = s.species_id
            JOIN dbo.VETERINARIAN v ON a.vet_id = v.vet_id
            WHERE a.appt_id = %s
        """, [appt_id])
        appt = dictfetchone(c)

    if not appt:
        messages.error(request, "ไม่พบข้อมูลการนัดหมาย / Appointment not found")
        return redirect('appointment_list')

    if request.method == 'POST':
        try:
            with transaction.atomic():
                with connection.cursor() as c:
                    # 1. บันทึก MEDICAL_RECORD
                    weight = request.POST.get('weight_at_visit') or None
                    complaint = request.POST.get('chief_complaint')
                    diagnosis = request.POST.get('diagnosis')
                    treatment_desc = request.POST.get('treatment')
                    notes = request.POST.get('notes')
                    follow_up = request.POST.get('follow_up_date') or None
                    now = datetime.now()

                    # หา ID หมอที่กำลังรักษาวันนี้ (เพื่อบันทึกลงประวัติ)
                    current_vet_id = appt['vet_id']
                    if request.user_role == 'vet':
                        acting_vet = get_vet_id_from_user(request)
                        if acting_vet:
                            current_vet_id = acting_vet

                    c.execute("""
                        INSERT INTO dbo.MEDICAL_RECORD 
                        (appt_id, pet_id, vet_id, visit_date, chief_complaint, diagnosis, treatment, notes, weight_at_visit, follow_up_date, created_at)
                        OUTPUT INSERTED.record_id
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """, [appt_id, appt['pet_id'], current_vet_id, now.date(), complaint, diagnosis, treatment_desc, notes, weight, follow_up, now])
                    
                    record_id = c.fetchone()[0]

                    # 2. บันทึก RECORD_SERVICE (รายการบริการ)
                    service_ids = request.POST.getlist('service_ids[]')
                    service_prices = request.POST.getlist('service_prices[]')
                    service_notes = request.POST.getlist('service_notes[]')

                    for i in range(len(service_ids)):
                        if service_ids[i]:
                            c.execute("""
                                INSERT INTO dbo.RECORD_SERVICE (record_id, service_id, price_charged, notes, created_at)
                                VALUES (%s, %s, %s, %s, %s)
                            """, [record_id, service_ids[i], service_prices[i], service_notes[i], now])

                    # 3. บันทึก PRESCRIPTION (การสั่งยา) และหักสต็อก
                    medicine_ids = request.POST.getlist('medicine_ids[]')
                    qty_dispensed = request.POST.getlist('qty_dispensed[]')
                    dosages = request.POST.getlist('dosages[]')
                    durations = request.POST.getlist('duration_days[]')
                    instructions = request.POST.getlist('instructions[]')

                    for i in range(len(medicine_ids)):
                        if medicine_ids[i]:
                            q = int(qty_dispensed[i])
                            # บันทึกใบสั่งยา
                            c.execute("""
                                INSERT INTO dbo.PRESCRIPTION (record_id, medicine_id, dosage, duration_days, qty_dispensed, instructions, created_at)
                                VALUES (%s, %s, %s, %s, %s, %s, %s)
                            """, [record_id, medicine_ids[i], dosages[i], durations[i], q, instructions[i], now])
                            
                            # หักสต็อกยา
                            c.execute("""
                                UPDATE dbo.MEDICINE SET stock_qty = stock_qty - %s WHERE medicine_id = %s
                            """, [q, medicine_ids[i]])

                    # 4. อัปเดตสถานะนัดหมายเป็น Completed และอัปเดตหมอผู้รักษา (ถ้าเป็นหมอกด)
                    if request.user_role == 'vet':
                        vet_id_acting = get_vet_id_from_user(request)
                        if vet_id_acting:
                            c.execute("UPDATE dbo.APPOINTMENT SET status = 'Completed', vet_id = %s WHERE appt_id = %s", [vet_id_acting, appt_id])
                        else:
                            c.execute("UPDATE dbo.APPOINTMENT SET status = 'Completed' WHERE appt_id = %s", [appt_id])
                    else:
                        c.execute("UPDATE dbo.APPOINTMENT SET status = 'Completed' WHERE appt_id = %s", [appt_id])

            messages.success(request, f"บันทึกการรักษาของ {appt['pet_name']} เรียบร้อยแล้ว!")
            return redirect('appointment_list')

        except Exception as e:
            messages.error(request, f"เกิดข้อผิดพลาดในการบันทึก: {e}")

    # GET — โหลดข้อมูลสำหรับ Dropdowns
    with connection.cursor() as c:
        c.execute("SELECT service_id, service_name, price FROM dbo.SERVICE WHERE is_active = 1 ORDER BY service_name")
        services = dictfetchall(c)
        c.execute("SELECT medicine_id, name, unit, stock_qty FROM dbo.MEDICINE WHERE is_active = 1 ORDER BY name")
        medicines = dictfetchall(c)

    return render(request, 'record_treatment.html', {
        'appt': appt,
        'services': services,
        'medicines': medicines
    })


# ===========================================================
#  GLOBAL — Toggle Active/Inactive Status
# ===========================================================
@admin_only
def toggle_active_status(request, entity, item_id):
    """ฟังก์ชันกลางสำหรับเปิด/ปิดการใช้งาน (is_active) ของตารางต่างๆ"""
    mapping = {
        'pet': ('dbo.PET', 'pet_id', 'pet_list'),
        'owner': ('dbo.OWNER', 'owner_id', 'owner_list'),
        'vet': ('dbo.VETERINARIAN', 'vet_id', 'vet_list'),
        'vaccine': ('dbo.VACCINE', 'vaccine_id', 'vaccine_list'),
        'medicine': ('dbo.MEDICINE', 'medicine_id', 'medicine_list'),
        'service': ('dbo.SERVICE', 'service_id', 'dashboard'),
    }

    if entity not in mapping:
        messages.error(request, "ไม่พบประเภทข้อมูลที่ระบุ")
        return redirect('dashboard')

    table, pk_col, redirect_name = mapping[entity]
    
    try:
        with connection.cursor() as c:
            # 1) ดึงสถานะปัจจุบันมาสลับ
            c.execute(f"SELECT is_active FROM {table} WHERE {pk_col} = %s", [item_id])
            row = c.fetchone()
            if row:
                new_status = 1 if row[0] == 0 else 0
                c.execute(f"UPDATE {table} SET is_active = %s WHERE {pk_col} = %s", [new_status, item_id])
                
                msg = "เปิดการใช้งาน" if new_status == 1 else "ปิดการใช้งาน"
                messages.success(request, f"{msg}เรียบร้อยแล้ว!")
            else:
                messages.error(request, "ไม่พบข้อมูลที่ต้องการเปลี่ยนสถานะ")
    except Exception as e:
        messages.error(request, f"เกิดข้อผิดพลาด: {e}")

    # กรณีพิเศษ: ถ้ามาจากหน้าอื่น ให้กลับไปหน้านั้น (ถ้าส่งมา)
    next_url = request.GET.get('next')
    if next_url:
        return redirect(next_url)
        
    return redirect(redirect_name)


# ===========================================================
#  VACCINES — List + Record
# ===========================================================
@staff_required
def vaccine_list(request):
    show_all = request.GET.get('show_all') == '1'
    with connection.cursor() as c:
        # ข้อมูลวัคซีนทั้งหมด
        query = "SELECT * FROM dbo.VACCINE"
        if not show_all:
            query += " WHERE is_active = 1"
        query += " ORDER BY vaccine_id"
        c.execute(query)
        vaccines = dictfetchall(c)

        # วัคซีนที่ยัง active (สำหรับ form dropdown)
        c.execute("SELECT vaccine_id, name, stock_qty FROM dbo.VACCINE WHERE is_active = 1 AND stock_qty > 0 ORDER BY name")
        active_vaccines = dictfetchall(c)

        # สัตว์เลี้ยง (สำหรับ dropdown)
        c.execute("""
            SELECT p.pet_id, p.name,
                   o.first_name + ' ' + o.last_name AS owner_name
            FROM dbo.PET p
            JOIN dbo.OWNER o ON p.owner_id = o.owner_id
            WHERE p.is_active = 1
            ORDER BY p.name
        """)
        pets = dictfetchall(c)

        # สัตวแพทย์
        c.execute("SELECT vet_id, first_name, last_name FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

        # ประวัติฉีดวัคซีนล่าสุด 20 รายการ
        c.execute("""
            SELECT TOP 20
                vr.vacc_record_id, vr.given_date, vr.next_due_date, vr.notes,
                dbo.FN_NEXT_VACCINE(vr.pet_id) AS next_due_calc,
                p.name AS pet_name,
                o.first_name + ' ' + o.last_name AS owner_name,
                vc.name AS vaccine_name,
                v.first_name + ' ' + v.last_name AS vet_name
            FROM dbo.VACCINATION_RECORD vr
            JOIN dbo.PET p ON vr.pet_id = p.pet_id
            JOIN dbo.OWNER o ON p.owner_id = o.owner_id
            JOIN dbo.VACCINE vc ON vr.vaccine_id = vc.vaccine_id
            JOIN dbo.VETERINARIAN v ON vr.vet_id = v.vet_id
            ORDER BY vr.given_date DESC, vr.created_at DESC
        """)
        recent_records = dictfetchall(c)

    return render(request, 'vaccines.html', {
        'active_page': 'vaccines',
        'vaccines': vaccines,
        'active_vaccines': active_vaccines,
        'pets': pets,
        'vets': vets,
        'recent_records': recent_records,
        'show_all': show_all,
    })


@staff_required
def vaccine_record_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")
                c.execute("""
                    INSERT INTO dbo.VACCINATION_RECORD
                        (pet_id, vaccine_id, vet_id, given_date, next_due_date, notes, created_at)
                    VALUES (%s, %s, %s, %s, %s, %s, GETDATE())
                """, [
                    clean_value(request.POST['pet_id'], 'int'),
                    clean_value(request.POST['vaccine_id'], 'int'),
                    clean_value(request.POST['vet_id'], 'int'),
                    clean_value(request.POST['given_date'], 'date'),
                    clean_value(request.POST.get('next_due_date'), 'date'),
                    request.POST.get('notes') or None,
                ])
                # ลดสต็อกวัคซีน
                c.execute("""
                    UPDATE dbo.VACCINE SET stock_qty = stock_qty - 1
                    WHERE vaccine_id = %s AND stock_qty > 0
                """, [clean_value(request.POST['vaccine_id'], 'int')])

            messages.success(request, 'บันทึกการฉีดวัคซีนสำเร็จ!')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return redirect('vaccine_list')


# ===========================================================
#  VACCINES — เพิ่มวัคซีนชนิดใหม่
# ===========================================================
@admin_only
def vaccine_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")
                c.execute("""
                    INSERT INTO dbo.VACCINE
                        (name, manufacturer, target_disease, validity_months,
                         stock_qty, storage_temp, is_active)
                    VALUES (%s, %s, %s, %s, %s, %s, 1)
                """, [
                    request.POST['name'].strip(),
                    request.POST.get('manufacturer', '').strip() or None,
                    request.POST.get('target_disease', '').strip() or None,
                    clean_value(request.POST.get('validity_months'), 'int'),
                    clean_value(request.POST.get('stock_qty', '0'), 'int') or 0,
                    request.POST.get('storage_temp', '').strip() or None,
                ])
            messages.success(request, 'เพิ่มวัคซีนใหม่สำเร็จ!')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return redirect('vaccine_list')


# ===========================================================
#  VACCINES — เติมสต็อก
# ===========================================================
@admin_only
def vaccine_restock(request):
    if request.method == 'POST':
        try:
            vaccine_id = clean_value(request.POST.get('vaccine_id'), 'int')
            qty = clean_value(request.POST.get('qty'), 'int') or 0

            if qty <= 0:
                messages.error(request, 'จำนวนต้องมากกว่า 0')
                return redirect('vaccine_list')

            with connection.cursor() as c:
                c.execute("""
                    UPDATE dbo.VACCINE SET stock_qty = stock_qty + %s
                    WHERE vaccine_id = %s
                """, [qty, vaccine_id])

                # ดึงชื่อวัคซีนเพื่อแสดงข้อความ
                c.execute("SELECT name FROM dbo.VACCINE WHERE vaccine_id = %s", [vaccine_id])
                row = c.fetchone()
                vac_name = row[0] if row else 'วัคซีน'

            messages.success(request, f'เติมสต็อก {vac_name} +{qty} สำเร็จ!')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return redirect('vaccine_list')


# ===========================================================
#  MEDICINES — List
# ===========================================================
@staff_required
def medicine_list(request):
    show_all = request.GET.get('show_all') == '1'
    with connection.cursor() as c:
        query = "SELECT * FROM dbo.MEDICINE"
        if not show_all:
            query += " WHERE is_active = 1"
        query += " ORDER BY medicine_id"
        c.execute(query)
        medicines = dictfetchall(c)

    return render(request, 'medicines.html', {
        'active_page': 'medicines',
        'medicines': medicines,
        'show_all': show_all,
    })


# ===========================================================
#  MEDICINES — เพิ่มยาชนิดใหม่ (Admin only)
# ===========================================================
@admin_only
def medicine_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")
                c.execute("""
                    INSERT INTO dbo.MEDICINE
                        (name, type, manufacturer, unit, stock_qty, min_stock_qty, price_per_unit, is_active)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, 1)
                """, [
                    request.POST['name'].strip(),
                    request.POST.get('type', '').strip() or None,
                    request.POST.get('manufacturer', '').strip() or None,
                    request.POST.get('unit', '').strip() or None,
                    clean_value(request.POST.get('stock_qty', '0'), 'int') or 0,
                    clean_value(request.POST.get('min_stock_qty', '10'), 'int') or 0,
                    clean_value(request.POST.get('price_per_unit', '0'), 'float') or 0.0,
                ])
            messages.success(request, 'เพิ่มยา/เวชภัณฑ์ใหม่สำเร็จ!')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return redirect('medicine_list')


# ===========================================================
#  MEDICINES — เติมสต็อก
# ===========================================================
@admin_only
def medicine_restock(request):
    if request.method == 'POST':
        try:
            medicine_id = clean_value(request.POST.get('medicine_id'), 'int')
            qty = clean_value(request.POST.get('qty'), 'int') or 0

            if qty <= 0:
                messages.error(request, 'จำนวนต้องมากกว่า 0')
                return redirect('medicine_list')

            with connection.cursor() as c:
                c.execute("""
                    UPDATE dbo.MEDICINE SET stock_qty = stock_qty + %s
                    WHERE medicine_id = %s
                """, [qty, medicine_id])

                c.execute("SELECT name FROM dbo.MEDICINE WHERE medicine_id = %s", [medicine_id])
                row = c.fetchone()
                med_name = row[0] if row else 'ยา'

            messages.success(request, f'เติมสต็อก {med_name} +{qty} สำเร็จ!')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return redirect('medicine_list')



# ===========================================================
#  API — Get Pets JSON (ของเดิมที่สร้างไว้)
# ===========================================================
@api_view(['GET'])
def api_get_all_pets(request):
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM dbo.VW_PET_FULL ORDER BY pet_id")
            pets = dictfetchall(cursor)

        return Response({
            'success': True,
            'total': len(pets),
            'data': pets,
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({
            'success': False,
            'error': str(e),
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# ===========================================================
#  PUBLIC — หน้าแรก (Landing Page)
# ===========================================================
def public_home(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.SERVICE WHERE is_active = 1 ORDER BY service_id")
        services = dictfetchall(c)

    return render(request, 'public/home.html', {
        'active_page': 'home',
        'services': services[:6],  # แสดง 6 บริการแรกในหน้าแรก
    })


# ===========================================================
#  PUBLIC — บริการทั้งหมด
# ===========================================================
def public_services(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.SERVICE WHERE is_active = 1 ORDER BY service_name")
        services = dictfetchall(c)

    return render(request, 'public/services.html', {
        'active_page': 'services',
        'services': services,
    })


# ===========================================================
#  PUBLIC — หน้า "ของฉัน" (My Page)
# ===========================================================
@login_required(login_url='login')
def my_page(request):
    if request.user.is_staff:
        return redirect('dashboard')

    owner = get_owner_by_user(request.user.username)

    if not owner:
        return render(request, 'public/my_page.html', {
            'active_page': 'my_page',
            'owner': None,
        })

    owner_id = owner['owner_id']
    with connection.cursor() as c:
        # สัตว์เลี้ยงทั้งหมด + อายุ + สายพันธุ์
        c.execute("""
            SELECT p.pet_id,
                   p.name AS pet_name,
                   sp.species_name,
                   ISNULL(b.breed_name, '-') AS breed_name,
                   p.gender,
                   p.weight_kg,
                   dbo.FN_PET_AGE(p.date_of_birth) AS age_display,
                   p.is_active
            FROM dbo.PET p
            LEFT JOIN dbo.SPECIES sp ON p.species_id = sp.species_id
            LEFT JOIN dbo.BREED b ON p.breed_id = b.breed_id
            WHERE p.owner_id = %s
            ORDER BY p.is_active DESC, p.pet_id
        """, [owner_id])
        pets = dictfetchall(c)

        # นัดหมายล่าสุด 5 รายการ
        c.execute("""
            SELECT TOP 5
                a.appt_datetime, a.reason, a.status,
                p.name AS pet_name,
                vt.first_name + ' ' + vt.last_name AS vet_name
            FROM dbo.APPOINTMENT a
            JOIN dbo.PET p ON a.pet_id = p.pet_id
            JOIN dbo.VETERINARIAN vt ON a.vet_id = vt.vet_id
            WHERE p.owner_id = %s
            ORDER BY a.appt_datetime DESC
        """, [owner_id])
        appointments = dictfetchall(c)

        # วัคซีนล่าสุด 5 รายการ
        c.execute("""
            SELECT TOP 5
                vr.given_date,
                vr.next_due_date,
                dbo.FN_NEXT_VACCINE(p.pet_id) AS next_due_calc,
                p.name AS pet_name,
                vc.name AS vaccine_name
            FROM dbo.VACCINATION_RECORD vr
            JOIN dbo.PET p ON vr.pet_id = p.pet_id
            JOIN dbo.VACCINE vc ON vr.vaccine_id = vc.vaccine_id
            WHERE p.owner_id = %s
            ORDER BY vr.given_date DESC
        """, [owner_id])
        vaccine_records = dictfetchall(c)

    return render(request, 'public/my_page.html', {
        'active_page': 'my_page',
        'owner': owner,
        'pets': pets,
        'appointments': appointments,
        'vaccine_records': vaccine_records,
    })



# ===========================================================
def public_booking(request):
    # ถ้า Login แล้วและไม่ใช่ Staff → ดึงข้อมูล OWNER มาใส่อัตโนมัติ
    owner = None
    if request.user.is_authenticated and not request.user.is_staff:
        owner = get_owner_by_user(request.user.username)

    if request.method == 'POST':
        try:
            phone = request.POST['phone'].strip()
            first_name = request.POST['first_name'].strip()
            last_name = request.POST['last_name'].strip()
            email = request.POST.get('email', '').strip() or None
            pet_name = request.POST['pet_name'].strip()
            species_id = clean_value(request.POST['species_id'], 'int')
            breed_id = clean_value(request.POST.get('breed_id'), 'int')
            service_id = clean_value(request.POST.get('service_id'), 'int')
            vet_id = clean_value(request.POST.get('vet_id'), 'int')
            appt_date = request.POST.get('appt_date', '').strip()
            appt_time = request.POST.get('appt_time', '').strip()
            appt_datetime_str = f"{appt_date} {appt_time}" if appt_date and appt_time else None
            appt_datetime = clean_value(appt_datetime_str, 'datetime')
            reason = request.POST.get('reason', '').strip() or None

            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")

                # 1) ดูว่าเจ้าของเบอร์นี้มีในระบบหรือยัง
                c.execute("SELECT owner_id FROM dbo.OWNER WHERE phone = %s", [phone])
                owner_row = c.fetchone()

                if owner_row:
                    owner_id = owner_row[0]
                    c.execute("""
                        UPDATE dbo.OWNER SET first_name = %s, last_name = %s,
                        email = COALESCE(%s, email)
                        WHERE owner_id = %s
                    """, [first_name, last_name, email, owner_id])
                    # ถ้า User วันนี้ Login อยู่และ OWNER.user_id ยังเป็น NULL → ผูกให้
                    if owner and not owner_row[0] == owner.get('owner_id'):
                        pass  # already linked via get_owner_by_user
                    if request.user.is_authenticated and not request.user.is_staff:
                        c.execute("""
                            UPDATE dbo.OWNER SET user_id = (
                                SELECT user_id FROM dbo.USER_ACCOUNT WHERE username = %s
                            ) WHERE owner_id = %s AND user_id IS NULL
                        """, [request.user.username, owner_id])
                else:
                    # สร้างเจ้าของใหม่
                    c.execute("""
                        INSERT INTO dbo.OWNER (first_name, last_name, phone, email)
                        OUTPUT inserted.owner_id
                        VALUES (%s, %s, %s, %s)
                    """, [first_name, last_name, phone, email])
                    owner_id = int(c.fetchone()[0])
                    # ถ้า Login อยู่ → ผูก OWNER ใหม่นี้กับ account ทันที
                    if request.user.is_authenticated and not request.user.is_staff:
                        c.execute("""
                            UPDATE dbo.OWNER SET user_id = (
                                SELECT user_id FROM dbo.USER_ACCOUNT WHERE username = %s
                            ) WHERE owner_id = %s
                        """, [request.user.username, owner_id])

                # 2) ดูว่า pet ชื่อนี้ของ owner นี้มีอยู่หรือยัง
                c.execute("""
                    SELECT pet_id FROM dbo.PET
                    WHERE owner_id = %s AND name = %s AND is_active = 1
                """, [owner_id, pet_name])
                pet_row = c.fetchone()

                if pet_row:
                    pet_id = pet_row[0]
                else:
                    # สร้างสัตว์เลี้ยงใหม่
                    c.execute("""
                        INSERT INTO dbo.PET (owner_id, name, species_id, breed_id, is_active)
                        OUTPUT inserted.pet_id
                        VALUES (%s, %s, %s, %s, 1)
                    """, [owner_id, pet_name, species_id, breed_id])
                    pet_id = int(c.fetchone()[0])

                # 3) ถ้าไม่เลือกหมอ ให้เลือกหมอที่มีภาระน้อยที่สุด
                if not vet_id:
                    c.execute("SELECT TOP 1 vet_id FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY pet_count ASC")
                    vet_row = c.fetchone()
                    vet_id = vet_row[0] if vet_row else 1

                # 4) สร้างข้อมูลบริการเป็น reason ถ้ามี
                booking_reason = reason or ''
                if service_id:
                    c.execute("SELECT service_name FROM dbo.SERVICE WHERE service_id = %s", [service_id])
                    svc_row = c.fetchone()
                    if svc_row:
                        service_label = svc_row[0]
                        booking_reason = f"[{service_label}] {booking_reason}".strip()

                # 5) สร้าง appointment (vet_id อาจเป็น NULL ถ้าไม่ได้เลือกในหน้า Public)
                c.execute("""
                    INSERT INTO dbo.APPOINTMENT (pet_id, vet_id, appt_datetime, reason)
                    VALUES (%s, %s, %s, %s)
                """, [pet_id, vet_id or None, appt_datetime, booking_reason or None])

            return render(request, 'public/booking.html', {
                'active_page': 'booking',
                'success': True,
            })
        except Exception as e:
            # ส่ง error กลับไปพร้อมข้อมูลที่กรอก
            form_data = request.POST.dict()
            return _render_booking_form(request, error=str(e), form_data=form_data)

    # GET — แสดง form เปล่า
    selected_service = request.GET.get('service', '')
    return _render_booking_form(request, owner=owner, selected_service=selected_service)


def _render_booking_form(request, owner=None, error=None, form_data=None, selected_service=''):
    """Helper: โหลดข้อมูล dropdown แล้ว render booking form"""
    with connection.cursor() as c:
        c.execute("SELECT service_id, service_name, price FROM dbo.SERVICE WHERE is_active = 1 ORDER BY service_name")
        services = dictfetchall(c)
        c.execute("SELECT species_id, species_name FROM dbo.SPECIES WHERE is_active = 1 ORDER BY species_name")
        species = dictfetchall(c)
        c.execute("SELECT breed_id, species_id, breed_name FROM dbo.BREED WHERE is_active = 1 ORDER BY breed_name")
        breeds = dictfetchall(c)
        c.execute("SELECT vet_id, first_name, last_name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'public/booking.html', {
        'active_page': 'booking',
        'services': services,
        'species': species,
        'breeds': breeds,
        'vets': vets,
        'owner': owner,
        'error': error,
        'form_data': form_data or {},
        'selected_service': selected_service,
    })
# ===========================================================
#  PUBLIC — รายชื่อแพทย์
# ===========================================================
def public_doctors(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'public/doctors.html', {
        'active_page': 'doctors',
        'vets': vets,
    })


# ===========================================================
#  PUBLIC — รายละเอียดแพทย์
# ===========================================================
def public_doctor_detail(request, vet_id):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VETERINARIAN WHERE vet_id = %s AND is_active = 1", [vet_id])
        vet = dictfetchone(c)

    if not vet:
        return redirect('public_doctors')

    return render(request, 'public/doctor_detail.html', {
        'active_page': 'doctors',
        'vet': vet,
    })


# ===========================================================
#  NEWS — หน้าหลัก (Public)
# ===========================================================
def public_news(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.NEWS ORDER BY created_at DESC")
        news_items = dictfetchall(c)

    return render(request, 'public/news.html', {
        'active_page': 'news',
        'news_items': news_items,
    })


# ===========================================================
#  NEWS — จัดการข่าวสาร (Admin/Vet)
# ===========================================================
@staff_required
def admin_news_list(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.NEWS ORDER BY created_at DESC")
        news_items = dictfetchall(c)

    return render(request, 'admin_news_list.html', {
        'active_page': 'news_management',
        'news_items': news_items,
    })


# ===========================================================
#  NEWS — เพิ่มข่าวสาร (Admin/Vet)
# ===========================================================
@staff_required
def news_add(request):
    if request.method == 'POST':
        try:
            title_th = request.POST['title_th'].strip()
            content_th = request.POST['content_th'].strip()
            category = request.POST.get('category', 'ทั่วไป').strip()
            image_url = request.POST.get('image_url', '').strip() or None
            
            # ดึง User ID ของผู้ที่กำลัง Login
            with connection.cursor() as c:
                c.execute("SELECT user_id FROM dbo.USER_ACCOUNT WHERE username = %s", [request.user.username])
                user_row = c.fetchone()
                user_id = user_row[0] if user_row else None

                c.execute("""
                    INSERT INTO dbo.NEWS (title_th, content_th, category, image_url, user_id, created_at)
                    VALUES (%s, %s, %s, %s, %s, GETDATE())
                """, [title_th, content_th, category, image_url, user_id])

            messages.success(request, 'เพิ่มข่าวสารสำเร็จ!')
            return redirect('admin_news_list')
        except Exception as e:
            messages.error(request, f'เกิดข้อผิดพลาด: {e}')

    return render(request, 'news_form.html', {
        'active_page': 'news_management',
    })


# ===========================================================
#  NEWS — ลบข่าวสาร (Hard Delete)
# ===========================================================
@staff_required
def news_delete(request, news_id):
    try:
        with connection.cursor() as c:
            c.execute("DELETE FROM dbo.NEWS WHERE news_id = %s", [news_id])
        messages.success(request, 'ลบข่าวสารเรียบร้อยแล้ว')
    except Exception as e:
        messages.error(request, f'ไม่สามารถลบข่าวสารได้: {e}')
    
    return redirect('admin_news_list')

