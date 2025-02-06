-- complete_schema.sql

-- OPTIONAL: Switch to your DB (PostgreSQL syntax)
-- \c testing_project;

------------------------------------------------------------
-- 1. DROP EXISTING OBJECTS (Clean Slate)
------------------------------------------------------------
DROP TABLE IF EXISTS stock_transactions CASCADE;
DROP TABLE IF EXISTS stock_batches CASCADE;
DROP TABLE IF EXISTS stock_items CASCADE;
DROP TABLE IF EXISTS medical_analysis CASCADE;
DROP TABLE IF EXISTS transcription_summaries CASCADE;
DROP TABLE IF EXISTS extras CASCADE;
DROP TABLE IF EXISTS surgeries CASCADE;
DROP TABLE IF EXISTS admissions CASCADE;
DROP TABLE IF EXISTS vaccinations CASCADE;
DROP TABLE IF EXISTS medical_history CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TYPE IF EXISTS user_role;

------------------------------------------------------------
-- 2. Create ENUM for user roles
------------------------------------------------------------
CREATE TYPE user_role AS ENUM (
  'doctor',
  'patient',
  'pharmacist',
  'receptionist'
);

------------------------------------------------------------
-- 3. Create USERS TABLE
--    Stores all users: doctors, patients, pharmacists, etc.
------------------------------------------------------------
CREATE TABLE users (
    user_id        SERIAL PRIMARY KEY,
    username       VARCHAR(50) NOT NULL UNIQUE,
    password_hash  VARCHAR(255) NOT NULL,
    role           user_role NOT NULL,
    name           VARCHAR(100),
    profile_pic    VARCHAR(255),
    created_at     TIMESTAMP DEFAULT NOW(),
    updated_at     TIMESTAMP DEFAULT NOW()
);

------------------------------------------------------------
-- 4. Create PATIENTS TABLE
--    One-to-one with users (role='patient').
------------------------------------------------------------
CREATE TABLE patients (
    user_id       INT PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    age           INT,
    gender        VARCHAR(10),
    blood_type    VARCHAR(5),
    contact_phone VARCHAR(20),
    address       TEXT,
    created_at    TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_patient_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 5. Create DOCTORS TABLE
--    One-to-one with users (role='doctor').
------------------------------------------------------------
CREATE TABLE doctors (
    user_id          INT PRIMARY KEY,
    specialty        VARCHAR(100),
    experience_years INT,
    contact_phone    VARCHAR(20),
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_doctor_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 6. Create APPOINTMENTS TABLE
------------------------------------------------------------
CREATE TABLE appointments (
    appointment_id   SERIAL PRIMARY KEY,
    doctor_id        INT NOT NULL,
    patient_id       INT NOT NULL,
    appointment_time TIMESTAMP NOT NULL,
    reason           TEXT,
    status           VARCHAR(20) DEFAULT 'scheduled',
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 7. Create MEDICAL_HISTORY TABLE
------------------------------------------------------------
CREATE TABLE medical_history (
    history_id                SERIAL PRIMARY KEY,
    patient_id                INT NOT NULL,
    last_visit                DATE,
    diagnosis                 TEXT,
    medications               TEXT,
    allergies                 TEXT,
    family_history            TEXT,
    lifestyle_recommendations TEXT,
    created_at                TIMESTAMP DEFAULT NOW(),
    updated_at                TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_history_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(user_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 8. Create VACCINATIONS TABLE
------------------------------------------------------------
CREATE TABLE vaccinations (
    vaccination_id   SERIAL PRIMARY KEY,
    patient_id       INT NOT NULL,
    appointment_id   INT,  -- optional link to a specific appointment
    vaccine_name     VARCHAR(100) NOT NULL,
    date_administered DATE,
    dose            VARCHAR(20),
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_vaccination_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_vaccination_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 9. Create ADMISSIONS TABLE
------------------------------------------------------------
CREATE TABLE admissions (
    admission_id   SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    appointment_id INT,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    reason         TEXT,
    bed_number     VARCHAR(10),
    created_at     TIMESTAMP DEFAULT NOW(),
    updated_at     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_admission_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_admission_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 10. Create SURGERIES TABLE
------------------------------------------------------------
CREATE TABLE surgeries (
    surgery_id     SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    appointment_id INT,
    surgery_name   VARCHAR(100) NOT NULL,
    surgery_date   DATE NOT NULL,
    notes          TEXT,
    created_at     TIMESTAMP DEFAULT NOW(),
    updated_at     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_surgery_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_surgery_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 11. Create EXTRAS TABLE
------------------------------------------------------------
CREATE TABLE extras (
    extra_id       SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    appointment_id INT,
    title          VARCHAR(100) NOT NULL,
    notes          TEXT,
    created_at     TIMESTAMP DEFAULT NOW(),
    updated_at     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_extra_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_extra_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 12. Create TRANSCRIPTION_SUMMARIES TABLE
------------------------------------------------------------
CREATE TABLE transcription_summaries (
    summary_id                SERIAL PRIMARY KEY,
    appointment_id            INT NOT NULL,
    diagnosis                 TEXT,
    symptoms                  TEXT,
    medications_prescribed    TEXT,
    tests_ordered             TEXT,
    follow_up_instructions    TEXT,
    allergies                 TEXT,
    family_history            TEXT,
    lifestyle_recommendations TEXT,
    created_at                TIMESTAMP DEFAULT NOW(),
    updated_at                TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_transcript_summary_appt
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 13. Create MEDICAL_ANALYSIS TABLE
------------------------------------------------------------
CREATE TABLE medical_analysis (
    analysis_id     SERIAL PRIMARY KEY,
    summary_id      INT NOT NULL,
    test_type       VARCHAR(100) NOT NULL,
    test_date       DATE,
    results         TEXT,
    remarks         TEXT,
    created_at      TIMESTAMP DEFAULT NOW(),
    updated_at      TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_analysis_summary
        FOREIGN KEY (summary_id)
        REFERENCES transcription_summaries(summary_id)
        ON DELETE CASCADE
);

------------------------------------------------------------
-- 14. Create STOCK_ITEMS TABLE
--    Enhanced with brand, manufacturer, reorder_level, etc.
------------------------------------------------------------
CREATE TABLE stock_items (
    item_id         SERIAL PRIMARY KEY,
    item_name       VARCHAR(100) NOT NULL,   -- e.g. "Ibuprofen"
    brand_name      VARCHAR(100),           -- e.g. "Advil"
    manufacturer    VARCHAR(100),           -- e.g. "Pfizer"
    description     TEXT,
    reorder_level   INT DEFAULT 0,          -- if quantity < reorder_level => restock
    created_at      TIMESTAMP DEFAULT NOW(),
    updated_at      TIMESTAMP DEFAULT NOW()
);

------------------------------------------------------------
-- 15. Create STOCK_BATCHES TABLE
--    Multiple batches/lots per item, each with its own expiry & quantity.
------------------------------------------------------------
CREATE TABLE stock_batches (
    batch_id      SERIAL PRIMARY KEY,
    item_id       INT NOT NULL,
    batch_number  VARCHAR(50),      -- e.g. "BATCH1234"
    expiry_date   DATE,            -- e.g. "2025-12-31"
    quantity      INT DEFAULT 0,    -- how many units in this batch
    updated_by    INT,             -- pharmacist user_id
    created_at    TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_stock_batch_item
        FOREIGN KEY (item_id)
        REFERENCES stock_items(item_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_stock_batch_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(user_id)
        ON DELETE SET NULL
);

------------------------------------------------------------
-- 16. Create STOCK_TRANSACTIONS TABLE
--    Logs changes to each batch, reference 'pharmacist' in changed_by.
------------------------------------------------------------
CREATE TABLE stock_transactions (
    transaction_id   SERIAL PRIMARY KEY,
    batch_id         INT NOT NULL,         -- references the exact batch
    changed_by       INT NOT NULL,         -- user_id (pharmacist)
    transaction_type VARCHAR(20) NOT NULL, -- e.g. 'IN', 'OUT', 'ADJUST'
    change_amount    INT NOT NULL,         -- positive (stock in) or negative (stock out)
    notes            TEXT,
    created_at       TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_stock_batch
        FOREIGN KEY (batch_id)
        REFERENCES stock_batches(batch_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_changed_by
        FOREIGN KEY (changed_by)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);
