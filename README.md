# 🏥 NongNavi Veterinary Clinic

<table>
<tr>
<td width="160"><img src="core/static/images/Nongnavi-removebg-preview.png" width="140"></td>
<td>
<h3>ระบบจัดการคลินิกสัตว์เลี้ยง NongNavi (น้องนาวี่) สัตวแพทย์</h3>
<p>พัฒนาด้วย <strong>Django Framework</strong> + <strong>Microsoft SQL Server</strong></p>
<p>ระบบจัดการคลินิกครบวงจร ตั้งแต่การนัดหมาย สัตว์เลี้ยง สต็อกวัคซีน/ยา ไปจนถึงข่าวสารและโปรโมชัน</p>
</td>
</tr>
</table>

---

## 📋สารบัญ

- [เกี่ยวกับโปรเจกต์](#about)
- [เทคโนโลยีที่ใช้](#tech)
- [การติดตั้ง](#install)
- [การตั้งค่า](#setup)
- [บัญชีผู้ใช้สำหรับทดสอบ](#accounts)
- [การใช้งาน](#usage)
- [หน้าเว็บไซต์](#pages)
- [โครงสร้างโปรเจกต์](#structure)
- [การสำรองและนำเข้าฐานข้อมูล](#backup)

---

<a name="about"></a>
## 📖เกี่ยวกับโปรเจกต์

ระบบจัดการคลินิกสัตว์เลี้ยง **NongNavi** เป็นเว็บแอปพลิเคชันที่ออกแบบมาเพื่อช่วยจัดการงานภายในคลินิกสัตวแพทย์ ทั้งฝั่ง **ลูกค้า (Public)** และ **ผู้ดูแลระบบ (Admin Panel)** ครอบคลุมตั้งแต่การนัดหมาย, จัดการสัตว์เลี้ยง, บันทึกการรักษา, ไปจนถึงการจัดการสต็อกวัคซีนและยา

### ✨ ฟีเจอร์หลัก

**ฝั่งลูกค้า (Public)**
- 🏠 หน้าแรกแสดงข้อมูลคลินิก บริการ และทีมสัตวแพทย์
- 📋 จองคิวนัดหมายออนไลน์
- 👨‍⚕️ ดูข้อมูลสัตวแพทย์ประจำคลินิก
- 💊 ดูรายการบริการและราคา (พร้อม Filter หมวดหมู่)
- 📰 ข่าวสารและกิจกรรม (พร้อม Filter หมวดหมู่ + รูปภาพ)
- 📄 หน้า My Page — ตรวจสอบนัดหมายและสัตว์เลี้ยงของตนเอง

**ฝั่ง Admin Panel**
- 📊 Dashboard แสดงสถิติรวม (สัตว์เลี้ยง, เจ้าของ, นัดหมาย, สัตวแพทย์)
- 🐾 จัดการข้อมูลสัตว์เลี้ยง (เพิ่ม/แก้ไข)
- 👥 จัดการข้อมูลเจ้าของสัตว์เลี้ยง
- 📅 จัดการนัดหมาย + บันทึกการรักษา
- 💉 จัดการวัคซีน (เพิ่ม/เติมสต็อก/บันทึกการฉีด)
- 💊 จัดการยาและเวชภัณฑ์
- 👨‍⚕️ จัดการข้อมูลสัตวแพทย์
- 📰 จัดการข่าวสารและกิจกรรม
- 🔒 ระบบสิทธิ์ผู้ใช้ (Admin / Vet / Owner)

---

<a name="tech"></a>
## 🛠เทคโนโลยีที่ใช้

| เทคโนโลยี | รายละเอียด |
|---|---|
| **Backend** | Python 3.9 + Django 4.2 |
| **Database** | Microsoft SQL Server (via `mssql-django`) |
| **Frontend** | HTML5, CSS3 (Vanilla CSS), JavaScript |
| **Icons** | Font Awesome 6 |
| **Fonts** | Google Fonts (Inter, Noto Sans Thai) |
| **Authentication** | Custom Backend + Django Auth |
| **Deployment** | Render (Production) / Local (Development) |

---

<a name="install"></a>
## 🚀การติดตั้ง

### ข้อกำหนดเบื้องต้น (Prerequisites)

1. **Python 3.9+** — [ดาวน์โหลด](https://www.python.org/downloads/)
2. **SQL Server** (Express หรือ Developer) — [ดาวน์โหลด](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
3. **ODBC Driver 17** for SQL Server — [ดาวน์โหลด](https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server)
4. **Git** — [ดาวน์โหลด](https://git-scm.com/)

### ขั้นตอนการติดตั้ง

```bash
# 1. Clone โปรเจกต์
git clone https://github.com/nuttaponwon-creator/Clinic.git
cd Clinic

# 2. สร้าง Virtual Environment (แนะนำ)
python -m venv venv
venv\Scripts\activate    # Windows
# source venv/bin/activate  # macOS/Linux

# 3. ติดตั้ง Dependencies
pip install -r requirements.txt
```

---

<a name="setup"></a>
## ⚙️การตั้งค่า

### 1. ตั้งค่าฐานข้อมูล (Database)

เปิดไฟล์ `myclinic/settings.py` แล้วแก้ไขส่วนเชื่อมต่อฐานข้อมูล:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mssql',
        'NAME': 'PetClinicDB',                    # ชื่อฐานข้อมูล
        'HOST': 'YOUR_SERVER\\SQLEXPRESS',         # ชื่อ SQL Server ของคุณ
        'USER': 'sa',                              # Username
        'PASSWORD': 'your_password',               # Password
        'OPTIONS': {
            'driver': 'ODBC Driver 17 for SQL Server',
            'extra_params': 'TrustServerCertificate=yes;',
        },
    }
}
```

### 2. สร้างฐานข้อมูล

ทำตามขั้นตอนด้านล่างเพื่อเตรียมฐานข้อมูลให้พร้อมใช้งาน:

1. สร้างฐานข้อมูลชื่อ `PetClinicDB` ใน SQL Server
2. เปิดไฟล์ [**`database_setup.sql`**](database_setup.sql) ในโปรเจกต์นี้ด้วย SSMS
3. กด **Execute** (หรือปุ่ม F5) เพื่อสร้างตารางและนำเข้าข้อมูลเริ่มต้นทั้งหมดทันที

---
### 3. รันเซิร์ฟเวอร์

```bash
python manage.py runserver
```

เข้าเว็บไซต์ที่: **http://127.0.0.1:8000/**

---

<a name="accounts"></a>
## 🔑บัญชีผู้ใช้สำหรับทดสอบ

สำหรับการเข้าทดสอบระบบ คุณสามารถใช้บัญชีที่เตรียมไว้ให้ดังนี้:

| บทบาท (Role) | Username | Password |
|---|---|---|
| **Admin** | `admin` | `12555879ad` |
| **Vet (สัตวแพทย์)** | `vet1` - `vet4` | `changeme123` |
| **Owner (เจ้าของ)** | *เบอร์โทรศัพท์ลูกค้า* | *เบอร์โทรศัพท์ลูกค้า* |

---

<a name="usage"></a>
## 📱การใช้งาน

### สำหรับลูกค้า (Public)
1. เข้าที่ `http://127.0.0.1:8000/` เพื่อดูหน้าแรกของคลินิก
2. สมัครสมาชิก / เข้าสู่ระบบ ที่หน้า Login
3. จองคิวนัดหมายออนไลน์ผ่านหน้า "จองคิว"
4. ตรวจสอบสถานะนัดหมายและสัตว์เลี้ยงของตัวเองที่หน้า "My Page"

### สำหรับผู้ดูแลระบบ (Admin)
> [!IMPORTANT]
> กรุณาเข้าสู่ระบบด้วยบัญชี **Admin** หรือ **Vet** ก่อนเข้าใช้งานหน้าจัดการ

1. เข้าสู่ระบบที่หน้า [Login](http://127.0.0.1:8000/login/)
2. เมื่อเข้าระบบสำเร็จ คุณจะถูกเปลี่ยนหน้าไปยัง **Dashboard** (`/admin-panel/`) โดยอัตโนมัติ
3. สามารถจัดการข้อมูลต่างๆ เช่น สัตว์เลี้ยง, นัดหมาย, และสต็อกยา ผ่านเมนู Sidebar ด้านซ้าย

### ระดับสิทธิ์ผู้ใช้

| สิทธิ์ | คำอธิบาย |
|---|---|
| **Admin** | เข้าถึงได้ทุกฟีเจอร์ รวมถึงการจัดการสต็อกวัคซีน/ยา |
| **Vet (สัตวแพทย์)** | เข้าถึง Dashboard, จัดการนัดหมาย, บันทึกการรักษา (ไม่สามารถเติมสต็อกได้) |
| **Owner (เจ้าของ)** | ดูข้อมูลฝั่ง Public, จองคิวนัดหมาย, ตรวจสอบประวัติสัตว์เลี้ยงตนเอง |

---

<a name="pages"></a>
## 🖥หน้าเว็บไซต์

### ฝั่งลูกค้า (Public Pages)

#### 🏠 หน้าแรก (Homepage)
> แสดงข้อมูลคลินิก, บริการ, และทีมสัตวแพทย์

![Homepage](core/static/images/screenshots/homepage.png)

#### 💊 บริการของเรา (Services)
> รายการบริการพร้อมราคา + Filter หมวดหมู่

![Services](core/static/images/screenshots/services.png)

#### 📰 ข่าวสารและกิจกรรม (News)
> ข่าวสาร โปรโมชัน สาระน่ารู้ + รูปภาพ

![News](core/static/images/screenshots/news.png)

#### 🔐 เข้าสู่ระบบ (Login)
> หน้า Login สำหรับทุก Role

![Login](core/static/images/screenshots/login.png)

---

### ฝั่งผู้ดูแลระบบ (Admin Panel)

#### 📊 Dashboard
> ภาพรวมสถิติ นาฬิกา Live และ Shortcut ต่างๆ

![Dashboard](core/static/images/screenshots/admin_dashboard.png)

#### 🐾 จัดการสัตว์เลี้ยง (Pets)
> เพิ่ม แก้ไข ค้นหาข้อมูลสัตว์เลี้ยง

![Pets](core/static/images/screenshots/admin_pets.png)

#### 📅 จัดการนัดหมาย (Appointments)
> ดูตาราง อัปเดตสถานะ บันทึกการรักษา

![Appointments](core/static/images/screenshots/admin_appointments.png)

#### 📰 จัดการข่าวสาร (News Management)
> เพิ่ม ลบข่าวสาร โปรโมชัน กิจกรรม

![News Management](core/static/images/screenshots/admin_news.png)

---

<a name="structure"></a>
## 📁โครงสร้างโปรเจกต์

```
myclinic/
├── core/                          # Django App หลัก
│   ├── static/
│   │   ├── css/
│   │   │   ├── style.css          # CSS สำหรับ Admin Panel
│   │   │   └── public.css         # CSS สำหรับหน้า Public
│   │   └── images/                # โลโก้และรูปภาพ
│   ├── templates/
│   │   ├── public/                # Templates หน้าลูกค้า
│   │   │   ├── base_public.html
│   │   │   ├── home.html
│   │   │   ├── services.html
│   │   │   ├── doctors.html
│   │   │   ├── news.html
│   │   │   ├── booking.html
│   │   │   └── my_page.html
│   │   ├── auth/                  # Templates Login/Register
│   │   ├── base.html              # Base template (Admin)
│   │   ├── dashboard.html
│   │   ├── pets.html
│   │   ├── owners.html
│   │   ├── appointments.html
│   │   ├── vaccines.html
│   │   ├── medicines.html
│   │   └── ...
│   ├── backends.py                # Custom Authentication Backend
│   ├── context_processors.py      # User Role Context
│   ├── urls.py                    # URL Routing
│   └── views.py                   # View Functions (All Logic)
├── myclinic/                      # Django Project Config
│   ├── settings.py                # ⚙️ การตั้งค่าหลัก (DB, Auth, etc.)
│   └── urls.py
├── locale/                        # ไฟล์แปลภาษา (TH/EN)
├── manage.py
├── requirements.txt
├── .gitignore
└── README.md
```

---

<a name="backup"></a>
## 💾การสำรองและนำเข้าฐานข้อมูล

เนื่องจากระบบใช้ **SQL Server** วิธีที่ง่ายที่สุดในการแชร์ฐานข้อมูลคือการใช้ **SQL Script (.sql)** ครับ

### วิธีการสำรองข้อมูล (Export Script)
1. เปิด **SQL Server Management Studio (SSMS)**
2. คลิกขวาที่ฐานข้อมูล `PetClinicDB` > **Tasks** > **Generate Scripts...**
3. เลือก **Select specific database objects** และติ๊กทุกตาราง
4. ที่หน้า **Set Scripting Options** ให้คลิกปุ่ม **Advanced**
5. หาหัวข้อ **Types of data to script** และเปลี่ยนจาก `Schema only` เป็น **`Schema and data`** (เพื่อให้ได้ทั้งโครงสร้างและข้อมูล)
6. บันทึกไฟล์เป็น `database_setup.sql`

### วิธีการนำเข้าข้อมูล (Import Script)
1. สร้างฐานข้อมูลใหม่ชื่อ `PetClinicDB` ใน SQL Server
2. เปิดไฟล์ `database_setup.sql` ใน SSMS
3. รันสคริปต์ (Execute) เพื่อสร้างตารางและข้อมูลทั้งหมดเข้าสู่ฐานข้อมูลใหม่

---

## 👨‍💻 ผู้พัฒนา

พัฒนาโดย **ทีมพัฒนา NongNavi Clinic**

---

## 📝 License

This project is for educational purposes.
