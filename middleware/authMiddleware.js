// middleware/authMiddleware.js
const jwt = require("jsonwebtoken");
const { JWT_SECRET } = require("../config/config");

function authenticateToken(req, res, next) {
  const authHeader = req.headers["authorization"]; // "Bearer <token>"
  const token = authHeader && authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ error: "No token provided" });
  }

  jwt.verify(token, JWT_SECRET, (err, userInfo) => {
    if (err) {
      return res.status(403).json({ error: "Invalid token" });
    }
    // userInfo => { user_id, role, iat, exp }
    req.user = userInfo;
    next();
  });
}

module.exports = {
  authenticateToken,
};
