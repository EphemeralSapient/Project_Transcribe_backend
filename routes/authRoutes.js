// routes/authRoutes.js
const express = require("express");
const router = express.Router();
const { login, getMe } = require("../controllers/authController");
const { authenticateToken } = require("../middleware/authMiddleware");

// /auth/login
router.post("/login", login);

// /auth/me
router.get("/me", authenticateToken, getMe);

module.exports = router;
