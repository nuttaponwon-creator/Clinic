from django.urls import path
from . import views

urlpatterns = [
    # ========================================
    #  PUBLIC — หน้าลูกค้า
    # ========================================
    path('', views.public_home, name='home'),
    path('services/', views.public_services, name='public_services'),
    path('doctors/', views.public_doctors, name='public_doctors'),
    path('doctors/<int:vet_id>/', views.public_doctor_detail, name='public_doctor_detail'),
    path('booking/', views.public_booking, name='public_booking'),
    path('my-page/', views.my_page, name='my_page'),

    # ========================================
    #  AUTH — เข้าสู่ระบบ / สมัครสมาชิก
    # ========================================
    path('login/', views.user_login, name='login'),
    path('register/', views.user_register, name='register'),
    path('logout/', views.user_logout, name='logout'),

    # ========================================
    #  ADMIN — หน้าจัดการ (สำหรับพนักงาน)
    # ========================================
    path('admin-panel/', views.dashboard, name='dashboard'),

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
    path('admin-panel/appointments/history/', views.appointment_history, name='appointment_history'),
    path('admin-panel/appointments/add/', views.appointment_add, name='appointment_add'),

    # สัตวแพทย์
    path('admin-panel/vets/', views.vet_list, name='vet_list'),
    path('admin-panel/vets/add/', views.vet_add, name='vet_add'),
    path('admin-panel/vets/<int:vet_id>/edit/', views.vet_edit, name='vet_edit'),

    # วัคซีน
    path('admin-panel/vaccines/', views.vaccine_list, name='vaccine_list'),
    path('admin-panel/vaccines/add/', views.vaccine_add, name='vaccine_add'),
    path('admin-panel/vaccines/restock/', views.vaccine_restock, name='vaccine_restock'),
    path('admin-panel/vaccines/record/add/', views.vaccine_record_add, name='vaccine_record_add'),

    # ยา / เวชภัณฑ์
    path('admin-panel/medicines/', views.medicine_list, name='medicine_list'),
    path('admin-panel/medicines/add/', views.medicine_add, name='medicine_add'),
    path('admin-panel/medicines/restock/', views.medicine_restock, name='medicine_restock'),

    # อัปเดตสถานะและบันทึกนัดหมาย (admin + vet)
    path('admin-panel/appointments/<int:appt_id>/update-status/', views.appointment_update_status, name='appointment_update_status'),
    path('admin-panel/appointments/<int:appt_id>/update-notes/', views.appointment_update_notes, name='appointment_update_notes'),

    # บันทึกการรักษา
    path('admin-panel/appointments/<int:appt_id>/record-treatment/', views.record_treatment, name='record_treatment'),

    # การจัดการสถานะ Active/Inactive
    path('admin-panel/toggle-status/<str:entity>/<int:item_id>/', views.toggle_active_status, name='toggle_active_status'),

    # ข่าวสารและกิจกรรม
    path('news/', views.public_news, name='public_news'),
    path('admin-panel/news/', views.admin_news_list, name='admin_news_list'),
    path('admin-panel/news/add/', views.news_add, name='news_add'),
    path('admin-panel/news/<int:news_id>/delete/', views.news_delete, name='news_delete'),

    # === API ===
    path('api/pets/', views.api_get_all_pets, name='api_pets'),
]
