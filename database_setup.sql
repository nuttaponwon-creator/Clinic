-- 🏥 NongNavi Clinic Database Setup Script
-- Generated for project distribution

USE PetClinicDB;
GO

-- ==========================================
-- Table: VW_PET_MEDICAL_HISTORY
-- ==========================================

IF OBJECT_ID('dbo.VW_PET_MEDICAL_HISTORY', 'U') IS NOT NULL DROP TABLE dbo.VW_PET_MEDICAL_HISTORY;
CREATE TABLE dbo.VW_PET_MEDICAL_HISTORY (
    [pet_id] INT NOT NULL,
    [pet_name] NVARCHAR(50) NOT NULL,
    [species] NVARCHAR(50) NOT NULL,
    [owner_name] NVARCHAR(101) NOT NULL,
    [owner_phone] VARCHAR(20) NOT NULL,
    [record_id] INT NOT NULL,
    [visit_date] DATE NOT NULL,
    [chief_complaint] NVARCHAR(255),
    [diagnosis] NVARCHAR(MAX),
    [treatment] NVARCHAR(MAX),
    [weight_at_visit] DECIMAL,
    [follow_up_date] DATE,
    [vet_id] INT NOT NULL,
    [vet_name] NVARCHAR(101) NOT NULL,
    [record_type] NVARCHAR(6) NOT NULL,
    [item_name] NVARCHAR(150) NOT NULL,
    [item_detail] NVARCHAR(100),
    [item_note] NVARCHAR(103)
);
GO

INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (1, N'มะหมา', N'สุนัข', N'อรุณ สว่างศรี', N'0812345001', 1, '2026-03-01', N'ตรวจสุขภาพประจำปี', N'สุขภาพแข็งแรงดี ไม่พบความผิดปกติ', N'ฉีดวัคซีน DHPPiL และ Rabies / ถ่ายพยาธิ', '2.80', '2027-03-01', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'ยา', N'วิตามินบี รวม', N'1 เม็ด ครั้งเดียว', N'1 วัน / จ่าย 1 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (1, N'มะหมา', N'สุนัข', N'อรุณ สว่างศรี', N'0812345001', 1, '2026-03-01', N'ตรวจสุขภาพประจำปี', N'สุขภาพแข็งแรงดี ไม่พบความผิดปกติ', N'ฉีดวัคซีน DHPPiL และ Rabies / ถ่ายพยาธิ', '2.80', '2027-03-01', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'ยา', N'โอเมก้า 3 น้ำมันปลา', N'1 แคปซูล วันละ 1 ครั้ง', N'30 วัน / จ่าย 30 แคปซูล');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (3, N'บัตเตอร์', N'สุนัข', N'นภาพร ทองดี', N'0823456002', 2, '2026-03-11', N'ท้องเสีย 3 วัน อาเจียน 2 ครั้ง', N'Acute Gastroenteritis — ลำไส้อักเสบเฉียบพลัน', N'ให้น้ำเกลือ IV 500ml / ยาแก้อาเจียน / ยาปฏิชีวนะ', '31.80', '2026-03-18', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'ยา', N'เมโทโคลพราไมด์ 10mg', N'1/2 เม็ด วันละ 2 ครั้ง', N'5 วัน / จ่าย 5 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (3, N'บัตเตอร์', N'สุนัข', N'นภาพร ทองดี', N'0823456002', 2, '2026-03-11', N'ท้องเสีย 3 วัน อาเจียน 2 ครั้ง', N'Acute Gastroenteritis — ลำไส้อักเสบเฉียบพลัน', N'ให้น้ำเกลือ IV 500ml / ยาแก้อาเจียน / ยาปฏิชีวนะ', '31.80', '2026-03-18', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'ยา', N'อะม็อกซิซิลลิน 250mg', N'2 เม็ด วันละ 2 ครั้ง', N'7 วัน / จ่าย 28 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (5, N'ร็อคกี้', N'สุนัข', N'วรพล มีโชค', N'0834567003', 3, '2026-03-16', N'ขาหน้าซ้ายหัก จากการวิ่งแล้วกระแทกกำแพง', N'Fracture กระดูก Radius ซ้าย — กระดูกต้นแขนซ้ายหัก', N'เอกซเรย์ยืนยัน / ผ่าตัดใส่เหล็กดาม / พักฟื้น 6 สัปดาห์', '22.20', '2026-04-01', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์', N'ยา', N'เพรดนิโซโลน 5mg', N'1 เม็ด วันละ 1 ครั้ง', N'7 วัน / จ่าย 7 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (5, N'ร็อคกี้', N'สุนัข', N'วรพล มีโชค', N'0834567003', 3, '2026-03-16', N'ขาหน้าซ้ายหัก จากการวิ่งแล้วกระแทกกำแพง', N'Fracture กระดูก Radius ซ้าย — กระดูกต้นแขนซ้ายหัก', N'เอกซเรย์ยืนยัน / ผ่าตัดใส่เหล็กดาม / พักฟื้น 6 สัปดาห์', '22.20', '2026-04-01', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์', N'ยา', N'อะม็อกซิซิลลิน 250mg', N'2 เม็ด วันละ 2 ครั้ง', N'10 วัน / จ่าย 40 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (6, N'ดาว', N'แมว', N'สุภาพร จันทร์งาม', N'0845678004', 4, '2026-03-21', N'ขนร่วง ผิวหนังแดง คัน โดยเฉพาะบริเวณหลัง', N'Allergic Dermatitis — ผิวหนังอักเสบจากภูมิแพ้', N'จ่ายยาแก้แพ้ / ยาทาภายนอก / แชมพูยา', '3.70', '2026-04-04', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'ยา', N'เพรดนิโซโลน 5mg', N'1/2 เม็ด วันละ 1 ครั้ง', N'14 วัน / จ่าย 7 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (6, N'ดาว', N'แมว', N'สุภาพร จันทร์งาม', N'0845678004', 4, '2026-03-21', N'ขนร่วง ผิวหนังแดง คัน โดยเฉพาะบริเวณหลัง', N'Allergic Dermatitis — ผิวหนังอักเสบจากภูมิแพ้', N'จ่ายยาแก้แพ้ / ยาทาภายนอก / แชมพูยา', '3.70', '2026-04-04', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'ยา', N'ไอเวอร์เมคติน 1%', N'0.1ml ต่อน้ำหนัก 1กก.', N'1 วัน / จ่าย 1 ml');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (4, N'มิลค์', N'แมว', N'นภาพร ทองดี', N'0823456002', 5, '2026-03-24', N'ตรวจสุขภาพก่อนผ่าตัดทำหมัน', N'สุขภาพพร้อมสำหรับการผ่าตัด ไม่พบความเสี่ยง', N'เจาะเลือดตรวจ CBC และ Blood Chemistry / ผลปกติ', '4.10', '2026-04-07', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'ยา', N'วิตามินบี รวม', N'1 เม็ด วันละ 1 ครั้ง', N'14 วัน / จ่าย 14 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (7, N'จุ๊บแจง', N'สุนัข', N'สุภาพร จันทร์งาม', N'0845678004', 6, '2026-03-26', N'ซึม เบื่ออาหาร 2 วัน ปัสสาวะบ่อย', N'Urinary Tract Infection — ติดเชื้อทางเดินปัสสาวะ', N'ตรวจปัสสาวะ / จ่ายยาปฏิชีวนะ 10 วัน / ให้น้ำเกลือ SC', '2.00', '2026-04-05', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข', N'ยา', N'เซฟาเลกซิน 500mg', N'1/4 แคปซูล วันละ 2 ครั้ง', N'10 วัน / จ่าย 5 แคปซูล');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (7, N'จุ๊บแจง', N'สุนัข', N'สุภาพร จันทร์งาม', N'0845678004', 6, '2026-03-26', N'ซึม เบื่ออาหาร 2 วัน ปัสสาวะบ่อย', N'Urinary Tract Infection — ติดเชื้อทางเดินปัสสาวะ', N'ตรวจปัสสาวะ / จ่ายยาปฏิชีวนะ 10 วัน / ให้น้ำเกลือ SC', '2.00', '2026-04-05', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข', N'ยา', N'ฟูโรซีไมด์ 40mg', N'1/4 เม็ด วันละ 1 ครั้ง', N'5 วัน / จ่าย 2 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (9, N'ปุ๊กกี้', N'สุนัข', N'พิมพ์ใจ ศิริวัฒน์', N'0867890006', 9, '2026-04-12', N'ตรวจร่างกายทั่วไป', N'Healthy', N'Routine check', '5.00', NULL, 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'ยา', N'ยาระงับปวด Tramadol', N'', N'11 วัน / จ่าย 1 เม็ด');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (1, N'มะหมา', N'สุนัข', N'อรุณ สว่างศรี', N'0812345001', 1, '2026-03-01', N'ตรวจสุขภาพประจำปี', N'สุขภาพแข็งแรงดี ไม่พบความผิดปกติ', N'ฉีดวัคซีน DHPPiL และ Rabies / ถ่ายพยาธิ', '2.80', '2027-03-01', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'วัคซีน', N'DHPPiL (5 in 1)', N'ฉีดวันที่ 01/03/2026', N'ครบกำหนดวันที่ 01/03/2027');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (1, N'มะหมา', N'สุนัข', N'อรุณ สว่างศรี', N'0812345001', 1, '2026-03-01', N'ตรวจสุขภาพประจำปี', N'สุขภาพแข็งแรงดี ไม่พบความผิดปกติ', N'ฉีดวัคซีน DHPPiL และ Rabies / ถ่ายพยาธิ', '2.80', '2027-03-01', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'วัคซีน', N'Rabies', N'ฉีดวันที่ 01/03/2026', N'ครบกำหนดวันที่ 01/03/2027');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (6, N'ดาว', N'แมว', N'สุภาพร จันทร์งาม', N'0845678004', 4, '2026-03-21', N'ขนร่วง ผิวหนังแดง คัน โดยเฉพาะบริเวณหลัง', N'Allergic Dermatitis — ผิวหนังอักเสบจากภูมิแพ้', N'จ่ายยาแก้แพ้ / ยาทาภายนอก / แชมพูยา', '3.70', '2026-04-04', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'วัคซีน', N'FVRCP (3 in 1)', N'ฉีดวันที่ 21/03/2026', N'ครบกำหนดวันที่ 21/03/2027');
INSERT INTO dbo.VW_PET_MEDICAL_HISTORY ([pet_id], [pet_name], [species], [owner_name], [owner_phone], [record_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [weight_at_visit], [follow_up_date], [vet_id], [vet_name], [record_type], [item_name], [item_detail], [item_note]) VALUES (6, N'ดาว', N'แมว', N'สุภาพร จันทร์งาม', N'0845678004', 4, '2026-03-21', N'ขนร่วง ผิวหนังแดง คัน โดยเฉพาะบริเวณหลัง', N'Allergic Dermatitis — ผิวหนังอักเสบจากภูมิแพ้', N'จ่ายยาแก้แพ้ / ยาทาภายนอก / แชมพูยา', '3.70', '2026-04-04', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'วัคซีน', N'Rabies', N'ฉีดวันที่ 21/03/2026', N'ครบกำหนดวันที่ 21/03/2027');
GO

-- ==========================================
-- Table: USER_ACCOUNT
-- ==========================================

IF OBJECT_ID('dbo.USER_ACCOUNT', 'U') IS NOT NULL DROP TABLE dbo.USER_ACCOUNT;
CREATE TABLE dbo.USER_ACCOUNT (
    [user_id] INT NOT NULL,
    [username] VARCHAR(100) NOT NULL,
    [password_hash] VARCHAR(255) NOT NULL,
    [role] VARCHAR(10) NOT NULL,
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.USER_ACCOUNT ON;

INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'admin', N'pbkdf2_sha256$600000$HHTfZLWlvnynzSqRjA4mxJ$Y5uxtbYBlI1ZAMWApE6dYivp+6qS36KJaxd9WOdsuyg=', N'admin', '2026-04-11 19:46:10.860000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (2, N'vet1', N'pbkdf2_sha256$600000$IcC4puXJFe9XLJE8D2GSUv$7KjyVW3TFfcNIBRocafL8hj8TLV0AV4RQHzJuuP9044=', N'vet', '2026-04-11 19:46:11.050000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (3, N'vet2', N'pbkdf2_sha256$600000$uxsp2ldxTnG0ki6FWziVIF$1VisvAwcl0ulfNCUv4AtjNWY9ZsrTL5D4dsAX7rFcT0=', N'vet', '2026-04-11 19:46:11.220000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (4, N'vet3', N'pbkdf2_sha256$600000$C789wuQlsckiNXPFbv75OT$5g5E9AjOZwwzPRWE/AWbuxMltz+E1G+qELs/5n0QAkE=', N'vet', '2026-04-11 19:46:11.390000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (5, N'vet4', N'pbkdf2_sha256$600000$mYN62HHK7PIeqaxsjD2WfA$KGNYuOhV2PrU2XGQCvxXoEO6Enz8sisKgTap+3hUM5I=', N'vet', '2026-04-11 19:46:11.560000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (6, N'0812345001', N'pbkdf2_sha256$600000$EVnHXd1YWzh7Q5JNGIgAvL$biBkR84Rwk7ZFSc8bnnxfYuU6dUUItZdYn6M8S48+fI=', N'owner', '2026-04-11 19:46:11.730000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (7, N'0823456002', N'pbkdf2_sha256$600000$1n2V0gYCKXrL3NAeSFGGY2$QtnVWhekjLtpB1g3mjy/kc9G6mYak7aBz0MqnB3U4kE=', N'owner', '2026-04-11 19:46:11.900000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (8, N'0834567003', N'pbkdf2_sha256$600000$Bk608PvtsSXTZAAkgfEydv$MfloEFLD1x1fiTv3dHJiY3BBAdUhO4x142j3Au2vboI=', N'owner', '2026-04-11 19:46:12.070000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (9, N'0845678004', N'pbkdf2_sha256$600000$kTBFNPxVsuHCXI6SQbNe0T$3DQLaypQg4IoEyZ4gfuw8jx6en9p/eg3HmSFJZm2mEQ=', N'owner', '2026-04-11 19:46:12.243000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (10, N'0856789005', N'pbkdf2_sha256$600000$QU5jUqxtBsqlOPZmitsFDY$zBzMi9zG2XwpH/Uk9VIM4g+hfDc2ua8ZH74VX6Nlj1g=', N'owner', '2026-04-11 19:46:12.417000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (11, N'0867890006', N'pbkdf2_sha256$600000$AnVdh2bh1dSKvOAXmWEEwo$2scsHzy8yfkKbmc04p0Ho5f5hyHzA7pyo2OOEwTNyLI=', N'owner', '2026-04-11 19:46:12.590000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (12, N'0878901007', N'pbkdf2_sha256$600000$KwBPTUml2XBc3ucBwGBT3u$6ZHNJn0eaMwXl2JwwklC8iWgspe8CYgeY+uDl+15fEA=', N'owner', '2026-04-11 19:46:12.770000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (13, N'0843649134', N'pbkdf2_sha256$600000$HoyTTmItMZHjM8NeDfdcav$Dn0QTV+4try5jr672iqJ0WjWMGfudCKKb6KqIAidwEE=', N'owner', '2026-04-11 19:46:12.947000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (14, N'0882669997', N'pbkdf2_sha256$600000$3XIafyeFU63KjCz0mPlU0r$+NsxN2mchVxj/5+wZ6vyGigtsSoIQnVRQrGWlC0DL8A=', N'owner', '2026-04-11 19:46:13.120000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (16, N'orkan11', N'pbkdf2_sha256$600000$qfjj0vA0Cv4sZvb9VkFeIg$m0/QiWh32JZYRiUDGSNpCXgivx6/31OSEavzecHYV+A=', N'owner', '2026-04-12 09:26:16.950000');
INSERT INTO dbo.USER_ACCOUNT ([user_id], [username], [password_hash], [role], [created_at]) VALUES (17, N'tester1', N'pbkdf2_sha256$600000$Ul3RuGWwGeM9yfS1wuVGR6$1ZPgn2ChOVs2kMTEhEvALoFxYR77QmjWyeiPSw1WMns=', N'owner', '2026-04-12 22:10:59.353000');
SET IDENTITY_INSERT dbo.USER_ACCOUNT OFF;

GO

-- ==========================================
-- Table: SERVICE
-- ==========================================

IF OBJECT_ID('dbo.SERVICE', 'U') IS NOT NULL DROP TABLE dbo.SERVICE;
CREATE TABLE dbo.SERVICE (
    [service_id] INT NOT NULL,
    [service_name] NVARCHAR(100) NOT NULL,
    [description] NVARCHAR(255),
    [price] DECIMAL NOT NULL,
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.SERVICE ON;

INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (1, N'ตรวจร่างกายทั่วไป', N'Physical Examination', '200.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (2, N'เจาะเลือด CBC', N'Complete Blood Count', '500.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (3, N'เจาะเลือด Blood Chem', N'Blood Chemistry Panel', '800.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (4, N'เอกซเรย์ (1 ท่า)', N'X-Ray 1 View', '600.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (5, N'เอกซเรย์ (2 ท่า)', N'X-Ray 2 Views', '900.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (6, N'อัลตราซาวด์', N'Ultrasonography', '1200.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (7, N'อาบน้ำตัดขน (เล็ก)', N'Grooming - Small breed (< 5kg)', '300.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (8, N'อาบน้ำตัดขน (กลาง)', N'Grooming - Medium breed (5-15kg)', '500.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (9, N'อาบน้ำตัดขน (ใหญ่)', N'Grooming - Large breed (> 15kg)', '700.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (10, N'ผ่าตัดทำหมัน (ตัวผู้)', N'Neutering - Male', '2500.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (11, N'ผ่าตัดทำหมัน (ตัวเมีย)', N'Spaying - Female', '3500.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (12, N'ทำฟัน / ขูดหินปูน', N'Dental Scaling', '1500.00', True);
INSERT INTO dbo.SERVICE ([service_id], [service_name], [description], [price], [is_active]) VALUES (13, N'ฝังไมโครชิป', N'Microchip Implantation', '400.00', True);
SET IDENTITY_INSERT dbo.SERVICE OFF;

GO

-- ==========================================
-- Table: RECORD_SERVICE
-- ==========================================

IF OBJECT_ID('dbo.RECORD_SERVICE', 'U') IS NOT NULL DROP TABLE dbo.RECORD_SERVICE;
CREATE TABLE dbo.RECORD_SERVICE (
    [record_service_id] INT NOT NULL,
    [record_id] INT NOT NULL,
    [service_id] INT NOT NULL,
    [price_charged] DECIMAL NOT NULL,
    [notes] NVARCHAR(255),
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.RECORD_SERVICE ON;

INSERT INTO dbo.RECORD_SERVICE ([record_service_id], [record_id], [service_id], [price_charged], [notes], [created_at]) VALUES (2, 9, 13, '400.00', N'', '2026-04-12 15:59:16.420000');
SET IDENTITY_INSERT dbo.RECORD_SERVICE OFF;

GO

-- ==========================================
-- Table: SPECIES
-- ==========================================

IF OBJECT_ID('dbo.SPECIES', 'U') IS NOT NULL DROP TABLE dbo.SPECIES;
CREATE TABLE dbo.SPECIES (
    [species_id] INT NOT NULL,
    [species_name] NVARCHAR(50) NOT NULL,
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.SPECIES ON;

INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (1, N'สุนัข', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (2, N'แมว', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (3, N'กระต่าย', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (4, N'นก', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (5, N'หนูแฮมสเตอร์', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (6, N'เต่า', True);
INSERT INTO dbo.SPECIES ([species_id], [species_name], [is_active]) VALUES (7, N'อื่นๆ', True);
SET IDENTITY_INSERT dbo.SPECIES OFF;

GO

-- ==========================================
-- Table: BREED
-- ==========================================

IF OBJECT_ID('dbo.BREED', 'U') IS NOT NULL DROP TABLE dbo.BREED;
CREATE TABLE dbo.BREED (
    [breed_id] INT NOT NULL,
    [species_id] INT NOT NULL,
    [breed_name] NVARCHAR(100) NOT NULL,
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.BREED ON;

INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (1, 1, N'ชิวาวา', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (2, 1, N'ปอมเมอเรเนียน', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (3, 1, N'มอลทีส', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (4, 1, N'ชิห์สุ', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (5, 1, N'บีเกิล', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (6, 1, N'โกลเดน รีทรีฟเวอร์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (7, 1, N'ลาบราดอร์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (8, 1, N'ไซบีเรียน ฮัสกี้', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (9, 1, N'บอร์เดอร์ คอลลี่', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (10, 1, N'เยอรมัน เชพเพิร์ด', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (11, 1, N'พุดเดิ้ล', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (12, 1, N'บูลด็อก', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (13, 1, N'โกลเดน ดูดิ้ล', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (14, 1, N'ไทย บางแก้ว', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (15, 1, N'พันธุ์ผสม', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (16, 2, N'เปอร์เซีย', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (17, 2, N'วิเชียรมาศ', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (18, 2, N'สกอตติช โฟลด์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (19, 2, N'อเมริกัน ชอร์ตแฮร์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (20, 2, N'เมนคูน', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (21, 2, N'รัสเซียน บลู', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (22, 2, N'อะบิสซิเนียน', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (23, 2, N'เบงกอล', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (24, 2, N'พันธุ์ผสม', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (25, 3, N'ฮอลแลนด์ ลop', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (26, 3, N'มินิ เร็กซ์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (27, 3, N'ไลอ้อน เฮด', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (28, 3, N'ดัตช์', True);
INSERT INTO dbo.BREED ([breed_id], [species_id], [breed_name], [is_active]) VALUES (29, 3, N'พันธุ์ผสม', True);
SET IDENTITY_INSERT dbo.BREED OFF;

GO

-- ==========================================
-- Table: OWNER
-- ==========================================

IF OBJECT_ID('dbo.OWNER', 'U') IS NOT NULL DROP TABLE dbo.OWNER;
CREATE TABLE dbo.OWNER (
    [owner_id] INT NOT NULL,
    [first_name] NVARCHAR(50) NOT NULL,
    [last_name] NVARCHAR(50) NOT NULL,
    [phone] VARCHAR(20) NOT NULL,
    [email] VARCHAR(100),
    [address] NVARCHAR(255),
    [registered_date] DATE NOT NULL DEFAULT (getdate()),
    [user_id] INT,
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.OWNER ON;

INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (1, N'อรุณ', N'สว่างศรี', N'0812345001', N'arun.sw@gmail.com', N'12/3 ซ.ลาดพร้าว 15 กรุงเทพฯ 10230', '2026-03-30', 6, False);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (2, N'นภาพร', N'ทองดี', N'0823456002', N'napaporn.t@gmail.com', N'88 ถ.สุขุมวิท 39 กรุงเทพฯ 10110', '2026-03-30', 7, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (3, N'วรพล', N'มีโชค', N'0834567003', N'worapol.m@gmail.com', N'55/2 ถ.รัชดาภิเษก กรุงเทพฯ 10310', '2026-03-30', 8, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (4, N'สุภาพร', N'จันทร์งาม', N'0845678004', N'supaporn.j@gmail.com', N'23 ซ.เอกชัย 18 กรุงเทพฯ 10600', '2026-03-30', 9, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (5, N'ธนกร', N'วงศ์ใหญ่', N'0856789005', N'tanakorn.w@gmail.com', N'101 ถ.พหลโยธิน กรุงเทพฯ 10400', '2026-03-30', 10, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (6, N'พิมพ์ใจ', N'ศิริวัฒน์', N'0867890006', N'pimjai.s@gmail.com', N'7/7 ถ.ประชาอุทิศ กรุงเทพฯ 10140', '2026-03-30', 11, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (7, N'กิตติพงษ์', N'แก้วใส', N'0878901007', N'kittipong.k@gmail.com', N'34 ซ.อ่อนนุช 21 กรุงเทพฯ 10250', '2026-03-30', 12, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (8, N'อาลีฟ', N'สาและ', N'0843649134', N'arlif2521@gmail.com', NULL, '2026-04-03', 13, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (9, N'ลำยอง', N'รวยเฮง', N'0882669997', N'lunyoung@gmail.com', NULL, '2026-04-03', 14, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (10, N'test', N'teset', N'9090039394', N'tset@gmail.com', NULL, '2026-04-12', NULL, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (11, N'อรกาน', N'ปรมะ', N'0967062081', N'orkan11@gmail.com', NULL, '2026-04-12', 16, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (13, N'Tester', N'User', N'0811111111', N'tester1@test.com', NULL, '2026-04-12', 17, True);
INSERT INTO dbo.OWNER ([owner_id], [first_name], [last_name], [phone], [email], [address], [registered_date], [user_id], [is_active]) VALUES (14, N'อาลีฟ', N'ยามาว', N'0800315530', NULL, NULL, '2026-04-12', NULL, True);
SET IDENTITY_INSERT dbo.OWNER OFF;

-- Create Filtered Unique Index for Email (Allows multiple NULLs)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_OWNER_EMAIL_FILTERED' AND object_id = OBJECT_ID('dbo.OWNER'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UQ_OWNER_EMAIL_FILTERED
    ON dbo.OWNER(email)
    WHERE email IS NOT NULL;
END
GO

-- ==========================================
-- Table: VW_MEDICINE_DROPDOWN
-- ==========================================

IF OBJECT_ID('dbo.VW_MEDICINE_DROPDOWN', 'U') IS NOT NULL DROP TABLE dbo.VW_MEDICINE_DROPDOWN;
CREATE TABLE dbo.VW_MEDICINE_DROPDOWN (
    [medicine_id] INT NOT NULL,
    [medicine_name] NVARCHAR(150) NOT NULL,
    [medicine_type] NVARCHAR(50),
    [unit] NVARCHAR(30) NOT NULL,
    [stock_qty] INT NOT NULL,
    [price_per_unit] DECIMAL,
    [stock_status] NVARCHAR(9) NOT NULL,
    [dropdown_label] NVARCHAR(224)
);
GO

SET IDENTITY_INSERT dbo.VW_MEDICINE_DROPDOWN ON;

INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (1, N'อะม็อกซิซิลลิน 250mg', N'Antibiotic', N'เม็ด', 800, '5.50', N'พร้อมจ่าย', N'อะม็อกซิซิลลิน 250mg (เม็ด) — คงเหลือ 800');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (2, N'เซฟาเลกซิน 500mg', N'Antibiotic', N'แคปซูล', 600, '9.00', N'พร้อมจ่าย', N'เซฟาเลกซิน 500mg (แคปซูล) — คงเหลือ 600');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (3, N'เมโทรนิดาโซล 200mg', N'Antibiotic', N'เม็ด', 500, '4.00', N'พร้อมจ่าย', N'เมโทรนิดาโซล 200mg (เม็ด) — คงเหลือ 500');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (4, N'ไอเวอร์เมคติน 1%', N'Antiparasitic', N'ml', 300, '18.00', N'พร้อมจ่าย', N'ไอเวอร์เมคติน 1% (ml) — คงเหลือ 300');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (5, N'ไฟโปรนิล สเปรย์', N'Antiparasitic', N'ml', 150, '45.00', N'พร้อมจ่าย', N'ไฟโปรนิล สเปรย์ (ml) — คงเหลือ 150');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (6, N'วิตามินบี รวม', N'Supplement', N'เม็ด', 400, '3.50', N'พร้อมจ่าย', N'วิตามินบี รวม (เม็ด) — คงเหลือ 400');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (7, N'โอเมก้า 3 น้ำมันปลา', N'Supplement', N'แคปซูล', 250, '12.00', N'พร้อมจ่าย', N'โอเมก้า 3 น้ำมันปลา (แคปซูล) — คงเหลือ 250');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (8, N'เพรดนิโซโลน 5mg', N'Anti-inflammatory', N'เม็ด', 350, '6.00', N'พร้อมจ่าย', N'เพรดนิโซโลน 5mg (เม็ด) — คงเหลือ 350');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (9, N'ฟูโรซีไมด์ 40mg', N'Diuretic', N'เม็ด', 200, '5.00', N'พร้อมจ่าย', N'ฟูโรซีไมด์ 40mg (เม็ด) — คงเหลือ 200');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (10, N'เมโทโคลพราไมด์ 10mg', N'Antiemetic', N'เม็ด', 305, '4.50', N'พร้อมจ่าย', N'เมโทโคลพราไมด์ 10mg (เม็ด) — คงเหลือ 305');
INSERT INTO dbo.VW_MEDICINE_DROPDOWN ([medicine_id], [medicine_name], [medicine_type], [unit], [stock_qty], [price_per_unit], [stock_status], [dropdown_label]) VALUES (11, N'ยาระงับปวด Tramadol', N'Analgesic', N'เม็ด', 13, '22.00', N'ใกล้หมด', N'ยาระงับปวด Tramadol (เม็ด) — คงเหลือ 13');
SET IDENTITY_INSERT dbo.VW_MEDICINE_DROPDOWN OFF;

GO

-- ==========================================
-- Table: VETERINARIAN
-- ==========================================

IF OBJECT_ID('dbo.VETERINARIAN', 'U') IS NOT NULL DROP TABLE dbo.VETERINARIAN;
CREATE TABLE dbo.VETERINARIAN (
    [vet_id] INT NOT NULL,
    [first_name] NVARCHAR(50) NOT NULL,
    [last_name] NVARCHAR(50) NOT NULL,
    [license_no] VARCHAR(30) NOT NULL,
    [specialization] NVARCHAR(100),
    [phone] VARCHAR(20),
    [pet_count] INT NOT NULL DEFAULT ((0)),
    [is_active] BIT NOT NULL DEFAULT ((1)),
    [profile_image] NVARCHAR(255),
    [user_id] INT
);
GO

SET IDENTITY_INSERT dbo.VETERINARIAN ON;

INSERT INTO dbo.VETERINARIAN ([vet_id], [first_name], [last_name], [license_no], [specialization], [phone], [pet_count], [is_active], [profile_image], [user_id]) VALUES (1, N'นายสัตวแพทย์ ชาญชัย', N'รักษ์สัตว์', N'VET-TH-2015-001', N'อายุรกรรมทั่วไป', N'021110001', 4, True, N'https://www.tech101.in/wp-content/uploads/2018/07/blank-profile-picture.png', 2);
INSERT INTO dbo.VETERINARIAN ([vet_id], [first_name], [last_name], [license_no], [specialization], [phone], [pet_count], [is_active], [profile_image], [user_id]) VALUES (2, N'นายสัตวแพทย์ ปิยะ', N'วงศ์แพทย์', N'VET-TH-2017-002', N'ศัลยกรรมและกระดูก', N'021110002', 1, True, N'https://www.tech101.in/wp-content/uploads/2018/07/blank-profile-picture.png', 3);
INSERT INTO dbo.VETERINARIAN ([vet_id], [first_name], [last_name], [license_no], [specialization], [phone], [pet_count], [is_active], [profile_image], [user_id]) VALUES (3, N'สัตวแพทย์หญิง มาลินี', N'สุขสวัสดิ์', N'VET-TH-2018-003', N'ทันตกรรมและผิวหนัง', N'021110003', 1, True, N'https://www.tech101.in/wp-content/uploads/2018/07/blank-profile-picture.png', 4);
INSERT INTO dbo.VETERINARIAN ([vet_id], [first_name], [last_name], [license_no], [specialization], [phone], [pet_count], [is_active], [profile_image], [user_id]) VALUES (4, N'สัตวแพทย์หญิง ศิริพร', N'เจริญสุข', N'VET-TH-2020-004', N'อายุรกรรมและโรคติดเชื้อ', N'021110004', 1, True, N'https://www.tech101.in/wp-content/uploads/2018/07/blank-profile-picture.png', 5);
INSERT INTO dbo.VETERINARIAN ([vet_id], [first_name], [last_name], [license_no], [specialization], [phone], [pet_count], [is_active], [profile_image], [user_id]) VALUES (5, N'นายสัตวแพทย์ ภูมิ', N'ดีเลิศ', N'VET-TH-2019-005', N'รังสีวิทยาและอัลตราซาวด์', N'021110005', 0, False, N'https://www.tech101.in/design-patterns-null-object/', NULL);
SET IDENTITY_INSERT dbo.VETERINARIAN OFF;

GO

-- ==========================================
-- Table: PET
-- ==========================================

IF OBJECT_ID('dbo.PET', 'U') IS NOT NULL DROP TABLE dbo.PET;
CREATE TABLE dbo.PET (
    [pet_id] INT NOT NULL,
    [owner_id] INT NOT NULL,
    [primary_vet_id] INT,
    [name] NVARCHAR(50) NOT NULL,
    [date_of_birth] DATE,
    [gender] CHAR(1) DEFAULT ('U'),
    [weight_kg] DECIMAL,
    [is_neutered] BIT NOT NULL DEFAULT ((0)),
    [is_active] BIT NOT NULL DEFAULT ((1)),
    [species_id] INT NOT NULL,
    [breed_id] INT
);
GO

SET IDENTITY_INSERT dbo.PET ON;

INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (1, 1, 1, N'มะหมา', '2020-04-10', N'F', '2.80', True, False, 1, 11);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (2, 1, 1, N'แมวเหมียว', '2021-08-22', N'F', '3.50', True, True, 2, 19);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (3, 2, 1, N'บัตเตอร์', '2019-11-05', N'M', '32.40', True, True, 1, 6);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (4, 2, 3, N'มิลค์', '2022-02-14', N'F', '4.10', False, True, 2, 16);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (5, 3, 2, N'ร็อคกี้', '2021-06-30', N'M', '22.70', False, True, 1, 8);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (6, 4, 3, N'ดาว', '2020-09-01', N'F', '3.80', True, True, 2, 17);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (7, 4, 4, N'จุ๊บแจง', '2023-01-15', N'F', '2.10', False, True, 1, 3);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (8, 5, 4, N'โอโซน', '2022-07-20', N'M', '18.50', True, True, 1, 9);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (9, 6, 1, N'ปุ๊กกี้', '2015-03-20', N'M', '3.20', True, True, 1, 2);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (10, 7, NULL, N'ลูกปลา', '2023-06-01', N'F', '1.50', False, True, 3, 25);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (12, 2, 1, N'วานิลา', '2022-11-15', N'F', '3.80', False, True, 2, 18);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (14, 1, 1, N'ทองเอก', '2023-01-15', N'M', '25.50', False, True, 1, 15);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (16, 8, NULL, N'โบ็ท', NULL, N'U', NULL, False, True, 6, NULL);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (17, 8, 1, N'อะม็อก', '2026-04-09', N'M', '0.15', False, True, 5, NULL);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (18, 9, NULL, N'ไอดำ', NULL, N'U', NULL, False, True, 2, NULL);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (20, 10, NULL, N'test3', NULL, N'U', NULL, False, True, 3, NULL);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (21, 1, NULL, N'ลักกีั', NULL, N'U', NULL, False, True, 3, NULL);
INSERT INTO dbo.PET ([pet_id], [owner_id], [primary_vet_id], [name], [date_of_birth], [gender], [weight_kg], [is_neutered], [is_active], [species_id], [breed_id]) VALUES (22, 11, NULL, N'ดำ', NULL, N'U', NULL, False, True, 1, 14);
SET IDENTITY_INSERT dbo.PET OFF;

GO

-- ==========================================
-- Table: APPOINTMENT
-- ==========================================

IF OBJECT_ID('dbo.APPOINTMENT', 'U') IS NOT NULL DROP TABLE dbo.APPOINTMENT;
CREATE TABLE dbo.APPOINTMENT (
    [appt_id] INT NOT NULL,
    [pet_id] INT NOT NULL,
    [vet_id] INT,
    [appt_datetime] DATETIME NOT NULL,
    [status] VARCHAR(20) NOT NULL DEFAULT ('Scheduled'),
    [reason] NVARCHAR(200),
    [notes] NVARCHAR(MAX),
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.APPOINTMENT ON;

INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (1, 1, 1, '2026-02-28 22:23:54.617000', N'Completed', N'ตรวจร่างกายประจำปี + ฉีดวัคซีน', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (2, 3, 1, '2026-03-10 22:23:54.617000', N'Completed', N'ท้องเสีย อาเจียน', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (3, 5, 2, '2026-03-15 22:23:54.617000', N'Completed', N'ขาหักจากอุบัติเหตุ', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (4, 6, 3, '2026-03-20 22:23:54.617000', N'Completed', N'ขนร่วง ผิวหนังอักเสบ', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (5, 4, 3, '2026-03-23 22:23:54.617000', N'Completed', N'ตรวจสุขภาพก่อนทำหมัน', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (6, 7, 4, '2026-03-25 22:23:54.617000', N'Completed', N'ไม่สบาย ซึม เบื่ออาหาร', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (7, 2, 1, '2026-03-27 22:23:54.617000', N'Completed', N'ติดตามอาการหลังรักษา', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (8, 8, 4, '2026-03-30 22:23:54.617000', N'Scheduled', N'ฉีดวัคซีนประจำปี', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (9, 1, 1, '2026-04-06 22:23:54.617000', N'Scheduled', N'ติดตามผลการรักษา', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (10, 3, 1, '2026-04-09 22:23:54.617000', N'Scheduled', N'ฉีดวัคซีน DHPPiL บูสเตอร์', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (11, 4, 3, '2026-04-13 22:23:54.617000', N'completed', N'ผ่าตัดทำหมัน', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (12, 9, 1, '2026-04-20 22:23:54.617000', N'Completed', N'ตรวจร่างกายทั่วไป', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (13, 2, 1, '2026-02-13 22:23:54.617000', N'Cancelled', N'ฉีดวัคซีน', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (14, 5, 2, '2026-01-29 22:23:54.617000', N'No-show', N'ตรวจเลือดประจำปี', NULL, '2026-03-30 22:23:54.617000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (19, 18, 2, '2026-04-30 09:04:00', N'completed', N'[เอกซเรย์ (2 ท่า)]', NULL, '2026-04-03 09:07:00.173000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (21, 20, 1, '2026-04-07 10:00:00', N'Scheduled', N'[เจาะเลือด Blood Chem]', NULL, '2026-04-12 02:39:58.110000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (23, 21, 2, '2026-04-23 09:00:00', N'Scheduled', N'[เจาะเลือด Blood Chem]', NULL, '2026-04-12 03:37:18.240000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (24, 22, 2, '2026-04-13 15:00:00', N'Cancelled', N'[อาบน้ำตัดขน (เล็ก)]', NULL, '2026-04-12 08:03:44.530000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (25, 22, 1, '2026-04-13 19:00:00', N'Completed', N'[อาบน้ำตัดขน (กลาง)]', NULL, '2026-04-12 15:23:22.443000');
INSERT INTO dbo.APPOINTMENT ([appt_id], [pet_id], [vet_id], [appt_datetime], [status], [reason], [notes], [created_at]) VALUES (26, 20, 1, '2026-04-15 09:00:00', N'Scheduled', N'Checkup', NULL, '2026-04-12 17:22:18.473000');
SET IDENTITY_INSERT dbo.APPOINTMENT OFF;

GO

-- ==========================================
-- Table: django_migrations
-- ==========================================

IF OBJECT_ID('dbo.django_migrations', 'U') IS NOT NULL DROP TABLE dbo.django_migrations;
CREATE TABLE dbo.django_migrations (
    [id] BIGINT NOT NULL,
    [app] NVARCHAR(255) NOT NULL,
    [name] NVARCHAR(255) NOT NULL,
    [applied] DATETIMEOFFSET NOT NULL
);
GO

SET IDENTITY_INSERT dbo.django_migrations ON;

INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (1, N'contenttypes', N'0001_initial', '2026-04-04 11:38:22.688659');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (2, N'auth', N'0001_initial', '2026-04-04 11:38:22.723858');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (3, N'admin', N'0001_initial', '2026-04-04 11:38:22.738902');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (4, N'admin', N'0002_logentry_remove_auto_add', '2026-04-04 11:38:22.748165');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (5, N'admin', N'0003_logentry_add_action_flag_choices', '2026-04-04 11:38:22.756809');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (6, N'contenttypes', N'0002_remove_content_type_name', '2026-04-04 11:38:23.066565');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (7, N'auth', N'0002_alter_permission_name_max_length', '2026-04-04 11:38:23.075605');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (8, N'auth', N'0003_alter_user_email_max_length', '2026-04-04 11:38:23.084580');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (9, N'auth', N'0004_alter_user_username_opts', '2026-04-04 11:38:23.092285');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (10, N'auth', N'0005_alter_user_last_login_null', '2026-04-04 11:38:23.363971');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (11, N'auth', N'0006_require_contenttypes_0002', '2026-04-04 11:38:23.370128');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (12, N'auth', N'0007_alter_validators_add_error_messages', '2026-04-04 11:38:23.379087');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (13, N'auth', N'0008_alter_user_username_max_length', '2026-04-04 11:38:23.425367');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (14, N'auth', N'0009_alter_user_last_name_max_length', '2026-04-04 11:38:23.437383');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (15, N'auth', N'0010_alter_group_name_max_length', '2026-04-04 11:38:23.725671');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (16, N'auth', N'0011_update_proxy_permissions', '2026-04-04 11:38:23.733662');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (17, N'auth', N'0012_alter_user_first_name_max_length', '2026-04-04 11:38:23.743354');
INSERT INTO dbo.django_migrations ([id], [app], [name], [applied]) VALUES (18, N'sessions', N'0001_initial', '2026-04-04 11:38:23.752162');
SET IDENTITY_INSERT dbo.django_migrations OFF;

GO

-- ==========================================
-- Table: django_content_type
-- ==========================================

IF OBJECT_ID('dbo.django_content_type', 'U') IS NOT NULL DROP TABLE dbo.django_content_type;
CREATE TABLE dbo.django_content_type (
    [id] INT NOT NULL,
    [app_label] NVARCHAR(100) NOT NULL,
    [model] NVARCHAR(100) NOT NULL
);
GO

SET IDENTITY_INSERT dbo.django_content_type ON;

INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (1, N'admin', N'logentry');
INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (3, N'auth', N'group');
INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (2, N'auth', N'permission');
INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (4, N'auth', N'user');
INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (5, N'contenttypes', N'contenttype');
INSERT INTO dbo.django_content_type ([id], [app_label], [model]) VALUES (6, N'sessions', N'session');
SET IDENTITY_INSERT dbo.django_content_type OFF;

GO

-- ==========================================
-- Table: auth_permission
-- ==========================================

IF OBJECT_ID('dbo.auth_permission', 'U') IS NOT NULL DROP TABLE dbo.auth_permission;
CREATE TABLE dbo.auth_permission (
    [id] INT NOT NULL,
    [name] NVARCHAR(255) NOT NULL,
    [content_type_id] INT NOT NULL,
    [codename] NVARCHAR(100) NOT NULL
);
GO

SET IDENTITY_INSERT dbo.auth_permission ON;

INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (1, N'Can add log entry', 1, N'add_logentry');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (2, N'Can change log entry', 1, N'change_logentry');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (3, N'Can delete log entry', 1, N'delete_logentry');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (4, N'Can view log entry', 1, N'view_logentry');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (5, N'Can add permission', 2, N'add_permission');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (6, N'Can change permission', 2, N'change_permission');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (7, N'Can delete permission', 2, N'delete_permission');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (8, N'Can view permission', 2, N'view_permission');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (9, N'Can add group', 3, N'add_group');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (10, N'Can change group', 3, N'change_group');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (11, N'Can delete group', 3, N'delete_group');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (12, N'Can view group', 3, N'view_group');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (13, N'Can add user', 4, N'add_user');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (14, N'Can change user', 4, N'change_user');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (15, N'Can delete user', 4, N'delete_user');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (16, N'Can view user', 4, N'view_user');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (17, N'Can add content type', 5, N'add_contenttype');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (18, N'Can change content type', 5, N'change_contenttype');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (19, N'Can delete content type', 5, N'delete_contenttype');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (20, N'Can view content type', 5, N'view_contenttype');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (21, N'Can add session', 6, N'add_session');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (22, N'Can change session', 6, N'change_session');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (23, N'Can delete session', 6, N'delete_session');
INSERT INTO dbo.auth_permission ([id], [name], [content_type_id], [codename]) VALUES (24, N'Can view session', 6, N'view_session');
SET IDENTITY_INSERT dbo.auth_permission OFF;

GO

-- ==========================================
-- Table: MEDICAL_RECORD
-- ==========================================

IF OBJECT_ID('dbo.MEDICAL_RECORD', 'U') IS NOT NULL DROP TABLE dbo.MEDICAL_RECORD;
CREATE TABLE dbo.MEDICAL_RECORD (
    [record_id] INT NOT NULL,
    [appt_id] INT,
    [pet_id] INT NOT NULL,
    [vet_id] INT NOT NULL,
    [visit_date] DATE NOT NULL DEFAULT (getdate()),
    [chief_complaint] NVARCHAR(255),
    [diagnosis] NVARCHAR(MAX),
    [treatment] NVARCHAR(MAX),
    [notes] NVARCHAR(MAX),
    [weight_at_visit] DECIMAL,
    [follow_up_date] DATE,
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.MEDICAL_RECORD ON;

INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (1, 1, 1, 1, '2026-03-01', N'ตรวจสุขภาพประจำปี', N'สุขภาพแข็งแรงดี ไม่พบความผิดปกติ', N'ฉีดวัคซีน DHPPiL และ Rabies / ถ่ายพยาธิ', N'น้ำหนักเพิ่มขึ้น 0.3 กก. จากปีที่แล้ว แนะนำควบคุมอาหาร', '2.80', '2027-03-01', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (2, 2, 3, 1, '2026-03-11', N'ท้องเสีย 3 วัน อาเจียน 2 ครั้ง', N'Acute Gastroenteritis — ลำไส้อักเสบเฉียบพลัน', N'ให้น้ำเกลือ IV 500ml / ยาแก้อาเจียน / ยาปฏิชีวนะ', N'แนะนำอาหารอ่อน 3-5 วัน งดอาหารที่เจ้าของให้เอง', '31.80', '2026-03-18', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (3, 3, 5, 2, '2026-03-16', N'ขาหน้าซ้ายหัก จากการวิ่งแล้วกระแทกกำแพง', N'Fracture กระดูก Radius ซ้าย — กระดูกต้นแขนซ้ายหัก', N'เอกซเรย์ยืนยัน / ผ่าตัดใส่เหล็กดาม / พักฟื้น 6 สัปดาห์', N'ห้ามวิ่งหรือกระโดด ต้องใส่ปลอกคอ ติดตามทุก 2 สัปดาห์', '22.20', '2026-04-01', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (4, 4, 6, 3, '2026-03-21', N'ขนร่วง ผิวหนังแดง คัน โดยเฉพาะบริเวณหลัง', N'Allergic Dermatitis — ผิวหนังอักเสบจากภูมิแพ้', N'จ่ายยาแก้แพ้ / ยาทาภายนอก / แชมพูยา', N'แนะนำเปลี่ยนอาหาร ล้างที่นอนสัปดาห์ละครั้ง', '3.70', '2026-04-04', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (5, 5, 4, 3, '2026-03-24', N'ตรวจสุขภาพก่อนผ่าตัดทำหมัน', N'สุขภาพพร้อมสำหรับการผ่าตัด ไม่พบความเสี่ยง', N'เจาะเลือดตรวจ CBC และ Blood Chemistry / ผลปกติ', N'นัดผ่าตัดอีก 1 สัปดาห์ งดอาหาร 12 ชั่วโมงก่อนผ่า', '4.10', '2026-04-07', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (6, 6, 7, 4, '2026-03-26', N'ซึม เบื่ออาหาร 2 วัน ปัสสาวะบ่อย', N'Urinary Tract Infection — ติดเชื้อทางเดินปัสสาวะ', N'ตรวจปัสสาวะ / จ่ายยาปฏิชีวนะ 10 วัน / ให้น้ำเกลือ SC', N'แนะนำให้ดื่มน้ำมากขึ้น อาหาร Urinary Health', '2.00', '2026-04-05', '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (7, 7, 2, 1, '2026-03-28', N'ติดตามอาการหลังรักษา — อาการดีขึ้นมากแล้ว', N'อาการหายเป็นปกติ', N'ไม่ต้องการยาเพิ่มเติม', N'เจ้าของพอใจผลการรักษา นัดตรวจประจำปีครั้งถัดไป', '3.50', NULL, '2026-03-31 09:47:16.020000');
INSERT INTO dbo.MEDICAL_RECORD ([record_id], [appt_id], [pet_id], [vet_id], [visit_date], [chief_complaint], [diagnosis], [treatment], [notes], [weight_at_visit], [follow_up_date], [created_at]) VALUES (9, 12, 9, 1, '2026-04-12', N'ตรวจร่างกายทั่วไป', N'Healthy', N'Routine check', N'', '5.00', NULL, '2026-04-12 15:59:16.420000');
SET IDENTITY_INSERT dbo.MEDICAL_RECORD OFF;

GO

-- ==========================================
-- Table: auth_group
-- ==========================================

IF OBJECT_ID('dbo.auth_group', 'U') IS NOT NULL DROP TABLE dbo.auth_group;
CREATE TABLE dbo.auth_group (
    [id] INT NOT NULL,
    [name] NVARCHAR(150) NOT NULL
);
GO

-- ==========================================
-- Table: auth_group_permissions
-- ==========================================

IF OBJECT_ID('dbo.auth_group_permissions', 'U') IS NOT NULL DROP TABLE dbo.auth_group_permissions;
CREATE TABLE dbo.auth_group_permissions (
    [id] BIGINT NOT NULL,
    [group_id] INT NOT NULL,
    [permission_id] INT NOT NULL
);
GO

-- ==========================================
-- Table: auth_user
-- ==========================================

IF OBJECT_ID('dbo.auth_user', 'U') IS NOT NULL DROP TABLE dbo.auth_user;
CREATE TABLE dbo.auth_user (
    [id] INT NOT NULL,
    [password] NVARCHAR(128) NOT NULL,
    [last_login] DATETIMEOFFSET,
    [is_superuser] BIT NOT NULL,
    [username] NVARCHAR(150) NOT NULL,
    [first_name] NVARCHAR(150) NOT NULL,
    [last_name] NVARCHAR(150) NOT NULL,
    [email] NVARCHAR(254) NOT NULL,
    [is_staff] BIT NOT NULL,
    [is_active] BIT NOT NULL,
    [date_joined] DATETIMEOFFSET NOT NULL
);
GO

SET IDENTITY_INSERT dbo.auth_user ON;

INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (1, N'pbkdf2_sha256$600000$PaPvO8BYdd9aewftXuwrNQ$XPr9Wn28H+U2cStX/3qLzdIrKoih1gN8thk3IHNqeg8=', '2026-04-08 10:54:46.475237', True, N'doctor', N'', N'', N'doctor@mangkudvet.com', True, True, '2026-04-08 10:31:54.560715');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (2, N'pbkdf2_sha256$600000$h8naiJ5tTPJPITNZ8OHgMC$851zhy7mkB0FnKBh6EwVRXDOGkJ8q9rnogFqj4onDE4=', '2026-04-11 20:14:16.412122', False, N'mamamu', N'มาม่า', N'หมูสับ', N'mamamu@gmail.com', False, True, '2026-04-08 11:24:07.621607');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (3, N'!cz5HpaaXcCj7mITxDoCORI77PsrtX2pF0ZKry8NY', '2026-04-12 15:16:56.086527', False, N'admin', N'', N'', N'', True, True, '2026-04-11 20:16:45.284697');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (4, N'!MAyhy43Ns7sz6CtmXVjOzxSQsIv1uuhPnRTeEsgf', '2026-04-12 08:49:54.775257', False, N'vet1', N'', N'', N'', True, True, '2026-04-11 20:17:31.517774');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (5, N'!TOS35scut019YDSka395HtkNg1P8E3aMMFgCDQHv', '2026-04-11 20:33:23.461738', False, N'0812345001', N'', N'', N'', False, True, '2026-04-11 20:33:23.453113');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (6, N'!3wNUzHb4KIGZoJTnRYAT2sh36gqEgxoT42ig2cXl', '2026-04-11 23:55:42.320355', False, N'vet4', N'', N'', N'', True, True, '2026-04-11 23:55:42.311951');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (7, N'!wxWwqkUaeQTXu1RbPFqMq5B9044ffSgU90MvvnkG', '2026-04-12 09:16:09.159594', False, N'orkan11', N'', N'', N'', False, True, '2026-04-12 02:30:05.621016');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (8, N'!EcyPjliAIXcv5hJlG7YuUZv25flQ2PVJRGxGZ8dM', '2026-04-12 08:27:58.364787', False, N'vet2', N'', N'', N'', True, True, '2026-04-12 08:27:58.357750');
INSERT INTO dbo.auth_user ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (9, N'!LerfS6dzkn3cr0rIGBavQWVBE4KWrpMnQdMhnAOy', '2026-04-12 15:12:36.801472', False, N'tester1', N'', N'', N'', False, True, '2026-04-12 15:12:36.788090');
SET IDENTITY_INSERT dbo.auth_user OFF;

GO

-- ==========================================
-- Table: MEDICINE
-- ==========================================

IF OBJECT_ID('dbo.MEDICINE', 'U') IS NOT NULL DROP TABLE dbo.MEDICINE;
CREATE TABLE dbo.MEDICINE (
    [medicine_id] INT NOT NULL,
    [name] NVARCHAR(150) NOT NULL,
    [type] NVARCHAR(50),
    [manufacturer] NVARCHAR(100),
    [unit] NVARCHAR(30) NOT NULL,
    [stock_qty] INT NOT NULL DEFAULT ((0)),
    [min_stock_qty] INT NOT NULL DEFAULT ((10)),
    [price_per_unit] DECIMAL,
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.MEDICINE ON;

INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (1, N'อะม็อกซิซิลลิน 250mg', N'Antibiotic', N'GPO', N'เม็ด', 800, 100, '5.50', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (2, N'เซฟาเลกซิน 500mg', N'Antibiotic', N'Pharmahof', N'แคปซูล', 600, 100, '9.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (3, N'เมโทรนิดาโซล 200mg', N'Antibiotic', N'GPO', N'เม็ด', 500, 80, '4.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (4, N'ไอเวอร์เมคติน 1%', N'Antiparasitic', N'Merial', N'ml', 300, 50, '18.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (5, N'ไฟโปรนิล สเปรย์', N'Antiparasitic', N'Frontline', N'ml', 150, 30, '45.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (6, N'วิตามินบี รวม', N'Supplement', N'Betagro', N'เม็ด', 400, 50, '3.50', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (7, N'โอเมก้า 3 น้ำมันปลา', N'Supplement', N'NaturVet', N'แคปซูล', 250, 40, '12.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (8, N'เพรดนิโซโลน 5mg', N'Anti-inflammatory', N'GPO', N'เม็ด', 350, 60, '6.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (9, N'ฟูโรซีไมด์ 40mg', N'Diuretic', N'GPO', N'เม็ด', 200, 40, '5.00', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (10, N'เมโทโคลพราไมด์ 10mg', N'Antiemetic', N'GPO', N'เม็ด', 305, 50, '4.50', True);
INSERT INTO dbo.MEDICINE ([medicine_id], [name], [type], [manufacturer], [unit], [stock_qty], [min_stock_qty], [price_per_unit], [is_active]) VALUES (11, N'ยาระงับปวด Tramadol', N'Analgesic', NULL, N'เม็ด', 13, 50, '22.00', True);
SET IDENTITY_INSERT dbo.MEDICINE OFF;

GO

-- ==========================================
-- Table: auth_user_groups
-- ==========================================

IF OBJECT_ID('dbo.auth_user_groups', 'U') IS NOT NULL DROP TABLE dbo.auth_user_groups;
CREATE TABLE dbo.auth_user_groups (
    [id] BIGINT NOT NULL,
    [user_id] INT NOT NULL,
    [group_id] INT NOT NULL
);
GO

-- ==========================================
-- Table: auth_user_user_permissions
-- ==========================================

IF OBJECT_ID('dbo.auth_user_user_permissions', 'U') IS NOT NULL DROP TABLE dbo.auth_user_user_permissions;
CREATE TABLE dbo.auth_user_user_permissions (
    [id] BIGINT NOT NULL,
    [user_id] INT NOT NULL,
    [permission_id] INT NOT NULL
);
GO

-- ==========================================
-- Table: VACCINE
-- ==========================================

IF OBJECT_ID('dbo.VACCINE', 'U') IS NOT NULL DROP TABLE dbo.VACCINE;
CREATE TABLE dbo.VACCINE (
    [vaccine_id] INT NOT NULL,
    [name] NVARCHAR(150) NOT NULL,
    [manufacturer] NVARCHAR(100),
    [target_disease] NVARCHAR(200),
    [validity_months] INT,
    [stock_qty] INT NOT NULL DEFAULT ((0)),
    [storage_temp] NVARCHAR(30) DEFAULT ('2-8?C'),
    [is_active] BIT NOT NULL DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.VACCINE ON;

INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (1, N'DHPPiL (5 in 1)', N'Nobivac', N'ไข้หัดสุนัข / ตับอักเสบ / พาร์โวไวรัส / พาราอินฟลูเอนซา / เลปโตสไปโรซิส', 12, 100, N'2-8?C', True);
INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (2, N'Rabies', N'Vanguard', N'โรคพิษสุนัขบ้า', 12, 120, N'2-8?C', True);
INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (3, N'Bordetella', N'Nobivac', N'โรคไอกรนสุนัข (Kennel Cough)', 6, 60, N'2-8?C', True);
INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (4, N'FVRCP (3 in 1)', N'Purevax', N'ไข้หัดแมว / เยื่อบุตาและจมูกอักเสบ / คาลิซิไวรัส', 12, 70, N'2-8?C', True);
INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (5, N'FeLV', N'Nobivac', N'มะเร็งเม็ดเลือดขาวในแมว', 12, 50, N'2-8?C', True);
INSERT INTO dbo.VACCINE ([vaccine_id], [name], [manufacturer], [target_disease], [validity_months], [stock_qty], [storage_temp], [is_active]) VALUES (6, N'FIV', N'Fel-O-Vax', N'ไวรัสภูมิคุ้มกันบกพร่องในแมว', 12, 50, N'2-8?C', True);
SET IDENTITY_INSERT dbo.VACCINE OFF;

GO

-- ==========================================
-- Table: django_admin_log
-- ==========================================

IF OBJECT_ID('dbo.django_admin_log', 'U') IS NOT NULL DROP TABLE dbo.django_admin_log;
CREATE TABLE dbo.django_admin_log (
    [id] INT NOT NULL,
    [action_time] DATETIMEOFFSET NOT NULL,
    [object_id] NVARCHAR(MAX),
    [object_repr] NVARCHAR(200) NOT NULL,
    [action_flag] SMALLINT NOT NULL,
    [change_message] NVARCHAR(MAX) NOT NULL,
    [content_type_id] INT,
    [user_id] INT NOT NULL
);
GO

-- ==========================================
-- Table: PRESCRIPTION
-- ==========================================

IF OBJECT_ID('dbo.PRESCRIPTION', 'U') IS NOT NULL DROP TABLE dbo.PRESCRIPTION;
CREATE TABLE dbo.PRESCRIPTION (
    [prescription_id] INT NOT NULL,
    [record_id] INT NOT NULL,
    [medicine_id] INT NOT NULL,
    [dosage] NVARCHAR(100) NOT NULL,
    [duration_days] INT,
    [qty_dispensed] INT,
    [instructions] NVARCHAR(MAX),
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.PRESCRIPTION ON;

INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (1, 1, 6, N'1 เม็ด ครั้งเดียว', 1, 1, N'ให้พร้อมอาหาร ถ่ายพยาธิรอบต่อไป 3 เดือน', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (2, 1, 7, N'1 แคปซูล วันละ 1 ครั้ง', 30, 30, N'ให้หลังอาหารเช้า บำรุงขนและผิวหนัง', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (3, 2, 10, N'1/2 เม็ด วันละ 2 ครั้ง', 5, 5, N'ให้ก่อนอาหาร 30 นาที ถ้าอาเจียนให้หยุดและโทรแจ้ง', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (4, 2, 1, N'2 เม็ด วันละ 2 ครั้ง', 7, 28, N'ให้หลังอาหาร ครบคอร์สอย่าหยุดยาเอง', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (5, 3, 8, N'1 เม็ด วันละ 1 ครั้ง', 7, 7, N'ให้หลังอาหาร ห้ามให้ยาแก้ปวดคนกับสัตว์โดยเด็ดขาด', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (6, 3, 1, N'2 เม็ด วันละ 2 ครั้ง', 10, 40, N'ป้องกันการติดเชื้อหลังผ่าตัด ให้ครบ 10 วัน', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (7, 4, 8, N'1/2 เม็ด วันละ 1 ครั้ง', 14, 7, N'ให้ตอนเย็น อาจทำให้ง่วงซึม', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (8, 4, 4, N'0.1ml ต่อน้ำหนัก 1กก.', 1, 1, N'หยอดหลังต้นคอ ห้ามอาบน้ำ 48 ชั่วโมง', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (9, 5, 6, N'1 เม็ด วันละ 1 ครั้ง', 14, 14, N'เสริมความแข็งแรงก่อนผ่าตัด ให้พร้อมอาหาร', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (10, 6, 2, N'1/4 แคปซูล วันละ 2 ครั้ง', 10, 5, N'ให้หลังอาหาร ครบ 10 วัน อย่าหยุดยาก่อน', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (11, 6, 9, N'1/4 เม็ด วันละ 1 ครั้ง', 5, 2, N'ให้ตอนเช้า ช่วยระบายน้ำในกระเพาะปัสสาวะ', '2026-03-31 09:50:22.003000');
INSERT INTO dbo.PRESCRIPTION ([prescription_id], [record_id], [medicine_id], [dosage], [duration_days], [qty_dispensed], [instructions], [created_at]) VALUES (15, 9, 11, N'', 11, 1, N'', '2026-04-12 15:59:16.420000');
SET IDENTITY_INSERT dbo.PRESCRIPTION OFF;

GO

-- ==========================================
-- Table: django_session
-- ==========================================

IF OBJECT_ID('dbo.django_session', 'U') IS NOT NULL DROP TABLE dbo.django_session;
CREATE TABLE dbo.django_session (
    [session_key] NVARCHAR(40) NOT NULL,
    [session_data] NVARCHAR(MAX) NOT NULL,
    [expire_date] DATETIMEOFFSET NOT NULL
);
GO

INSERT INTO dbo.django_session ([session_key], [session_data], [expire_date]) VALUES (N'npdmk28jlmfwi9uvl1i4mw8u6prdbltr', N'.eJxVi0EKwyAQRe_iuoTRcdR0196haxlHwVJIIMZV6N2bQBbp8v_33qYi97XG3soS31ndlVW365dYPmU6gMxLGc7ZhtcOHyJzn9bnqfx1lVvdI6YkiJIyZiYhBp9TEXReQgEyGDSwBfDOjKRhtFrAsiEw2QUMQur7A8jbM9E:1wBqVu:HfbgoyJ1p0lvPHijQlO6DhS-1HQ5IMuB5yqWcbj4_Z4', '2026-04-26 08:49:54.777760');
INSERT INTO dbo.django_session ([session_key], [session_data], [expire_date]) VALUES (N'zqwmgkzf8lc3b3caq4szsejcfdti1taq', N'.eJxVizsOgzAQBe_iOkJgr3_pwh2ord3FK0eRQMK4inJ3iESRlO_NzFslbHtJreYtPWd1V17dfj9CfuXlC3jdcnfN2k0nfDCvbdnHS_nrCtZyRloDW6YgnjSIDmSjCW4Ay95zL8ahAc3OonOIGUw_A3EcQDBSFC_qcwCwDjSR:1wBqvJ:SnX1Gz5nc4Jo3KgdzDEb7yX3MWRqqcVc1X2PAos7a_Q', '2026-04-26 09:16:09.162893');
GO

-- ==========================================
-- Table: VACCINATION_RECORD
-- ==========================================

IF OBJECT_ID('dbo.VACCINATION_RECORD', 'U') IS NOT NULL DROP TABLE dbo.VACCINATION_RECORD;
CREATE TABLE dbo.VACCINATION_RECORD (
    [vacc_record_id] INT NOT NULL,
    [pet_id] INT NOT NULL,
    [vaccine_id] INT NOT NULL,
    [vet_id] INT NOT NULL,
    [given_date] DATE NOT NULL DEFAULT (getdate()),
    [next_due_date] DATE,
    [notes] NVARCHAR(255),
    [created_at] DATETIME NOT NULL DEFAULT (getdate())
);
GO

SET IDENTITY_INSERT dbo.VACCINATION_RECORD ON;

INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (1, 1, 1, 1, '2026-03-01', '2027-03-01', N'ไม่มีปฏิกิริยาผิดปกติ', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (2, 1, 2, 1, '2026-03-01', '2027-03-01', N'ไม่มีปฏิกิริยาผิดปกติ', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (3, 1, 1, 1, '2025-03-31', '2026-03-01', N'ปีที่แล้ว — ครบกำหนดแล้ว', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (4, 3, 1, 1, '2025-04-15', '2026-04-15', N'ครบกำหนดเร็วๆ นี้ แจ้งเตือนเจ้าของแล้ว', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (5, 3, 2, 1, '2025-04-15', '2026-04-15', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (6, 3, 3, 1, '2025-10-07', '2026-04-05', N'Bordetella ฉีดทุก 6 เดือน', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (7, 5, 1, 2, '2025-10-02', '2026-10-02', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (8, 5, 2, 2, '2025-10-02', '2026-10-02', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (9, 6, 4, 3, '2026-03-21', '2027-03-21', N'ฉีดพร้อมกับการรักษาผิวหนัง', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (10, 6, 2, 3, '2026-03-21', '2027-03-21', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (11, 4, 4, 3, '2025-09-12', '2026-09-12', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (12, 4, 5, 3, '2025-09-12', '2026-09-12', N'FeLV ฉีดครั้งแรก', '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (13, 8, 1, 4, '2026-03-11', '2027-03-11', NULL, '2026-03-31 09:51:21.883000');
INSERT INTO dbo.VACCINATION_RECORD ([vacc_record_id], [pet_id], [vaccine_id], [vet_id], [given_date], [next_due_date], [notes], [created_at]) VALUES (14, 8, 2, 4, '2026-03-11', '2027-03-11', NULL, '2026-03-31 09:51:21.883000');
SET IDENTITY_INSERT dbo.VACCINATION_RECORD OFF;

GO

-- ==========================================
-- Table: NEWS
-- ==========================================

IF OBJECT_ID('dbo.NEWS', 'U') IS NOT NULL DROP TABLE dbo.NEWS;
CREATE TABLE dbo.NEWS (
    [news_id] INT NOT NULL,
    [title_th] NVARCHAR(255) NOT NULL,
    [content_th] NVARCHAR(MAX) NOT NULL,
    [image_url] NVARCHAR(1000),
    [user_id] INT NOT NULL,
    [category] NVARCHAR(50),
    [created_at] DATETIME DEFAULT (getdate()),
    [is_active] BIT DEFAULT ((1))
);
GO

SET IDENTITY_INSERT dbo.NEWS ON;

INSERT INTO dbo.NEWS ([news_id], [title_th], [content_th], [image_url], [user_id], [category], [created_at], [is_active]) VALUES (1, N'ระวัง! ฮีทสโตรก (โรคลมแดด) ในสัตว์เลี้ยง', N'สาระน่ารู้ / สุขภาพ หัวข้อข่าว: "ระวัง! ฮีทสโตรกในสัตว์เลี้ยง ภัยเงียบช่วงหน้าร้อนที่คนรักสัตว์ต้องระวัง" เนื้อหาโดยย่อ: ในช่วงหน้าร้อนที่อุณหภูมิพุ่งสูง สัตว์เลี้ยงอย่างสุนัขและแมวมีความเสี่ยงที่จะเกิดภาวะฮีทสโตรกได้ง่ายกว่าปกติ เนื่องจากเขาระบายความร้อนได้เพียงแค่ทางอุ้งเท้าและจมูกเท่านั้น
สัญญาณอันตราย:

หอบหายใจแรงผิดปกติ
ลิ้นและเหงือกมีสีแดงจัด
น้ำลายเหนียว เดินเซ หรืออ่อนแรง
อาเจียนหรือชัก', N'https://images.unsplash.com/photo-1534361960057-19889db9621e?auto=format&fit=crop&q=80&w=1000', 1, NULL, NULL, NULL);
SET IDENTITY_INSERT dbo.NEWS OFF;

GO

-- ==========================================
-- Table: VW_VET_WORKLOAD
-- ==========================================

IF OBJECT_ID('dbo.VW_VET_WORKLOAD', 'U') IS NOT NULL DROP TABLE dbo.VW_VET_WORKLOAD;
CREATE TABLE dbo.VW_VET_WORKLOAD (
    [vet_id] INT NOT NULL,
    [vet_name] NVARCHAR(101) NOT NULL,
    [specialization] NVARCHAR(100),
    [active_pet_count] INT NOT NULL,
    [is_active] BIT NOT NULL
);
GO

SET IDENTITY_INSERT dbo.VW_VET_WORKLOAD ON;

INSERT INTO dbo.VW_VET_WORKLOAD ([vet_id], [vet_name], [specialization], [active_pet_count], [is_active]) VALUES (1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์', N'อายุรกรรมทั่วไป', 4, True);
INSERT INTO dbo.VW_VET_WORKLOAD ([vet_id], [vet_name], [specialization], [active_pet_count], [is_active]) VALUES (2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์', N'ศัลยกรรมและกระดูก', 1, True);
INSERT INTO dbo.VW_VET_WORKLOAD ([vet_id], [vet_name], [specialization], [active_pet_count], [is_active]) VALUES (3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์', N'ทันตกรรมและผิวหนัง', 1, True);
INSERT INTO dbo.VW_VET_WORKLOAD ([vet_id], [vet_name], [specialization], [active_pet_count], [is_active]) VALUES (4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข', N'อายุรกรรมและโรคติดเชื้อ', 1, True);
INSERT INTO dbo.VW_VET_WORKLOAD ([vet_id], [vet_name], [specialization], [active_pet_count], [is_active]) VALUES (5, N'นายสัตวแพทย์ ภูมิ ดีเลิศ', N'รังสีวิทยาและอัลตราซาวด์', 0, False);
SET IDENTITY_INSERT dbo.VW_VET_WORKLOAD OFF;

GO

-- ==========================================
-- Table: VW_PET_FULL
-- ==========================================

IF OBJECT_ID('dbo.VW_PET_FULL', 'U') IS NOT NULL DROP TABLE dbo.VW_PET_FULL;
CREATE TABLE dbo.VW_PET_FULL (
    [pet_id] INT NOT NULL,
    [pet_name] NVARCHAR(50) NOT NULL,
    [species] NVARCHAR(50),
    [breed] NVARCHAR(100) NOT NULL,
    [gender] CHAR(1),
    [weight_kg] DECIMAL,
    [is_neutered] BIT NOT NULL,
    [is_active] BIT NOT NULL,
    [owner_id] INT NOT NULL,
    [owner_name] NVARCHAR(101) NOT NULL,
    [owner_phone] VARCHAR(20) NOT NULL,
    [primary_vet_id] INT,
    [primary_vet_name] NVARCHAR(101)
);
GO

INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (1, N'มะหมา', N'สุนัข', N'พุดเดิ้ล', N'F', '2.80', True, False, 1, N'อรุณ สว่างศรี', N'0812345001', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (2, N'แมวเหมียว', N'แมว', N'อเมริกัน ชอร์ตแฮร์', N'F', '3.50', True, True, 1, N'อรุณ สว่างศรี', N'0812345001', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (3, N'บัตเตอร์', N'สุนัข', N'โกลเดน รีทรีฟเวอร์', N'M', '32.40', True, True, 2, N'นภาพร ทองดี', N'0823456002', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (4, N'มิลค์', N'แมว', N'เปอร์เซีย', N'F', '4.10', False, True, 2, N'นภาพร ทองดี', N'0823456002', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (5, N'ร็อคกี้', N'สุนัข', N'ไซบีเรียน ฮัสกี้', N'M', '22.70', False, True, 3, N'วรพล มีโชค', N'0834567003', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (6, N'ดาว', N'แมว', N'วิเชียรมาศ', N'F', '3.80', True, True, 4, N'สุภาพร จันทร์งาม', N'0845678004', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (7, N'จุ๊บแจง', N'สุนัข', N'มอลทีส', N'F', '2.10', False, True, 4, N'สุภาพร จันทร์งาม', N'0845678004', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (8, N'โอโซน', N'สุนัข', N'บอร์เดอร์ คอลลี่', N'M', '18.50', True, True, 5, N'ธนกร วงศ์ใหญ่', N'0856789005', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (9, N'ปุ๊กกี้', N'สุนัข', N'ปอมเมอเรเนียน', N'M', '3.20', True, True, 6, N'พิมพ์ใจ ศิริวัฒน์', N'0867890006', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (10, N'ลูกปลา', N'กระต่าย', N'ฮอลแลนด์ ลop', N'F', '1.50', False, True, 7, N'กิตติพงษ์ แก้วใส', N'0878901007', NULL, NULL);
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (12, N'วานิลา', N'แมว', N'สกอตติช โฟลด์', N'F', '3.80', False, True, 2, N'นภาพร ทองดี', N'0823456002', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (14, N'ทองเอก', N'สุนัข', N'พันธุ์ผสม', N'M', '25.50', False, True, 1, N'อรุณ สว่างศรี', N'0812345001', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (16, N'โบ็ท', N'เต่า', N'ไม่ระบุ', N'U', NULL, False, True, 8, N'อาลีฟ สาและ', N'0843649134', NULL, NULL);
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (17, N'อะม็อก', N'หนูแฮมสเตอร์', N'ไม่ระบุ', N'M', '0.15', False, True, 8, N'อาลีฟ สาและ', N'0843649134', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (18, N'ไอดำ', N'แมว', N'ไม่ระบุ', N'U', NULL, False, True, 9, N'ลำยอง รวยเฮง', N'0882669997', NULL, NULL);
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (20, N'test3', N'กระต่าย', N'ไม่ระบุ', N'U', NULL, False, True, 10, N'test teset', N'9090039394', NULL, NULL);
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (21, N'ลักกีั', N'กระต่าย', N'ไม่ระบุ', N'U', NULL, False, True, 1, N'อรุณ สว่างศรี', N'0812345001', NULL, NULL);
INSERT INTO dbo.VW_PET_FULL ([pet_id], [pet_name], [species], [breed], [gender], [weight_kg], [is_neutered], [is_active], [owner_id], [owner_name], [owner_phone], [primary_vet_id], [primary_vet_name]) VALUES (22, N'ดำ', N'สุนัข', N'ไทย บางแก้ว', N'U', NULL, False, True, 11, N'อรกาน ปรมะ', N'0967062081', NULL, NULL);
GO

-- ==========================================
-- Table: VW_UPCOMING_APPOINTMENTS
-- ==========================================

IF OBJECT_ID('dbo.VW_UPCOMING_APPOINTMENTS', 'U') IS NOT NULL DROP TABLE dbo.VW_UPCOMING_APPOINTMENTS;
CREATE TABLE dbo.VW_UPCOMING_APPOINTMENTS (
    [appt_id] INT NOT NULL,
    [appt_datetime] DATETIME NOT NULL,
    [reason] NVARCHAR(200),
    [notes] NVARCHAR(MAX),
    [pet_id] INT NOT NULL,
    [pet_name] NVARCHAR(50) NOT NULL,
    [pet_gender] CHAR(1),
    [owner_id] INT NOT NULL,
    [owner_name] NVARCHAR(101) NOT NULL,
    [vet_id] INT,
    [vet_name] NVARCHAR(101)
);
GO

INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (1, '2026-02-28 22:23:54.617000', N'ตรวจร่างกายประจำปี + ฉีดวัคซีน', NULL, 1, N'มะหมา', N'F', 1, N'อรุณ สว่างศรี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (2, '2026-03-10 22:23:54.617000', N'ท้องเสีย อาเจียน', NULL, 3, N'บัตเตอร์', N'M', 2, N'นภาพร ทองดี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (3, '2026-03-15 22:23:54.617000', N'ขาหักจากอุบัติเหตุ', NULL, 5, N'ร็อคกี้', N'M', 3, N'วรพล มีโชค', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (4, '2026-03-20 22:23:54.617000', N'ขนร่วง ผิวหนังอักเสบ', NULL, 6, N'ดาว', N'F', 4, N'สุภาพร จันทร์งาม', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (5, '2026-03-23 22:23:54.617000', N'ตรวจสุขภาพก่อนทำหมัน', NULL, 4, N'มิลค์', N'F', 2, N'นภาพร ทองดี', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (6, '2026-03-25 22:23:54.617000', N'ไม่สบาย ซึม เบื่ออาหาร', NULL, 7, N'จุ๊บแจง', N'F', 4, N'สุภาพร จันทร์งาม', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (7, '2026-03-27 22:23:54.617000', N'ติดตามอาการหลังรักษา', NULL, 2, N'แมวเหมียว', N'F', 1, N'อรุณ สว่างศรี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (8, '2026-03-30 22:23:54.617000', N'ฉีดวัคซีนประจำปี', NULL, 8, N'โอโซน', N'M', 5, N'ธนกร วงศ์ใหญ่', 4, N'สัตวแพทย์หญิง ศิริพร เจริญสุข');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (9, '2026-04-06 22:23:54.617000', N'ติดตามผลการรักษา', NULL, 1, N'มะหมา', N'F', 1, N'อรุณ สว่างศรี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (10, '2026-04-09 22:23:54.617000', N'ฉีดวัคซีน DHPPiL บูสเตอร์', NULL, 3, N'บัตเตอร์', N'M', 2, N'นภาพร ทองดี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (11, '2026-04-13 22:23:54.617000', N'ผ่าตัดทำหมัน', NULL, 4, N'มิลค์', N'F', 2, N'นภาพร ทองดี', 3, N'สัตวแพทย์หญิง มาลินี สุขสวัสดิ์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (12, '2026-04-20 22:23:54.617000', N'ตรวจร่างกายทั่วไป', NULL, 9, N'ปุ๊กกี้', N'M', 6, N'พิมพ์ใจ ศิริวัฒน์', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (13, '2026-02-13 22:23:54.617000', N'ฉีดวัคซีน', NULL, 2, N'แมวเหมียว', N'F', 1, N'อรุณ สว่างศรี', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (14, '2026-01-29 22:23:54.617000', N'ตรวจเลือดประจำปี', NULL, 5, N'ร็อคกี้', N'M', 3, N'วรพล มีโชค', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (19, '2026-04-30 09:04:00', N'[เอกซเรย์ (2 ท่า)]', NULL, 18, N'ไอดำ', N'U', 9, N'ลำยอง รวยเฮง', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (21, '2026-04-07 10:00:00', N'[เจาะเลือด Blood Chem]', NULL, 20, N'test3', N'U', 10, N'test teset', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (23, '2026-04-23 09:00:00', N'[เจาะเลือด Blood Chem]', NULL, 21, N'ลักกีั', N'U', 1, N'อรุณ สว่างศรี', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (24, '2026-04-13 15:00:00', N'[อาบน้ำตัดขน (เล็ก)]', NULL, 22, N'ดำ', N'U', 11, N'อรกาน ปรมะ', 2, N'นายสัตวแพทย์ ปิยะ วงศ์แพทย์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (25, '2026-04-13 19:00:00', N'[อาบน้ำตัดขน (กลาง)]', NULL, 22, N'ดำ', N'U', 11, N'อรกาน ปรมะ', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
INSERT INTO dbo.VW_UPCOMING_APPOINTMENTS ([appt_id], [appt_datetime], [reason], [notes], [pet_id], [pet_name], [pet_gender], [owner_id], [owner_name], [vet_id], [vet_name]) VALUES (26, '2026-04-15 09:00:00', N'Checkup', NULL, 20, N'test3', N'U', 10, N'test teset', 1, N'นายสัตวแพทย์ ชาญชัย รักษ์สัตว์');
GO

-- ==========================================
-- Table: VW_VACCINE_DUE_SOON
-- ==========================================

IF OBJECT_ID('dbo.VW_VACCINE_DUE_SOON', 'U') IS NOT NULL DROP TABLE dbo.VW_VACCINE_DUE_SOON;
CREATE TABLE dbo.VW_VACCINE_DUE_SOON (
    [vacc_record_id] INT NOT NULL,
    [next_due_date] DATE,
    [days_until_due] INT,
    [pet_name] NVARCHAR(50) NOT NULL,
    [species] NVARCHAR(50) NOT NULL,
    [owner_name] NVARCHAR(101) NOT NULL,
    [owner_phone] VARCHAR(20) NOT NULL,
    [vaccine_name] NVARCHAR(150) NOT NULL
);
GO

INSERT INTO dbo.VW_VACCINE_DUE_SOON ([vacc_record_id], [next_due_date], [days_until_due], [pet_name], [species], [owner_name], [owner_phone], [vaccine_name]) VALUES (4, '2026-04-15', 3, N'บัตเตอร์', N'สุนัข', N'นภาพร ทองดี', N'0823456002', N'DHPPiL (5 in 1)');
INSERT INTO dbo.VW_VACCINE_DUE_SOON ([vacc_record_id], [next_due_date], [days_until_due], [pet_name], [species], [owner_name], [owner_phone], [vaccine_name]) VALUES (5, '2026-04-15', 3, N'บัตเตอร์', N'สุนัข', N'นภาพร ทองดี', N'0823456002', N'Rabies');
GO

-- ==========================================
-- Table: VW_LOW_STOCK_MEDICINE
-- ==========================================

IF OBJECT_ID('dbo.VW_LOW_STOCK_MEDICINE', 'U') IS NOT NULL DROP TABLE dbo.VW_LOW_STOCK_MEDICINE;
CREATE TABLE dbo.VW_LOW_STOCK_MEDICINE (
    [medicine_id] INT NOT NULL,
    [name] NVARCHAR(150) NOT NULL,
    [type] NVARCHAR(50),
    [unit] NVARCHAR(30) NOT NULL,
    [stock_qty] INT NOT NULL,
    [min_stock_qty] INT NOT NULL,
    [shortage_qty] INT
);
GO

SET IDENTITY_INSERT dbo.VW_LOW_STOCK_MEDICINE ON;

INSERT INTO dbo.VW_LOW_STOCK_MEDICINE ([medicine_id], [name], [type], [unit], [stock_qty], [min_stock_qty], [shortage_qty]) VALUES (11, N'ยาระงับปวด Tramadol', N'Analgesic', N'เม็ด', 13, 50, 37);
SET IDENTITY_INSERT dbo.VW_LOW_STOCK_MEDICINE OFF;

GO
