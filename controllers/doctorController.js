// controllers/doctorController.js

const appointmentModel = require("../models/appointmentModel");
const doctorModel = require("../models/doctorModel");
const { summarizeTranscript } = require("../utils/summarization");

exports.getDoctorInfo = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const doctorDetails = await doctorModel.getDoctorDetailsByUserId(userId);
    if (!doctorDetails) {
      return res.status(404).json({ error: "Doctor details not found" });
    }

    return res.status(200).json({
      specialty: doctorDetails.specialty,
      experience: doctorDetails.experience_years,
      phone: doctorDetails.contact_phone,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.getAppointmentSchedules = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const schedules = await appointmentModel.getAppointmentSchedules(userId);
    return res.status(200).json({ schedules });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.createAppointment = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { patientId, time, reason } = req.body;

    await appointmentModel.createAppointment(userId, patientId, time, reason);
    return res.status(200).json({ message: "Appointment scheduled" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

exports.deleteAppointment = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const appointmentId = req.params.appointment_id;

    await appointmentModel.deleteAppointment(appointmentId, userId);
    return res.status(200).json({ message: "Appointment deleted" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

// Using pagination with query i.e. ?page=1&limit=10
exports.getAppointmentHistory = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const page = Number.parseInt(req.query.page || 1);
    const limit = Number.parseInt(req.query.limit || 10);
    const offset = (page - 1) * limit;

    const history = await appointmentModel.getAppointmentHistory(userId, limit, offset);
    return res.status(200).json({ history });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

// Summarize the doctor transcribed notes
exports.getSummarize = async (req, res) => {
  try {
    // Check if transcript exists and what type it is
    if (!req.body.transcript) {
      return res.status(400).json({ error: "No transcript provided" });
    }
    
    // Summarize the notes
    const notes = req.body.transcript;

    console.log("Reg Body : ", req.body);
    console.log("Summarizing notes:", notes);

    const summary = await summarizeTranscript(notes);
    console.log("Summary:", summary);
    return res.status(200).json({ summary });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
}

// Add this to controllers/doctorController.js

exports.saveDiagnosis = async (req, res) => {
  try {
    const doctorId = req.user.user_id;
    const { patient_id, appointment_id, diagnosis_data } = req.body;

    if (!patient_id || !appointment_id || !diagnosis_data) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    // Save the diagnosis data to the database
    await appointmentModel.saveDiagnosis(appointment_id, patient_id, doctorId, diagnosis_data);
    
    return res.status(200).json({ message: "Diagnosis saved successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};