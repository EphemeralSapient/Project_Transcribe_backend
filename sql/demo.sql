---------------------------------------------------------------------
-- INSERT SAMPLE DATA (at least 20 records per table)
-- Note: In these examples we assume:
--   - Patients: users 120
--   - Doctors: users 2140
--   - Pharmacists: users 4160
--   - Receptionists: users 6180
-- This lets us clearly link foreign keys.
---------------------------------------------------------------------

------------------------------------------------------------
-- A. INSERT USERS (80 rows total)
------------------------------------------------------------

-- 20 Patient users (user_id 1 to 20)
INSERT INTO users (username, password_hash, role, name) VALUES
('patient1', 'pass1hash', 'patient', 'Arun Kumar'),
('patient2', 'pass2hash', 'patient', 'Bala Reddy'),
('patient3', 'pass3hash', 'patient', 'Chitra Devi'),
('patient4', 'pass4hash', 'patient', 'Deva Kumar'),
('patient5', 'pass5hash', 'patient', 'Eashwar Menon'),
('patient6', 'pass6hash', 'patient', 'Ganesh Iyer'),
('patient7', 'pass7hash', 'patient', 'Harini Ramesh'),
('patient8', 'pass8hash', 'patient', 'Indra Subramanian'),
('patient9', 'pass9hash', 'patient', 'Jaya Lakshmi'),
('patient10', 'pass10hash', 'patient', 'Kumar Raj'),
('patient11', 'pass11hash', 'patient', 'Lakshmi Narayanan'),
('patient12', 'pass12hash', 'patient', 'Mani Sundaram'),
('patient13', 'pass13hash', 'patient', 'Nandhini Krishnan'),
('patient14', 'pass14hash', 'patient', 'Omkar Prabhakaran'),
('patient15', 'pass15hash', 'patient', 'Prakash Vel'),
('patient16', 'pass16hash', 'patient', 'Rajesh Kumar'),
('patient17', 'pass17hash', 'patient', 'Sundar Venkatesh'),
('patient18', 'pass18hash', 'patient', 'Thirumalai Murugan'),
('patient19', 'pass19hash', 'patient', 'Uma Maheswari'),
('patient20', 'pass20hash', 'patient', 'Vijayalakshmi Rao');

-- 20 Doctor users (user_id 21 to 40)
INSERT INTO users (username, password_hash, role, name) VALUES
('doctor1', 'docpass1hash', 'doctor', 'Dr. Karthik'),
('doctor2', 'docpass2hash', 'doctor', 'Dr. Meena'),
('doctor3', 'docpass3hash', 'doctor', 'Dr. Arvind'),
('doctor4', 'docpass4hash', 'doctor', 'Dr. Suresh'),
('doctor5', 'docpass5hash', 'doctor', 'Dr. Lakshmi'),
('doctor6', 'docpass6hash', 'doctor', 'Dr. Ramesh'),
('doctor7', 'docpass7hash', 'doctor', 'Dr. Priya'),
('doctor8', 'docpass8hash', 'doctor', 'Dr. Vijay'),
('doctor9', 'docpass9hash', 'doctor', 'Dr. Raji'),
('doctor10', 'docpass10hash', 'doctor', 'Dr. Selvam'),
('doctor11', 'docpass11hash', 'doctor', 'Dr. Kannan'),
('doctor12', 'docpass12hash', 'doctor', 'Dr. Divya'),
('doctor13', 'docpass13hash', 'doctor', 'Dr. Murugan'),
('doctor14', 'docpass14hash', 'doctor', 'Dr. Shankar'),
('doctor15', 'docpass15hash', 'doctor', 'Dr. Geetha'),
('doctor16', 'docpass16hash', 'doctor', 'Dr. Anand'),
('doctor17', 'docpass17hash', 'doctor', 'Dr. Nirmala'),
('doctor18', 'docpass18hash', 'doctor', 'Dr. Kumar'),
('doctor19', 'docpass19hash', 'doctor', 'Dr. Rupa'),
('doctor20', 'docpass20hash', 'doctor', 'Dr. Vinoth');

-- 20 Pharmacist users (user_id 41 to 60)
INSERT INTO users (username, password_hash, role, name) VALUES
('pharmacist1', 'pharmpass1hash', 'pharmacist', 'Pharma Ramesh'),
('pharmacist2', 'pharmpass2hash', 'pharmacist', 'Pharma Suresh'),
('pharmacist3', 'pharmpass3hash', 'pharmacist', 'Pharma Kumar'),
('pharmacist4', 'pharmpass4hash', 'pharmacist', 'Pharma Ravi'),
('pharmacist5', 'pharmpass5hash', 'pharmacist', 'Pharma Ganesh'),
('pharmacist6', 'pharmpass6hash', 'pharmacist', 'Pharma Mani'),
('pharmacist7', 'pharmpass7hash', 'pharmacist', 'Pharma Lakshmi'),
('pharmacist8', 'pharmpass8hash', 'pharmacist', 'Pharma Priya'),
('pharmacist9', 'pharmpass9hash', 'pharmacist', 'Pharma Divya'),
('pharmacist10', 'pharmpass10hash', 'pharmacist', 'Pharma Sita'),
('pharmacist11', 'pharmpass11hash', 'pharmacist', 'Pharma Meena'),
('pharmacist12', 'pharmpass12hash', 'pharmacist', 'Pharma Raji'),
('pharmacist13', 'pharmpass13hash', 'pharmacist', 'Pharma Selva'),
('pharmacist14', 'pharmpass14hash', 'pharmacist', 'Pharma Kumaraswamy'),
('pharmacist15', 'pharmpass15hash', 'pharmacist', 'Pharma Chandran'),
('pharmacist16', 'pharmpass16hash', 'pharmacist', 'Pharma Suresh'),
('pharmacist17', 'pharmpass17hash', 'pharmacist', 'Pharma Dinesh'),
('pharmacist18', 'pharmpass18hash', 'pharmacist', 'Pharma Balaji'),
('pharmacist19', 'pharmpass19hash', 'pharmacist', 'Pharma Jagan'),
('pharmacist20', 'pharmpass20hash', 'pharmacist', 'Pharma Vijay');

-- 20 Receptionist users (user_id 61 to 80)
INSERT INTO users (username, password_hash, role, name) VALUES
('receptionist1', 'receppass1hash', 'receptionist', 'Reception Divya'),
('receptionist2', 'receppass2hash', 'receptionist', 'Reception Nandini'),
('receptionist3', 'receppass3hash', 'receptionist', 'Reception Anitha'),
('receptionist4', 'receppass4hash', 'receptionist', 'Reception Priya'),
('receptionist5', 'receppass5hash', 'receptionist', 'Reception Kavya'),
('receptionist6', 'receppass6hash', 'receptionist', 'Reception Meena'),
('receptionist7', 'receppass7hash', 'receptionist', 'Reception Swathi'),
('receptionist8', 'receppass8hash', 'receptionist', 'Reception Saranya'),
('receptionist9', 'receppass9hash', 'receptionist', 'Reception Latha'),
('receptionist10', 'receppass10hash', 'receptionist', 'Reception Geetha'),
('receptionist11', 'receppass11hash', 'receptionist', 'Reception Sangeetha'),
('receptionist12', 'receppass12hash', 'receptionist', 'Reception Deepa'),
('receptionist13', 'receppass13hash', 'receptionist', 'Reception Malathi'),
('receptionist14', 'receppass14hash', 'receptionist', 'Reception Uma'),
('receptionist15', 'receppass15hash', 'receptionist', 'Reception Radha'),
('receptionist16', 'receppass16hash', 'receptionist', 'Reception Nithya'),
('receptionist17', 'receppass17hash', 'receptionist', 'Reception Priyanka'),
('receptionist18', 'receppass18hash', 'receptionist', 'Reception Vijayalakshmi'),
('receptionist19', 'receppass19hash', 'receptionist', 'Reception Saroja'),
('receptionist20', 'receppass20hash', 'receptionist', 'Reception Ranjitha');

------------------------------------------------------------
-- B. INSERT PATIENT DETAILS (20 rows)
-- Assumes patients correspond to user_id 1 to 20.
------------------------------------------------------------
INSERT INTO patients (user_id, first_name, last_name, age, gender, blood_type, contact_phone, address)
VALUES
(1, 'Arun', 'Kumar', 30, 'Male', 'O+', '9876543210', 'Chennai, Tamil Nadu'),
(2, 'Bala', 'Reddy', 28, 'Male', 'A+', '9876543211', 'Coimbatore, Tamil Nadu'),
(3, 'Chitra', 'Devi', 32, 'Female', 'B+', '9876543212', 'Madurai, Tamil Nadu'),
(4, 'Deva', 'Kumar', 45, 'Male', 'AB+', '9876543213', 'Tiruchirappalli, Tamil Nadu'),
(5, 'Eashwar', 'Menon', 40, 'Male', 'O-', '9876543214', 'Salem, Tamil Nadu'),
(6, 'Ganesh', 'Iyer', 35, 'Male', 'A-', '9876543215', 'Tirunelveli, Tamil Nadu'),
(7, 'Harini', 'Ramesh', 29, 'Female', 'B-', '9876543216', 'Erode, Tamil Nadu'),
(8, 'Indra', 'Subramanian', 50, 'Male', 'AB-', '9876543217', 'Vellore, Tamil Nadu'),
(9, 'Jaya', 'Lakshmi', 22, 'Female', 'O+', '9876543218', 'Thoothukudi, Tamil Nadu'),
(10, 'Kumar', 'Raj', 33, 'Male', 'A+', '9876543219', 'Tiruppur, Tamil Nadu'),
(11, 'Lakshmi', 'Narayanan', 27, 'Female', 'B+', '9876543220', 'Nagercoil, Tamil Nadu'),
(12, 'Mani', 'Sundaram', 38, 'Male', 'AB+', '9876543221', 'Dindigul, Tamil Nadu'),
(13, 'Nandhini', 'Krishnan', 31, 'Female', 'O-', '9876543222', 'Kanchipuram, Tamil Nadu'),
(14, 'Omkar', 'Prabhakaran', 29, 'Male', 'A-', '9876543223', 'Tirunelveli, Tamil Nadu'),
(15, 'Prakash', 'Vel', 36, 'Male', 'B-', '9876543224', 'Theni, Tamil Nadu'),
(16, 'Rajesh', 'Kumar', 42, 'Male', 'AB-', '9876543225', 'Puducherry, Tamil Nadu'),
(17, 'Sundar', 'Venkatesh', 34, 'Male', 'O+', '9876543226', 'Vellore, Tamil Nadu'),
(18, 'Thirumalai', 'Murugan', 39, 'Male', 'A+', '9876543227', 'Chennai, Tamil Nadu'),
(19, 'Uma', 'Maheswari', 26, 'Female', 'B+', '9876543228', 'Madurai, Tamil Nadu'),
(20, 'Vijayalakshmi', 'Rao', 30, 'Female', 'O-', '9876543229', 'Coimbatore, Tamil Nadu');

------------------------------------------------------------
-- C. INSERT DOCTOR DETAILS (20 rows)
-- Assumes doctors correspond to user_id 21 to 40.
------------------------------------------------------------
INSERT INTO doctors (user_id, specialty, experience_years, contact_phone)
VALUES
(21, 'Cardiology', 10, '9123456781'),
(22, 'Neurology', 8, '9123456782'),
(23, 'Orthopedics', 12, '9123456783'),
(24, 'General Surgery', 15, '9123456784'),
(25, 'Pediatrics', 7, '9123456785'),
(26, 'Dermatology', 9, '9123456786'),
(27, 'Ophthalmology', 11, '9123456787'),
(28, 'Gynecology', 13, '9123456788'),
(29, 'Urology', 10, '9123456789'),
(30, 'Psychiatry', 8, '9123456790'),
(31, 'Cardiology', 14, '9123456791'),
(32, 'Neurology', 6, '9123456792'),
(33, 'Orthopedics', 16, '9123456793'),
(34, 'General Medicine', 9, '9123456794'),
(35, 'Pediatrics', 7, '9123456795'),
(36, 'Dermatology', 10, '9123456796'),
(37, 'Ophthalmology', 8, '9123456797'),
(38, 'Gynecology', 11, '9123456798'),
(39, 'Urology', 12, '9123456799'),
(40, 'General Surgery', 15, '9123456800');

------------------------------------------------------------
-- D. INSERT APPOINTMENTS (20 rows)
------------------------------------------------------------
INSERT INTO appointments (doctor_id, patient_id, appointment_time, reason)
VALUES
(21, 2, '2025-02-21 09:00:00', 'Regular Checkup'),
(21, 2, '2025-02-22 10:00:00', 'Headache'),
(23, 3, '2025-01-03 11:00:00', 'Fracture follow-up'),
(24, 4, '2025-01-04 12:00:00', 'Surgery Consultation'),
(25, 5, '2025-01-05 09:30:00', 'Pediatric Checkup'),
(26, 6, '2025-01-06 10:30:00', 'Skin Rash'),
(27, 7, '2025-01-07 11:30:00', 'Eye Checkup'),
(28, 8, '2025-01-08 12:30:00', 'Women Health'),
(29, 9, '2025-01-09 09:15:00', 'Kidney Stone'),
(30, 10, '2025-01-10 10:15:00', 'Mental Health'),
(31, 11, '2025-01-11 11:15:00', 'Cardiology'),
(32, 12, '2025-01-12 12:15:00', 'Neurology'),
(33, 13, '2025-01-13 09:45:00', 'Orthopedics'),
(34, 14, '2025-01-14 10:45:00', 'General Medicine'),
(35, 15, '2025-01-15 11:45:00', 'Pediatrics'),
(36, 16, '2025-01-16 12:45:00', 'Dermatology'),
(37, 17, '2025-01-17 09:30:00', 'Ophthalmology'),
(38, 18, '2025-01-18 10:30:00', 'Gynecology'),
(39, 19, '2025-01-19 11:30:00', 'Urology'),
(40, 20, '2025-01-20 12:30:00', 'General Surgery');

------------------------------------------------------------
-- E. INSERT MEDICAL_HISTORY (20 rows)
------------------------------------------------------------
INSERT INTO medical_history (patient_id, last_visit, diagnosis, medications, allergies, family_history, lifestyle_recommendations)
VALUES
(2, '2024-12-01', 'Hypertension', 'Amlodipine', 'None', 'Father had hypertension', 'Low salt diet'),
(2, '2024-11-15', 'Diabetes', 'Metformin', 'Penicillin', 'Mother diabetic', 'Regular exercise'),
(3, '2024-10-10', 'Asthma', 'Inhaler', 'Dust', 'No history', 'Avoid allergens'),
(4, '2024-09-05', 'Arthritis', 'Ibuprofen', 'None', 'Grandfather had arthritis', 'Light exercise'),
(5, '2024-08-20', 'Migraine', 'Sumatriptan', 'None', 'No history', 'Regular sleep'),
(6, '2024-07-15', 'Allergy', 'Antihistamine', 'Pollen', 'No history', 'Avoid pollen'),
(7, '2024-06-10', 'Anemia', 'Iron supplements', 'None', 'Family history of anemia', 'Iron rich diet'),
(8, '2024-05-05', 'Thyroid', 'Levothyroxine', 'None', 'Mother had thyroid issues', 'Regular checkup'),
(9, '2024-04-01', 'Flu', 'Oseltamivir', 'None', 'No history', 'Rest and fluids'),
(10, '2024-03-20', 'Back Pain', 'Paracetamol', 'None', 'No history', 'Physiotherapy'),
(11, '2024-02-15', 'Hypertension', 'Amlodipine', 'None', 'Father had hypertension', 'Low salt diet'),
(12, '2024-01-10', 'Diabetes', 'Metformin', 'None', 'Mother diabetic', 'Regular exercise'),
(13, '2023-12-05', 'Asthma', 'Inhaler', 'Dust', 'No history', 'Avoid allergens'),
(14, '2023-11-01', 'Arthritis', 'Ibuprofen', 'None', 'Grandfather had arthritis', 'Light exercise'),
(15, '2023-10-20', 'Migraine', 'Sumatriptan', 'None', 'No history', 'Regular sleep'),
(16, '2023-09-15', 'Allergy', 'Antihistamine', 'Pollen', 'No history', 'Avoid pollen'),
(17, '2023-08-10', 'Anemia', 'Iron supplements', 'None', 'Family history of anemia', 'Iron rich diet'),
(18, '2023-07-05', 'Thyroid', 'Levothyroxine', 'None', 'Mother had thyroid issues', 'Regular checkup'),
(19, '2023-06-01', 'Flu', 'Oseltamivir', 'None', 'No history', 'Rest and fluids'),
(20, '2023-05-20', 'Back Pain', 'Paracetamol', 'None', 'No history', 'Physiotherapy');

------------------------------------------------------------
-- F. INSERT VACCINATIONS (20 rows; linking each to an appointment)
------------------------------------------------------------
INSERT INTO vaccinations (patient_id, appointment_id, vaccine_name, date_administered, dose)
VALUES
(2, 1, 'COVID-19 Vaccine', '2025-01-01', '1st Dose'),
(2, 1, 'COVID-19 Vaccine', '2025-01-02', '2nd Dose'),
(3, 3, 'COVID-19 Vaccine', '2025-01-03', '1st Dose'),
(4, 4, 'COVID-19 Vaccine', '2025-01-04', '1st Dose'),
(5, 5, 'COVID-19 Vaccine', '2025-01-05', '1st Dose'),
(6, 6, 'COVID-19 Vaccine', '2025-01-06', '1st Dose'),
(7, 7, 'COVID-19 Vaccine', '2025-01-07', '1st Dose'),
(8, 8, 'COVID-19 Vaccine', '2025-01-08', '1st Dose'),
(9, 9, 'COVID-19 Vaccine', '2025-01-09', '1st Dose'),
(10, 10, 'COVID-19 Vaccine', '2025-01-10', '1st Dose'),
(11, 11, 'COVID-19 Vaccine', '2025-01-11', '1st Dose'),
(12, 12, 'COVID-19 Vaccine', '2025-01-12', '1st Dose'),
(13, 13, 'COVID-19 Vaccine', '2025-01-13', '1st Dose'),
(14, 14, 'COVID-19 Vaccine', '2025-01-14', '1st Dose'),
(15, 15, 'COVID-19 Vaccine', '2025-01-15', '1st Dose'),
(16, 16, 'COVID-19 Vaccine', '2025-01-16', '1st Dose'),
(17, 17, 'COVID-19 Vaccine', '2025-01-17', '1st Dose'),
(18, 18, 'COVID-19 Vaccine', '2025-01-18', '1st Dose'),
(19, 19, 'COVID-19 Vaccine', '2025-01-19', '1st Dose'),
(20, 20, 'COVID-19 Vaccine', '2025-01-20', '1st Dose');

------------------------------------------------------------
-- G. INSERT ADMISSIONS (20 rows)
------------------------------------------------------------
INSERT INTO admissions (patient_id, appointment_id, admission_date, discharge_date, reason, bed_number)
VALUES
(2, 1, '2025-01-01', '2025-01-03', 'Cardiac observation', 'B101'),
(5, 2, '2025-01-02', '2025-01-04', 'Diabetes management', 'B102'),
(3, 3, '2025-01-03', '2025-01-05', 'Respiratory infection', 'B103'),
(4, 4, '2025-01-04', '2025-01-06', 'Post surgery recovery', 'B104'),
(5, 5, '2025-01-05', '2025-01-07', 'Fever management', 'B105'),
(6, 6, '2025-01-06', '2025-01-08', 'Observation', 'B106'),
(7, 7, '2025-01-07', '2025-01-09', 'Asthma attack', 'B107'),
(8, 8, '2025-01-08', '2025-01-10', 'Thyroid monitoring', 'B108'),
(9, 9, '2025-01-09', '2025-01-11', 'Flu complications', 'B109'),
(10, 10, '2025-01-10', '2025-01-12', 'Back pain treatment', 'B110'),
(11, 11, '2025-01-11', '2025-01-13', 'Cardiac monitoring', 'B111'),
(12, 12, '2025-01-12', '2025-01-14', 'Neurological observation', 'B112'),
(13, 13, '2025-01-13', '2025-01-15', 'Orthopedic assessment', 'B113'),
(14, 14, '2025-01-14', '2025-01-16', 'General surgery recovery', 'B114'),
(15, 15, '2025-01-15', '2025-01-17', 'Pediatric care', 'B115'),
(16, 16, '2025-01-16', '2025-01-18', 'Dermatological observation', 'B116'),
(17, 17, '2025-01-17', '2025-01-19', 'Eye checkup', 'B117'),
(18, 18, '2025-01-18', '2025-01-20', 'Gynecology observation', 'B118'),
(19, 19, '2025-01-19', '2025-01-21', 'Urological assessment', 'B119'),
(20, 20, '2025-01-20', '2025-01-22', 'Surgical recovery', 'B120');

------------------------------------------------------------
-- H. INSERT SURGERIES (20 rows)
------------------------------------------------------------
INSERT INTO surgeries (patient_id, appointment_id, surgery_name, surgery_date, notes)
VALUES
(2, 1, 'Bypass Surgery', '2025-01-02', 'Successful'),
(5, 2, 'Appendectomy', '2025-01-03', 'No complications'),
(3, 3, 'Knee Replacement', '2025-01-04', 'Improved mobility'),
(4, 4, 'Hip Replacement', '2025-01-05', 'Recovery ongoing'),
(5, 5, 'Gallbladder Removal', '2025-01-06', 'Successful'),
(6, 6, 'Hernia Repair', '2025-01-07', 'No issues'),
(7, 7, 'Cataract Surgery', '2025-01-08', 'Vision improved'),
(8, 8, 'Cesarean Section', '2025-01-09', 'Mother and child stable'),
(9, 9, 'Tonsillectomy', '2025-01-10', 'Smooth procedure'),
(10, 10, 'Vasectomy', '2025-01-11', 'Elective'),
(11, 11, 'Laparoscopy', '2025-01-12', 'No complications'),
(12, 12, 'Spinal Surgery', '2025-01-13', 'Critical procedure'),
(13, 13, 'Breast Surgery', '2025-01-14', 'Successful'),
(14, 14, 'Thyroid Surgery', '2025-01-15', 'Post-op recovery'),
(15, 15, 'Colon Surgery', '2025-01-16', 'Improvement expected'),
(16, 16, 'Stomach Surgery', '2025-01-17', 'Stable condition'),
(17, 17, 'Liver Transplant', '2025-01-18', 'On hold'),
(18, 18, 'Kidney Stone Removal', '2025-01-19', 'Successful'),
(19, 19, 'C-Section', '2025-01-20', 'Smooth procedure'),
(20, 20, 'Heart Valve Repair', '2025-01-21', 'Critical but stable');

------------------------------------------------------------
-- I. INSERT EXTRAS (20 rows)
------------------------------------------------------------
INSERT INTO extras (patient_id, appointment_id, title, notes)
VALUES
(5, 1, 'X-Ray Report', 'Clear'),
(2, 2, 'MRI Report', 'Minor issues'),
(3, 3, 'Blood Test', 'Normal'),
(4, 4, 'Ultrasound', 'Abnormalities found'),
(5, 5, 'ECG', 'Normal'),
(6, 6, 'CT Scan', 'Requires review'),
(7, 7, 'Urine Test', 'Normal'),
(8, 8, 'Allergy Test', 'Mild reaction'),
(9, 9, 'Vision Test', 'Slight impairment'),
(10, 10, 'Hearing Test', 'Normal'),
(11, 11, 'Stress Test', 'Above average'),
(12, 12, 'Cholesterol Test', 'High levels'),
(13, 13, 'Blood Pressure', 'Slightly high'),
(14, 14, 'Respiratory Test', 'Normal'),
(15, 15, 'Skin Test', 'Normal'),
(16, 16, 'ECG', 'Minor irregularities'),
(17, 17, 'X-Ray', 'Normal'),
(18, 18, 'MRI', 'Normal'),
(19, 19, 'CT Scan', 'Review needed'),
(20, 20, 'Blood Test', 'Normal');

------------------------------------------------------------
-- J. INSERT TRANSCRIPTION_SUMMARIES (20 rows)
------------------------------------------------------------
INSERT INTO transcription_summaries (appointment_id, diagnosis, symptoms, medications_prescribed, tests_ordered, follow_up_instructions, allergies, family_history, lifestyle_recommendations)
VALUES
(1, 'Hypertension', 'High BP', 'Amlodipine', 'Blood Test', 'Regular checkup', 'None', 'Father had hypertension', 'Low salt diet'),
(2, 'Diabetes', 'High sugar', 'Metformin', 'Blood Sugar Test', 'Diet control', 'Penicillin', 'Mother diabetic', 'Regular exercise'),
(3, 'Asthma', 'Shortness of breath', 'Inhaler', 'Lung Function Test', 'Avoid triggers', 'Dust', 'No history', 'Avoid allergens'),
(4, 'Arthritis', 'Joint pain', 'Ibuprofen', 'X-Ray', 'Physiotherapy', 'None', 'Family history', 'Light exercise'),
(5, 'Migraine', 'Headache', 'Sumatriptan', 'MRI', 'Regular sleep', 'None', 'No history', 'Regular sleep'),
(6, 'Allergy', 'Sneezing', 'Antihistamine', 'Allergy Test', 'Avoid allergens', 'Pollen', 'No history', 'Avoid pollen'),
(7, 'Anemia', 'Fatigue', 'Iron supplements', 'Blood Test', 'Iron rich diet', 'None', 'Family history', 'Dietary changes'),
(8, 'Thyroid', 'Weight changes', 'Levothyroxine', 'Thyroid Test', 'Regular monitoring', 'None', 'Family history', 'Balanced diet'),
(9, 'Flu', 'Fever', 'Oseltamivir', 'Flu Test', 'Rest', 'None', 'No history', 'Hydration'),
(10, 'Back Pain', 'Chronic pain', 'Paracetamol', 'X-Ray', 'Physiotherapy', 'None', 'No history', 'Regular exercise'),
(11, 'Hypertension', 'High BP', 'Amlodipine', 'Blood Test', 'Regular checkup', 'None', 'Father had hypertension', 'Low salt diet'),
(12, 'Diabetes', 'High sugar', 'Metformin', 'Blood Sugar Test', 'Diet control', 'None', 'Mother diabetic', 'Regular exercise'),
(13, 'Asthma', 'Shortness of breath', 'Inhaler', 'Lung Function Test', 'Avoid triggers', 'Dust', 'No history', 'Avoid allergens'),
(14, 'Arthritis', 'Joint pain', 'Ibuprofen', 'X-Ray', 'Physiotherapy', 'None', 'Family history', 'Light exercise'),
(15, 'Migraine', 'Headache', 'Sumatriptan', 'MRI', 'Regular sleep', 'None', 'No history', 'Regular sleep'),
(16, 'Allergy', 'Sneezing', 'Antihistamine', 'Allergy Test', 'Avoid allergens', 'Pollen', 'No history', 'Avoid pollen'),
(17, 'Anemia', 'Fatigue', 'Iron supplements', 'Blood Test', 'Iron rich diet', 'None', 'Family history', 'Dietary changes'),
(18, 'Thyroid', 'Weight changes', 'Levothyroxine', 'Thyroid Test', 'Regular monitoring', 'None', 'Family history', 'Balanced diet'),
(19, 'Flu', 'Fever', 'Oseltamivir', 'Flu Test', 'Rest', 'None', 'No history', 'Hydration'),
(20, 'Back Pain', 'Chronic pain', 'Paracetamol', 'X-Ray', 'Physiotherapy', 'None', 'No history', 'Regular exercise');

------------------------------------------------------------
-- K. INSERT MEDICAL_ANALYSIS (20 rows; linked to transcription summaries 120)
------------------------------------------------------------
INSERT INTO medical_analysis (summary_id, test_type, test_date, results, remarks)
VALUES
(1, 'Blood Pressure Test', '2025-01-02', '140/90', 'Monitor regularly'),
(2, 'Blood Sugar Test', '2025-01-03', '180 mg/dL', 'Diet modification needed'),
(3, 'Lung Function Test', '2025-01-04', 'Normal', 'No action required'),
(4, 'X-Ray', '2025-01-05', 'Joint space narrowing', 'Physiotherapy advised'),
(5, 'MRI', '2025-01-06', 'Normal', 'Follow up in 6 months'),
(6, 'Allergy Test', '2025-01-07', 'Positive for pollen', 'Avoid exposure'),
(7, 'Blood Test', '2025-01-08', 'Low hemoglobin', 'Supplement iron'),
(8, 'Thyroid Test', '2025-01-09', 'High TSH', 'Adjust medication'),
(9, 'Flu Test', '2025-01-10', 'Positive', 'Antiviral recommended'),
(10, 'X-Ray', '2025-01-11', 'Minor disc issues', 'Physiotherapy advised'),
(11, 'Blood Pressure Test', '2025-01-12', '138/88', 'Monitor regularly'),
(12, 'Blood Sugar Test', '2025-01-13', '170 mg/dL', 'Diet modification needed'),
(13, 'Lung Function Test', '2025-01-14', 'Normal', 'No action required'),
(14, 'X-Ray', '2025-01-15', 'Mild arthritis', 'Physiotherapy advised'),
(15, 'MRI', '2025-01-16', 'Normal', 'Follow up in 6 months'),
(16, 'Allergy Test', '2025-01-17', 'Positive for pollen', 'Avoid exposure'),
(17, 'Blood Test', '2025-01-18', 'Low hemoglobin', 'Supplement iron'),
(18, 'Thyroid Test', '2025-01-19', 'Normal', 'Continue medication'),
(19, 'Flu Test', '2025-01-20', 'Negative', 'No action required'),
(20, 'X-Ray', '2025-01-21', 'Minor disc bulge', 'Monitor and physiotherapy');

------------------------------------------------------------
-- L. INSERT STOCK_ITEMS (20 rows; updated_by uses pharmacist IDs 4160)
------------------------------------------------------------
INSERT INTO stock_items (item_name, description, quantity, updated_by)
VALUES
('Paracetamol', 'Pain reliever', 100, 41),
('Ibuprofen', 'Anti-inflammatory', 150, 42),
('Amlodipine', 'Blood pressure medicine', 80, 43),
('Metformin', 'Diabetes medicine', 120, 44),
('Inhaler', 'Asthma relief', 50, 45),
('Antihistamine', 'Allergy relief', 90, 46),
('Levothyroxine', 'Thyroid hormone', 70, 47),
('Oseltamivir', 'Antiviral', 60, 48),
('Sumatriptan', 'Migraine relief', 40, 49),
('Iron supplements', 'For anemia', 200, 50),
('Vitamin D', 'Supplement', 180, 41),
('Calcium', 'Supplement', 160, 42),
('Cough Syrup', 'Cold and cough', 110, 43),
('Antibiotic', 'Infection treatment', 130, 44),
('Bandages', 'Wound care', 300, 45),
('Syringes', 'Medical equipment', 250, 46),
('Gloves', 'Protective wear', 500, 47),
('Face Masks', 'Protective wear', 400, 48),
('Saline Solution', 'IV fluid', 90, 49),
('Antacid', 'Stomach relief', 75, 50);

------------------------------------------------------------
-- M. INSERT STOCK_TRANSACTIONS (20 rows; changed_by uses pharmacist IDs 4160)
------------------------------------------------------------
INSERT INTO stock_transactions (item_id, changed_by, change_amount, notes)
VALUES
(1, 41, 50, 'Restocked'),
(2, 42, -10, 'Sold'),
(3, 43, 20, 'Restocked'),
(4, 44, -5, 'Sold'),
(5, 45, 30, 'Restocked'),
(6, 46, -15, 'Sold'),
(7, 47, 25, 'Restocked'),
(8, 48, -10, 'Sold'),
(9, 49, 10, 'Restocked'),
(10, 50, -20, 'Sold'),
(11, 41, 40, 'Restocked'),
(12, 42, -10, 'Sold'),
(13, 43, 30, 'Restocked'),
(14, 44, -5, 'Sold'),
(15, 45, 50, 'Restocked'),
(16, 46, -10, 'Sold'),
(17, 47, 60, 'Restocked'),
(18, 48, -15, 'Sold'),
(19, 49, 20, 'Restocked'),
(20, 50, -5, 'Sold');
