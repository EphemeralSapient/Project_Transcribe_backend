// controllers/uploadController.js
const fs = require("fs");
const { automaticSpeechRecognition } = require("../utils/transcription");
const { unlinkSync } = require("fs");

// For /upload, accessed by doctor
// TODO : Think well and come up with rate limit for who can access this endpoint
exports.uploadFileAndTranscribe = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
    }
    // Transcribe
    const text = await automaticSpeechRecognition(req.file.path);
    console.log("Transcription =>", text);

    // Clean up the file from disk
    unlinkSync(req.file.path);

    return res.status(200).json({
      message: "File uploaded and processed by Hugging Face",
      transcript: text,
    });
  } catch (error) {
    console.error("Error in uploadFileAndTranscribe:", error);
    return res.status(500).json({ error: "Transcription failed" });
  }
};
