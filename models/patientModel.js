// models/patientModel.js
const pool = require("../config/db");

async function getPatientDetails(userId) {
  const query = "SELECT * FROM patients WHERE user_id = $1";
  const result = await pool.query(query, [userId]);
  return result.rows[0] || null;
}

async function updatePatientField(userId, field, value) {
  // Expects a validated field
  const query = `UPDATE patients SET ${field} = $1 WHERE user_id = $2`;
  const result = await pool.query(query, [value, userId]);
  return result.rowCount;
}

module.exports = {
  getPatientDetails,
  updatePatientField,
};
