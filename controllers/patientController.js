// controllers/patientController.js

const patientModel = require("../models/patientModel");
const pool = require("../config/db"); 

exports.getPatientDetails = async (req, res) => {
  try {
    const patientId = req.params.patient_id;
    const patient = await patientModel.getPatientDetails(patientId);
    if (!patient) {
      return res.status(404).json({ error: "Patient not found" });
    }
    return res.status(200).json(patient);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.updatePatientDetails = async (req, res) => {
  try {
    const patientId = req.params.patient_id;

    // We only allow 1 field at a time in the sample
    const keys = Object.keys(req.body);
    if (keys.length !== 1) {
      return res.status(400).json({ error: "Provide a single field update" });
    }

    const key = keys[0].toLowerCase();
    const value = req.body[keys[0]];

    const allowedKeys = ["first_name", "last_name", "age", "gender", "blood_type", "contact_phone", "address"];
    if (!allowedKeys.includes(key)) {
      return res.status(400).json({ error: "Invalid field" });
    }

    // Update
    await patientModel.updatePatientField(patientId, key, value);
    return res.status(200).json({ message: "Patient details updated" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.getPatientHistory = async (req, res) => {
  try {
    const patientId = req.params.patient_id;
    const query = `SELECT * FROM medical_history WHERE patient_id = $1;`;
    const result = await pool.query(query, [patientId]);
    return res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.updatePatientHistory = async (req, res) => {
  try {
    const patientId = req.params.patient_id;

    const keys = Object.keys(req.body);
    if (keys.length !== 1) {
      return res.status(400).json({ error: "Provide a single field update" });
    }

    const key = keys[0].toLowerCase();
    const value = req.body[keys[0]];

    const allowedKeys = [
      "diagnosis", "symptoms", "medications_prescribed", "tests_ordered",
      "follow_up_instructions", "allergies", "family_history", "lifestyle_recommendations"
    ];
    if (!allowedKeys.includes(key)) {
      return res.status(400).json({ error: "Invalid field" });
    }

    const query = `UPDATE medical_history SET ${key} = $1 WHERE patient_id = $2`;
    await pool.query(query, [value, patientId]);
    return res.status(200).json({ message: "Patient history updated" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};
