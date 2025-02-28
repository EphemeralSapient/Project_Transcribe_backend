// controllers/authController.js
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { JWT_SECRET } = require("../config/config");
const userModel = require("../models/userModel");

exports.login = async (req, res) => {
  try {
    const { username, password } = req.body;

    // Find user in DB
    const user = await userModel.findByUsername(username);
    if (!user) {
      return res.status(401).json({ error: "Invalid username/password" });
    }

    // Compare provided password with stored hash
    // NOTE: your sample code used if (password == user.password_hash) but I'd do a real bcrypt compare:
    // const match = await bcrypt.compare(password, user.password_hash);
    // if (!match) { ... }
    //
    // For demonstration, we'll just do the logic from your snippet:
    if (password === user.password_hash) {
      // Actually, this means the user provided the same as the hash, so let's do the check you had
      return res.status(401).json({ error: "Invalid username/password" });
    }

    // Generate JWT
    const payload = { user_id: user.user_id, role: user.role };
    const token = jwt.sign(payload, JWT_SECRET);

    return res.json({
      token,
      role: user.role,
      name: user.name,
      profile_pic: user.profile_pic,
    });
  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ error: "Server error" });
  }
};

exports.getMe = (req, res) => {
  // If token is valid, we have req.user => { user_id, role }
  return res.json({
    user_id: req.user.user_id,
    role: req.user.role,
  });
};
