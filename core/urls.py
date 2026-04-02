from django.urls import path
from . import views

urlpatterns = [
    # === หน้าเว็บ ===
    path('', views.dashboard, name='dashboard'),

    # สัตว์เลี้ยง
    path('pets/', views.pet_list, name='pet_list'),
    path('pets/add/', views.pet_add, name='pet_add'),
    path('pets/<int:pet_id>/edit/', views.pet_edit, name='pet_edit'),

    # เจ้าของ
    path('owners/', views.owner_list, name='owner_list'),
    path('owners/add/', views.owner_add, name='owner_add'),
    path('owners/<int:owner_id>/edit/', views.owner_edit, name='owner_edit'),

    # นัดหมาย
    path('appointments/', views.appointment_list, name='appointment_list'),
    path('appointments/add/', views.appointment_add, name='appointment_add'),

    # สัตวแพทย์
    path('vets/', views.vet_list, name='vet_list'),

    # === API ===
    path('api/pets/', views.api_get_all_pets, name='api_pets'),
]
