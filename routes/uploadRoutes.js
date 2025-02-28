// routes/uploadRoutes.js
const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("node:path");
const { authenticateToken } = require("../middleware/authMiddleware");
const { uploadFileAndTranscribe } = require("../controllers/uploadController");

// Setup multer with storage configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    const timestamp = Date.now();
    cb(null, `${timestamp}.mp3`);
  }
});

const upload = multer({ storage: storage });

// POST /upload
router.post("/", authenticateToken, upload.single("file"), uploadFileAndTranscribe);

module.exports = router;