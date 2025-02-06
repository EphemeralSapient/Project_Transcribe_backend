// models/appointmentModel.js
const pool = require("../config/db");

async function getAppointmentSchedules(doctorId) {
  const query = `
    SELECT a.appointment_id as id, a.appointment_time as time, a.patient_id as patientId, 
           a.reason as reason, a.status as status, u.name as patientName
    FROM appointments a
    JOIN users u ON a.patient_id = u.user_id
    WHERE a.doctor_id = $1
      AND a.appointment_time > NOW()
    ORDER BY a.appointment_time ASC
  `;
  const result = await pool.query(query, [doctorId]);
  return result.rows;
}

async function createAppointment(doctorId, patientId, time, reason) {
  const query = `
    INSERT INTO appointments (doctor_id, patient_id, appointment_time, reason, status)
    VALUES ($1, $2, $3, $4, 'scheduled')
  `;
  await pool.query(query, [doctorId, patientId, time, reason]);
}

async function deleteAppointment(appointmentId, doctorId) {
  const query = `DELETE FROM appointments WHERE appointment_id = $1 AND doctor_id = $2`;
  await pool.query(query, [appointmentId, doctorId]);
}

async function getAppointmentHistory(doctorId, limit, offset) {
  // This is that large query that joins admissions, vaccinations, etc.
  const queryHistory = `
    SELECT 
      a.doctor_id,
      u.name AS patient_name,
      a.patient_id,
      a.appointment_time,
      a.reason,
      a.status,
      COALESCE(vaccines.vaccinations, '[]'::json) AS vaccinations,
      COALESCE(admissions.admissions, '[]'::json) AS admissions,
      COALESCE(surgeries.surgeries, '[]'::json) AS surgeries,
      COALESCE(extras.extras, '[]'::json) AS extras,
      COALESCE(ts.summary, '{}'::json) AS transcription_summary
    FROM appointments a
    LEFT JOIN users u ON a.patient_id = u.user_id
    LEFT JOIN LATERAL (
        SELECT json_agg(
                 json_build_object(
                   'vaccination_id', v.vaccination_id,
                   'vaccine_name', v.vaccine_name,
                   'date_administered', v.date_administered,
                   'dose', v.dose
                 )
               ) AS vaccinations
        FROM vaccinations v
        WHERE v.appointment_id = a.appointment_id
    ) vaccines ON true
    LEFT JOIN LATERAL (
        SELECT json_agg(
                 json_build_object(
                   'admission_id', ad.admission_id,
                   'admission_date', ad.admission_date,
                   'discharge_date', ad.discharge_date,
                   'reason', ad.reason,
                   'bed_number', ad.bed_number
                 )
               ) AS admissions
        FROM admissions ad
        WHERE ad.appointment_id = a.appointment_id
    ) admissions ON true
    LEFT JOIN LATERAL (
        SELECT json_agg(
                 json_build_object(
                   'surgery_id', s.surgery_id,
                   'surgery_name', s.surgery_name,
                   'surgery_date', s.surgery_date,
                   'notes', s.notes
                 )
               ) AS surgeries
        FROM surgeries s
        WHERE s.appointment_id = a.appointment_id
    ) surgeries ON true
    LEFT JOIN LATERAL (
        SELECT json_agg(
                 json_build_object(
                   'extra_id', e.extra_id,
                   'title', e.title,
                   'notes', e.notes
                 )
               ) AS extras
        FROM extras e
        WHERE e.appointment_id = a.appointment_id
    ) extras ON true
    LEFT JOIN LATERAL (
        SELECT json_build_object(
                 'summary_id', ts.summary_id,
                 'diagnosis', ts.diagnosis,
                 'symptoms', ts.symptoms,
                 'medications_prescribed', ts.medications_prescribed,
                 'tests_ordered', ts.tests_ordered,
                 'follow_up_instructions', ts.follow_up_instructions,
                 'allergies', ts.allergies,
                 'family_history', ts.family_history,
                 'lifestyle_recommendations', ts.lifestyle_recommendations,
                 'medical_analysis', (
                     SELECT json_agg(
                              json_build_object(
                                'analysis_id', ma.analysis_id,
                                'test_type', ma.test_type,
                                'test_date', ma.test_date,
                                'results', ma.results,
                                'remarks', ma.remarks
                              )
                            )
                     FROM medical_analysis ma
                     WHERE ma.summary_id = ts.summary_id
                 )
               ) AS summary
        FROM transcription_summaries ts
        WHERE ts.appointment_id = a.appointment_id
        LIMIT 1
    ) ts ON true
    WHERE a.doctor_id = $1
    LIMIT $2 OFFSET $3
  `;
  const result = await pool.query(queryHistory, [doctorId, limit, offset]);
  return result.rows;
}

module.exports = {
  getAppointmentSchedules,
  createAppointment,
  deleteAppointment,
  getAppointmentHistory,
};
