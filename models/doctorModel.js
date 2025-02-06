// models/doctorModel.js
const pool = require("../config/db");

async function getDoctorDetailsByUserId(userId) {
  const queryDoctor = `
    SELECT specialty, experience_years, contact_phone 
    FROM doctors 
    WHERE user_id = $1
  `;
  const result = await pool.query(queryDoctor, [userId]);
  return result.rows[0] || null;
}

module.exports = {
  getDoctorDetailsByUserId,
};
