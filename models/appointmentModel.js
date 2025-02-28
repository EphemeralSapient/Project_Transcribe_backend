// models/appointmentModel.js
const pool = require("../config/db");

async function getAppointmentSchedules(doctorId) {
  const query = `
  SELECT a.appointment_id as id, a.appointment_time as time, a.patient_id as patientId, 
         a.reason as reason, a.status as status, u.name as patientName
  FROM appointments a
  JOIN users u ON a.patient_id = u.user_id
  WHERE a.doctor_id = $1
    AND a.appointment_time >= NOW() 
    AND DATE(a.appointment_time) = CURRENT_DATE
    AND a.status = 'scheduled'
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
  const query = "DELETE FROM appointments WHERE appointment_id = $1 AND doctor_id = $2";
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

async function saveDiagnosis(appointmentId, patientId, doctorId, diagnosisData) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    // Check if the appointment exists and belongs to the specified doctor and patient
    const appointmentCheck = await client.query(
      `SELECT * FROM appointments 
       WHERE appointment_id = $1 
       AND doctor_id = $2 
       AND patient_id = $3`,
      [appointmentId, doctorId, patientId]
    );
    
    if (appointmentCheck.rows.length === 0) {
      throw new Error('Appointment not found or not authorized');
    }
    
    // Format the data as user-friendly strings
    const formatAsString = (data) => {
      if (!data) return '';
      if (typeof data === 'string') return data;
      
      if (Array.isArray(data)) {
        // Special handling for medications array
        if (data.length > 0 && data[0].medication) {
          return data.map(med => 
            `${med.medication} ${med.dosage || ''} ${med.frequency || ''} ${med.duration || ''}`.trim()
          ).join('; ');
        }
        // Default array handling
        return data.join(', ');
      }
      
      return String(data);
    };
    
    // Special format for medications to create a user-friendly string
    const formatMedications = (meds) => {
      if (!meds) return '';
      if (typeof meds === 'string') return meds;
      
      if (Array.isArray(meds)) {
        return meds.map(med => {
          if (typeof med === 'object') {
            const parts = [];
            if (med.medication) parts.push(med.medication);
            if (med.dosage) parts.push(med.dosage);
            if (med.frequency) parts.push(`${med.frequency}`);
            if (med.duration) parts.push(`for ${med.duration}`);
            return parts.join(' - ');
          }
          return String(med);
        }).join('; ');
      }
      
      return String(meds);
    };
    
    // Process diagnosis data into strings
    const diagnosisNotes = diagnosisData.notes || diagnosisData.diagnosis || '';
    const symptoms = formatAsString(diagnosisData.symptoms);
    const medications = formatMedications(diagnosisData.medications || diagnosisData.medications_prescribed);
    const tests = formatAsString(diagnosisData.tests || diagnosisData.tests_ordered);
    const followUp = diagnosisData.followUp || diagnosisData.follow_up_instructions || '';
    const allergies = formatAsString(diagnosisData.allergies);
    const familyHistory = formatAsString(diagnosisData.familyHistory || diagnosisData.family_history);
    const lifestyle = diagnosisData.lifestyle || diagnosisData.lifestyle_recommendations || '';
    
    // Check if a transcription summary already exists for this appointment
    const summaryCheck = await client.query(
      "SELECT * FROM transcription_summaries WHERE appointment_id = $1",
      [appointmentId]
    );
    
    let summaryId;
    
    if (summaryCheck.rows.length > 0) {
      // Update existing summary
      summaryId = summaryCheck.rows[0].summary_id;
      await client.query(
        `UPDATE transcription_summaries 
         SET diagnosis = $1, 
             symptoms = $2, 
             medications_prescribed = $3,
             follow_up_instructions = $4,
             updated_at = NOW() 
         WHERE summary_id = $5`,
        [
          diagnosisNotes,
          symptoms,
          medications,
          followUp,
          summaryId
        ]
      );
    } else {
      // Insert new summary
      const summaryResult = await client.query(
        `INSERT INTO transcription_summaries 
         (appointment_id, diagnosis, symptoms, medications_prescribed, tests_ordered, 
          follow_up_instructions, allergies, family_history, lifestyle_recommendations, created_at, updated_at) 
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW(), NOW())
         RETURNING summary_id`,
        [
          appointmentId,
          diagnosisNotes,
          symptoms,
          medications,
          tests,
          followUp,
          allergies,
          familyHistory,
          lifestyle
        ]
      );
      
      summaryId = summaryResult.rows[0].summary_id;
    }
    
    // If medical analysis data is provided, add it
    if (diagnosisData.medicalAnalysis && Array.isArray(diagnosisData.medicalAnalysis)) {
      for (const analysis of diagnosisData.medicalAnalysis) {
        await client.query(
          `INSERT INTO medical_analysis 
           (summary_id, test_type, test_date, results, remarks) 
           VALUES ($1, $2, $3, $4, $5)`,
          [
            summaryId,
            analysis.testType || analysis.test_type || '',
            analysis.testDate || analysis.test_date || new Date(),
            analysis.results || '',
            analysis.remarks || ''
          ]
        );
      }
    }
    
    // Update appointment status to completed
    await client.query(
      `UPDATE appointments SET status = 'completed' WHERE appointment_id = $1`,
      [appointmentId]
    );
    
    await client.query('COMMIT');
    return { success: true };
  } catch (error) {
    await client.query('ROLLBACK');
    console.error("Error in saveDiagnosis:", error);
    throw error;
  } finally {
    client.release();
  }
}

module.exports = {
  getAppointmentSchedules,
  createAppointment,
  deleteAppointment,
  getAppointmentHistory,
  saveDiagnosis
};


