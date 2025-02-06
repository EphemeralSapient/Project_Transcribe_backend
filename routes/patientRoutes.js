// routes/patientRoutes.js
const express = require("express");
const router = express.Router();
const {
  getPatientDetails,
  updatePatientDetails,
  getPatientHistory,
  updatePatientHistory,
} = require("../controllers/patientController");
const { authenticateToken } = require("../middleware/authMiddleware");
const { authorizePatientDoctorReceptionist } = require("../middleware/roleMiddleware");

// /patient/{patient_id}/details 
router
  .route("/:patient_id/details")
  .get(authenticateToken, authorizePatientDoctorReceptionist, getPatientDetails)
  .put(authenticateToken, authorizePatientDoctorReceptionist, updatePatientDetails);

// /patient/{patient_id}/history
router
  .route("/:patient_id/history")
  .get(authenticateToken, authorizePatientDoctorReceptionist, getPatientHistory)
  .put(authenticateToken, authorizePatientDoctorReceptionist, updatePatientHistory);

module.exports = router;
