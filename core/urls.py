from django.urls import path
from . import views

urlpatterns = [
    # ========================================
    #  PUBLIC — หน้าลูกค้า
    # ========================================
    path('public/', views.public_home, name='home'),
    path('services/', views.public_services, name='public_services'),
    path('booking/', views.public_booking, name='public_booking'),

    # ========================================
    #  ADMIN — หน้าจัดการ (สำหรับพนักงาน)
    # ========================================
    path('', views.dashboard, name='dashboard'),
    path('admin-panel/', views.dashboard, name='legacy_dashboard'), # เก็บไว้เผื่อมีลิงก์เก่าค้างอยู่

    # สัตว์เลี้ยง
    path('admin-panel/pets/', views.pet_list, name='pet_list'),
    path('admin-panel/pets/add/', views.pet_add, name='pet_add'),
    path('admin-panel/pets/<int:pet_id>/edit/', views.pet_edit, name='pet_edit'),

    # เจ้าของ
    path('admin-panel/owners/', views.owner_list, name='owner_list'),
    path('admin-panel/owners/add/', views.owner_add, name='owner_add'),
    path('admin-panel/owners/<int:owner_id>/edit/', views.owner_edit, name='owner_edit'),

    # นัดหมาย
    path('admin-panel/appointments/', views.appointment_list, name='appointment_list'),
    path('admin-panel/appointments/add/', views.appointment_add, name='appointment_add'),

    # สัตวแพทย์
    path('admin-panel/vets/', views.vet_list, name='vet_list'),

    # วัคซีน
    path('admin-panel/vaccines/', views.vaccine_list, name='vaccine_list'),
    path('admin-panel/vaccines/add/', views.vaccine_add, name='vaccine_add'),
    path('admin-panel/vaccines/restock/', views.vaccine_restock, name='vaccine_restock'),
    path('admin-panel/vaccines/record/add/', views.vaccine_record_add, name='vaccine_record_add'),

    # === API ===
    path('api/pets/', views.api_get_all_pets, name='api_pets'),
]
