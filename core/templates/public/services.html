{% extends "public/base_public.html" %}
{% load static i18n %}

{% block title %}{% trans "บริการของเรา" %}{% endblock %}

{% block content %}

<!-- ===== Page Header ===== -->
<section class="page-hero" style="background: linear-gradient(135deg, var(--bg-light) 0%, var(--white) 100%);">
  <div class="container">
    <h1 class="text-gradient">{% trans "แพ็กเกจและโปรโมชัน" %}</h1>
    <p>{% trans "บริการดูแลสุขภาพสัตว์เลี้ยงครบวงจร ด้วยทีมสัตวแพทย์มืออาชีพ" %}</p>
  </div>
</section>

<!-- ===== Category Filter ===== -->
<div class="container">
    <div class="filter-bar-wrapper">
        <button class="filter-btn active" data-filter="all">
            <i class="fas fa-th-large"></i> ทั้งหมด
        </button>
        <button class="filter-btn" data-filter="checkup">
            <i class="fas fa-stethoscope"></i> ตรวจสุขภาพ
        </button>
        <button class="filter-btn" data-filter="vaccine">
            <i class="fas fa-syringe"></i> วัคซีน
        </button>
        <button class="filter-btn" data-filter="surgery">
            <i class="fas fa-procedures"></i> ผ่าตัด
        </button>
        <button class="filter-btn" data-filter="other">
            <i class="fas fa-paw"></i> อื่นๆ
        </button>
    </div>
</div>

<!-- ===== Services List ===== -->
<section class="section" style="padding-top: 20px;">
  <div class="container">
    <div class="premium-news-grid" id="servicesGrid">
      {% for svc in services %}
      <div class="premium-service-card service-item" 
           data-category="{% if 'ตรวจ' in svc.service_name %}checkup{% elif 'วัคซีน' in svc.service_name or 'ฉีด' in svc.service_name %}vaccine{% elif 'ผ่าตัด' in svc.service_name or 'ทำหมัน' in svc.service_name %}surgery{% else %}other{% endif %}">
        
        <div class="svc-icon-box">
            {% if 'ตรวจ' in svc.service_name %}
              <i class="fas fa-stethoscope"></i>
            {% elif 'วัคซีน' in svc.service_name or 'ฉีด' in svc.service_name %}
              <i class="fas fa-syringe"></i>
            {% elif 'ผ่าตัด' in svc.service_name or 'ทำหมัน' in svc.service_name %}
              <i class="fas fa-procedures"></i>
            {% elif 'อาบน้ำ' in svc.service_name or 'กรูม' in svc.service_name %}
              <i class="fas fa-shower"></i>
            {% elif 'ฟัน' in svc.service_name %}
              <i class="fas fa-tooth"></i>
            {% elif 'เอก' in svc.service_name or 'X-ray' in svc.service_name %}
              <i class="fas fa-x-ray"></i>
            {% elif 'lab' in svc.service_name|lower or 'เลือด' in svc.service_name %}
              <i class="fas fa-vial"></i>
            {% else %}
              <i class="fas fa-paw"></i>
            {% endif %}
        </div>
        
        <div class="svc-content" style="flex-grow: 1;">
          <h3 class="svc-title">{{ svc.service_name }}</h3>
          <p class="svc-desc">{{ svc.description|default:"บริการดูแลสัตว์เลี้ยงด้วยมาตรฐานการแพทย์ระดับสากล" }}</p>
        </div>

        <div class="svc-footer">
          <div class="svc-price-tag">
            <small>฿</small>{{ svc.price|floatformat:0 }}
          </div>
          <a href="{% url 'public_booking' %}?service={{ svc.service_id }}" class="btn-book-premium">
            <i class="fas fa-calendar-plus"></i> {% trans "จองคิวนัดหมาย" %}
          </a>
        </div>
      </div>
      {% empty %}
      <div style="text-align: center; padding: 60px; grid-column: 1/-1; color: #999;">
        <i class="fas fa-tools" style="font-size: 48px; margin-bottom: 16px;"></i>
        <p>{% trans "กำลังอัปเดตข้อมูลบริการ กรุณาติดต่อคลินิกโดยตรง" %}</p>
      </div>
      {% endfor %}
    </div>
  </div>
</section>

<!-- JS for Filtering -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const filterBtns = document.querySelectorAll('.filter-btn');
    const serviceItems = document.querySelectorAll('.service-item');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Update Active State
            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const filterValue = btn.getAttribute('data-filter');

            serviceItems.forEach(item => {
                if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                    item.style.display = 'flex';
                    item.style.opacity = '0';
                    setTimeout(() => {
                        item.style.transition = 'opacity 0.4s ease';
                        item.style.opacity = '1';
                    }, 10);
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });
});
</script>

{% endblock %}
