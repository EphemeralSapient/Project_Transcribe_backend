// controllers/doctorController.js

const appointmentModel = require("../models/appointmentModel");
const doctorModel = require("../models/doctorModel");

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
    const page = parseInt(req.query.page || 1);
    const limit = parseInt(req.query.limit || 10);
    const offset = (page - 1) * limit;

    const history = await appointmentModel.getAppointmentHistory(userId, limit, offset);
    return res.status(200).json({ history });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};
