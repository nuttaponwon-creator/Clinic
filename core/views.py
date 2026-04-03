from django.db import connection
from django.shortcuts import render, redirect
from django.contrib import messages
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status


# ===== Helper: แปลง cursor result เป็น list of dict =====
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
#  DASHBOARD
# ===========================================================
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

    return render(request, 'dashboard.html', {
        'active_page': 'dashboard',
        'total_pets': total_pets,
        'total_owners': total_owners,
        'total_vets': total_vets,
        'total_appointments': total_appointments,
        'upcoming_appointments': upcoming_appointments,
        'vaccine_due_soon': vaccine_due_soon,
        'low_stock_medicine': low_stock_medicine,
    })


# ===========================================================
#  PETS — List
# ===========================================================
def pet_list(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VW_PET_FULL ORDER BY pet_id")
        pets = dictfetchall(c)

    return render(request, 'pets.html', {
        'active_page': 'pets',
        'pets': pets,
    })


# ===========================================================
#  PETS — Add
# ===========================================================
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
def owner_list(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.OWNER ORDER BY owner_id")
        owners = dictfetchall(c)

    return render(request, 'owners.html', {
        'active_page': 'owners',
        'owners': owners,
    })


# ===========================================================
#  OWNERS — Add
# ===========================================================
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
def appointment_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("""
                    INSERT INTO dbo.APPOINTMENT (pet_id, vet_id, appt_datetime, reason, notes)
                    VALUES (%s, %s, %s, %s, %s)
                """, [
                    clean_value(request.POST['pet_id'], 'int'),
                    clean_value(request.POST['vet_id'], 'int'),
                    clean_value(request.POST['appt_datetime'], 'datetime'),
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
#  VETS — List (Read-only)
# ===========================================================
def vet_list(request):
    with connection.cursor() as c:
        c.execute("SELECT * FROM dbo.VW_VET_WORKLOAD ORDER BY vet_id")
        vets = dictfetchall(c)

    return render(request, 'vets.html', {
        'active_page': 'vets',
        'vets': vets,
    })


# ===========================================================
#  VACCINES — List + Record
# ===========================================================
def vaccine_list(request):
    with connection.cursor() as c:
        # ข้อมูลวัคซีนทั้งหมด
        c.execute("SELECT * FROM dbo.VACCINE ORDER BY vaccine_id")
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
                vr.vacc_record_id, vr.given_date, vr.next_due_date, vr.batch_no, vr.notes,
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
    })


def vaccine_record_add(request):
    if request.method == 'POST':
        try:
            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")
                c.execute("""
                    INSERT INTO dbo.VACCINATION_RECORD
                        (pet_id, vaccine_id, vet_id, given_date, next_due_date, batch_no, notes, created_at)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, GETDATE())
                """, [
                    clean_value(request.POST['pet_id'], 'int'),
                    clean_value(request.POST['vaccine_id'], 'int'),
                    clean_value(request.POST['vet_id'], 'int'),
                    clean_value(request.POST['given_date'], 'date'),
                    clean_value(request.POST.get('next_due_date'), 'date'),
                    request.POST.get('batch_no') or None,
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
#  PUBLIC — จองคิว (Booking)
# ===========================================================
def public_booking(request):
    if request.method == 'POST':
        try:
            phone = request.POST['phone'].strip()
            first_name = request.POST['first_name'].strip()
            last_name = request.POST['last_name'].strip()
            email = request.POST.get('email', '').strip() or None
            pet_name = request.POST['pet_name'].strip()
            species_id = clean_value(request.POST['species_id'], 'int')
            service_id = clean_value(request.POST.get('service_id'), 'int')
            vet_id = clean_value(request.POST.get('vet_id'), 'int')
            appt_datetime = clean_value(request.POST['appt_datetime'], 'datetime')
            reason = request.POST.get('reason', '').strip() or None

            with connection.cursor() as c:
                c.execute("SET NOCOUNT ON")

                # 1) ดูว่าเจ้าของเบอร์นี้มีในระบบหรือยัง
                c.execute("SELECT owner_id FROM dbo.OWNER WHERE phone = %s", [phone])
                owner_row = c.fetchone()

                if owner_row:
                    owner_id = owner_row[0]
                    # อัปเดตชื่อ (ในกรณีแก้ไข)
                    c.execute("""
                        UPDATE dbo.OWNER SET first_name = %s, last_name = %s,
                        email = COALESCE(%s, email)
                        WHERE owner_id = %s
                    """, [first_name, last_name, email, owner_id])
                else:
                    # สร้างเจ้าของใหม่
                    c.execute("""
                        INSERT INTO dbo.OWNER (first_name, last_name, phone, email)
                        VALUES (%s, %s, %s, %s)
                    """, [first_name, last_name, phone, email])
                    c.execute("SELECT SCOPE_IDENTITY()")
                    owner_id = c.fetchone()[0]

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
                        INSERT INTO dbo.PET (owner_id, name, species_id, is_active)
                        VALUES (%s, %s, %s, 1)
                    """, [owner_id, pet_name, species_id])
                    c.execute("SELECT SCOPE_IDENTITY()")
                    pet_id = c.fetchone()[0]

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

                # 5) สร้าง appointment
                c.execute("""
                    INSERT INTO dbo.APPOINTMENT (pet_id, vet_id, appt_datetime, reason)
                    VALUES (%s, %s, %s, %s)
                """, [pet_id, vet_id, appt_datetime, booking_reason or None])

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
    return _render_booking_form(request, selected_service=selected_service)


def _render_booking_form(request, error=None, form_data=None, selected_service=''):
    """Helper: โหลดข้อมูล dropdown แล้ว render booking form"""
    with connection.cursor() as c:
        c.execute("SELECT service_id, service_name, price FROM dbo.SERVICE WHERE is_active = 1 ORDER BY service_name")
        services = dictfetchall(c)
        c.execute("SELECT species_id, species_name FROM dbo.SPECIES WHERE is_active = 1 ORDER BY species_name")
        species = dictfetchall(c)
        c.execute("SELECT vet_id, first_name, last_name, specialization FROM dbo.VETERINARIAN WHERE is_active = 1 ORDER BY first_name")
        vets = dictfetchall(c)

    return render(request, 'public/booking.html', {
        'active_page': 'booking',
        'services': services,
        'species': species,
        'vets': vets,
        'error': error,
        'form_data': form_data or {},
        'selected_service': selected_service,
    })
