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
                    request.POST['owner_id'],
                    request.POST['name'],
                    request.POST['species_id'],
                    request.POST.get('breed_id') or None,
                    request.POST.get('date_of_birth') or None,
                    request.POST.get('gender', 'U'),
                    request.POST.get('weight_kg') or None,
                    request.POST.get('is_neutered', '0'),
                    request.POST.get('primary_vet_id') or None,
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
                    request.POST['owner_id'],
                    request.POST['name'],
                    request.POST['species_id'],
                    request.POST.get('breed_id') or None,
                    request.POST.get('date_of_birth') or None,
                    request.POST.get('gender', 'U'),
                    request.POST.get('weight_kg') or None,
                    request.POST.get('is_neutered', '0'),
                    request.POST.get('primary_vet_id') or None,
                    request.POST.get('is_active', '1'),
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
                    request.POST['pet_id'],
                    request.POST['vet_id'],
                    request.POST['appt_datetime'],
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
