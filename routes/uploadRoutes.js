// routes/uploadRoutes.js
const express = require("express");
const router = express.Router();
const multer = require("multer");
const { authenticateToken } = require("../middleware/authMiddleware");
const { uploadFileAndTranscribe } = require("../controllers/uploadController");

// Setup multer
const upload = multer({ dest: "uploads/" });

// POST /upload
router.post("/", authenticateToken, upload.single("file"), uploadFileAndTranscribe);

module.exports = router;
