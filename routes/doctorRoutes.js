// routes/doctorRoutes.js
const express = require("express");
const router = express.Router();

const {
  getDoctorInfo,
  getAppointmentSchedules,
  createAppointment,
  deleteAppointment,
  getAppointmentHistory,
  getSummarize,
  saveDiagnosis
} = require("../controllers/doctorController");
const { authenticateToken } = require("../middleware/authMiddleware");
const { authorizeRole } = require("../middleware/roleMiddleware");

// /doctor/info
router.get("/info", authenticateToken, authorizeRole("doctor"), getDoctorInfo);

// /doctor/appointment-schedules
router
  .route("/appointment-schedules")
  .get(authenticateToken, authorizeRole("doctor"), getAppointmentSchedules)
  .post(authenticateToken, authorizeRole("doctor"), createAppointment);

router.delete(
  "/appointment-schedules/:appointment_id",
  authenticateToken,
  authorizeRole("doctor"),
  deleteAppointment
);

// /doctor/appointment-history
router.get("/appointment-history", authenticateToken, authorizeRole("doctor"), getAppointmentHistory);

// /doctor/summarize
router.post("/summarize", authenticateToken, authorizeRole("doctor"), getSummarize);

// /doctor/save-diagnosis
router.post("/save-diagnosis", authenticateToken, authorizeRole("doctor"), saveDiagnosis);

module.exports = router;
