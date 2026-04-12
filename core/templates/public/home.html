{% extends "public/base_public.html" %}
{% load static i18n %}

{% block title %}{% trans "หน้าแรก" %}{% endblock %}

{% block content %}

<!-- ===== Hero Section ===== -->
<style>
  @keyframes floatMascot {
    0% {
      transform: translateY(0px);
    }

    50% {
      transform: translateY(-20px);
    }

    100% {
      transform: translateY(0px);
    }
  }

  .hero-layout {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 40px;
    text-align: left;
  }

  .hero-text-side {
    max-width: 600px;
  }

  .hero-actions {
    justify-content: flex-start;
  }

  .mascot-img {
    max-width: 450px;
    width: 100%;
    animation: floatMascot 4s ease-in-out infinite;
    filter: drop-shadow(0 20px 40px rgba(126, 196, 196, 0.4));
    border-radius: 20px;
  }

  @media (max-width: 900px) {
    .hero-layout {
      flex-direction: column;
      text-align: center;
      padding-top: 140px;
    }

    .hero-text-side {
      margin: 0 auto;
    }

    .hero-actions {
      justify-content: center;
    }

    .mascot-img {
      max-width: 300px;
      margin-top: 40px;
    }
  }
</style>

<section class="hero">
  <div class="hero-overlay"></div>
  <div class="container hero-content hero-layout">
    <div class="hero-text-side">
      <div class="hero-badge">🐾 {% trans "ยินดีต้อนรับสู่ น้องนาวี่ สัตวแพทย์" %}</div>
      <h1 class="hero-title">{% blocktrans trimmed %}ดูแลสัตว์เลี้ยง<br>ด้วย<span class="text-gradient">ความรักและมาตรฐาน</span>{% endblocktrans %}</h1>
      <p class="hero-subtitle">{% trans 'ให้แอดมิน "น้องนาวี่" และทีมสัตวแพทย์ของเรา ดูแลสุขภาพสัตว์เลี้ยงของคุณอย่างใกล้ชิด บริการครบวงจร ตรวจรักษา วัคซีน และผ่าตัด' %}</p>
      <div class="hero-actions">
        <a href="{% url 'public_booking' %}" class="btn-hero btn-hero-primary">
          <i class="fas fa-calendar-plus"></i> {% trans "จองคิวนัดหมาย" %}
        </a>
        <a href="{% url 'public_services' %}" class="btn-hero btn-hero-outline">
          <i class="fas fa-stethoscope"></i> {% trans "ดูบริการทั้งหมด" %}
        </a>
      </div>
    </div>

    <div class="hero-mascot-side">
      <img src="{% static 'images/NongNaviDog.png' %}" alt="น้องนาวี่ มาสคอตประจำคลินิก" class="mascot-img">
    </div>
  </div>
</section>

<!-- ===== Why Choose Us ===== -->
<section class="section section-features">
  <div class="container">
    <div class="section-header">
      <h2>{% trans "ทำไมต้องเลือก" %}<span class="text-gradient"> {% trans "น้องนาวี่ สัตวแพทย์" %}</span></h2>
      <p>{% trans "เราพร้อมดูแลสัตว์เลี้ยงของคุณอย่างดีที่สุด" %}</p>
    </div>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon" style="background: rgba(108,92,231,0.1); color: #6C5CE7;">
          <i class="fas fa-user-md"></i>
        </div>
        <h3>{% trans "ทีมสัตวแพทย์ผู้เชี่ยวชาญ" %}</h3>
        <p>{% trans "สัตวแพทย์ที่มีใบอนุญาตและประสบการณ์ พร้อมให้คำปรึกษาและรักษาอย่างมืออาชีพ" %}</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon" style="background: rgba(0,206,201,0.1); color: #00CEC9;">
          <i class="fas fa-heartbeat"></i>
        </div>
        <h3>{% trans "อุปกรณ์ทันสมัย" %}</h3>
        <p>{% trans "เครื่องมือและอุปกรณ์การแพทย์ที่ทันสมัย ได้มาตรฐาน เพื่อการวินิจฉัยที่แม่นยำ" %}</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon" style="background: rgba(253,121,168,0.1); color: #FD79A8;">
          <i class="fas fa-hand-holding-heart"></i>
        </div>
        <h3>{% trans "ดูแลด้วยความรัก" %}</h3>
        <p>{% trans "เราเข้าใจว่าสัตว์เลี้ยงคือสมาชิกในครอบครัว จึงดูแลอย่างอ่อนโยนเหมือนลูกของเราเอง" %}</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon" style="background: rgba(0,184,148,0.1); color: #00B894;">
          <i class="fas fa-clock"></i>
        </div>
        <h3>{% trans "เปิดบริการทุกวัน" %}</h3>
        <p>{% trans "เปิดให้บริการทุกวัน จันทร์-เสาร์ 09:00-20:00 น. และอาทิตย์ 10:00-17:00 น." %}</p>
      </div>
    </div>
  </div>
</section>

<!-- ===== Services Preview ===== -->
<section class="section section-services-preview">
  <div class="container">
    <div class="section-header">
      <h2>{% trans "บริการของเรา" %}</h2>
      <p>{% trans "บริการดูแลสุขภาพสัตว์เลี้ยงครบวงจร" %}</p>
    </div>
    <div class="services-grid">
      {% for svc in services %}
      <div class="service-card-home">
        <div class="service-card-icon">
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
          {% else %}
          <i class="fas fa-paw"></i>
          {% endif %}
        </div>
        <h3>{{ svc.service_name }}</h3>
        <p>
          {% if svc.description %}
            {{ svc.description }}
          {% else %}
            {% trans "บริการดูแลสัตว์เลี้ยงของคุณ" %}
          {% endif %}
        </p>
        <div class="service-price">฿{{ svc.price|floatformat:0 }}</div>
      </div>
      {% endfor %}
    </div>
    <div style="text-align: center; margin-top: 32px;">
      <a href="{% url 'public_services' %}" class="btn-hero btn-hero-primary">
        <i class="fas fa-arrow-right"></i> {% trans "ดูบริการทั้งหมด" %}
      </a>
    </div>
  </div>
</section>

<!-- ===== CTA Section ===== -->
<section class="section section-cta">
  <div class="container">
    <div class="cta-box">
      <h2>{% trans "พร้อมให้เราดูแลสัตว์เลี้ยงของคุณ?" %}</h2>
      <p>{% trans "จองคิวนัดหมายออนไลน์ได้ง่ายๆ เลือกวัน เวลา และบริการที่ต้องการ" %}</p>
      <a href="{% url 'public_booking' %}" class="btn-hero btn-hero-white">
        <i class="fas fa-calendar-check"></i> {% trans "จองคิวเลย" %}
      </a>
    </div>
  </div>
</section>

{% endblock %}