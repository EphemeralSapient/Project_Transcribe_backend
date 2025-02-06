// models/userModel.js
const pool = require("../config/db");

async function findByUsername(username) {
  const query = `SELECT user_id, password_hash, role, name, profile_pic FROM users WHERE username = $1`;
  const result = await pool.query(query, [username]);
  return result.rows[0] || null;
}

module.exports = {
  findByUsername,
};
