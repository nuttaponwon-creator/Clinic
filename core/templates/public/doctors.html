{% extends 'public/base_public.html' %}
{% load static i18n %}

{% block title %}{% trans "ทีมสัตวแพทย์" %} — NongNavi Clinic{% endblock %}

{% block content %}
<section class="page-hero">
    <div class="container">
        <div class="hero-badge">OUR DOCTORS</div>
        <h1>{% trans "ทีมสัตวแพทย์ผู้เชี่ยวชาญ" %}</h1>
        <p>{% trans "ดูแลสัตว์เลี้ยงแสนรักของคุณด้วยความใส่ใจและมาตรฐานการรักษาที่วางใจได้" %}</p>
    </div>
</section>

<section class="section section-doctors">
    <div class="container">
        <div class="doctors-grid">
            {% for vet in vets %}
            <div class="doctor-card">
                <div class="doctor-header">
                    <div class="doctor-img-wrapper">
                        {% if vet.profile_image %}
                        <img src="{{ vet.profile_image }}" alt="{{ vet.first_name }}" class="doctor-img">
                        {% else %}
                        <img src="https://ui-avatars.com/api/?name={{ vet.first_name }}+{{ vet.last_name }}&background=E0F7FA&color=00838F&size=128" alt="{{ vet.first_name }}" class="doctor-img">
                        {% endif %}
                    </div>
                </div>
                <div class="doctor-info">
                    <h3 class="doctor-name">{% trans "สพ.ญ." %} {{ vet.first_name }} {{ vet.last_name }}</h3>
                    <p class="doctor-name-en">Dr. {{ vet.first_name }} {{ vet.last_name }}</p>
                    <p class="doctor-specialization">{{ vet.specialization }}</p>
                </div>
                <div class="doctor-footer">
                    <a href="{% url 'public_booking' %}?vet={{ vet.vet_id }}" class="btn-doctor btn-book-vet">
                        <i class="fas fa-calendar-alt"></i> {% trans "ทำนัด" %}
                    </a>
                    <a href="{% url 'public_doctor_detail' vet.vet_id %}" class="btn-doctor btn-detail-vet">
                        <i class="fas fa-search"></i> {% trans "รายละเอียด" %}
                    </a>
                </div>
            </div>
            {% empty %}
            <div style="text-align: center; grid-column: 1/-1; padding: 40px;">
                <p>{% trans "ขออภัย ขณะนี้ยังไม่มีข้อมูลแพทย์ในระบบ" %}</p>
            </div>
            {% endfor %}
        </div>
    </div>
</section>

<section class="section-cta">
    <div class="container">
        <div class="cta-box">
            <h2>{% trans "พร้อมนัดหมายกับคุณหมอที่เชี่ยวชาญ?" %}</h2>
            <p>{% trans "จองคิวออนไลน์ได้ง่ายๆ ตลอด 24 ชั่วโมง" %}</p>
            <a href="{% url 'public_booking' %}" class="btn-hero btn-hero-white">
                <i class="fas fa-calendar-plus"></i> {% trans "จองคิวนัดหมายทันที" %}
            </a>
        </div>
    </div>
</section>
{% endblock %}
