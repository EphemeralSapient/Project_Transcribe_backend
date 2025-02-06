// middleware/roleMiddleware.js

function authorizeRole(...allowedRoles) {
  return (req, res, next) => {
    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({ error: "Forbidden: insufficient role" });
    }
    next();
  };
}

/**
 * This function is for checking whether the user is either:
 * - doctor
 * - or the patient themself
 * - or a receptionist
 *  Useful in certain cases.
 */
function authorizePatientDoctorReceptionist(req, res, next) {
  if (req.user.role === "doctor" || req.user.role === "patient" || req.user.role === "receptionist") {
    // If patient, check they only access their own data
    if (req.user.role === "patient" && req.params.patient_id != req.user.user_id) {
      return res.status(403).json({
        error: "Forbidden: Patient id you are requesting doesn't match with your user id",
      });
    }
    next();
  } else {
    return res.status(403).json({ error: "Forbidden: insufficient role" });
  }
}

module.exports = {
  authorizeRole,
  authorizePatientDoctorReceptionist,
};
