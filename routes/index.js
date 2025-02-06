// routes/index.js
const express = require("express");
const router = express.Router();

// Import sub-routers
const authRoutes = require("./authRoutes");
const doctorRoutes = require("./doctorRoutes");
const patientRoutes = require("./patientRoutes");
const uploadRoutes = require("./uploadRoutes");

// Use sub-routers
router.use("/auth", authRoutes);
router.use("/doctor", doctorRoutes);
router.use("/patient", patientRoutes);
router.use("/upload", uploadRoutes);

module.exports = router;
