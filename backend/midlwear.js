// middleware/users.js

const jwt = require("jsonwebtoken");

module.exports = {
  validateRegister: (req, res, next) => {
    // username min length 3
    if (!req.body.email || req.body.email.length < 3) {
      return res.status(400).send({
        message: 'Please enter a username with min. 3 chars',
      });
    }
    // password min 6 chars
    if (!req.body.password || req.body.password.length < 6) {
      return res.status(400).send({
        message: 'Please enter a password with min. 6 chars',
      });
    }
    next();
  },

  isLoggedIn: (req, res, next) => {
    if (!req.headers.authorization) {
      return res.status(400).send({
        message: 'Your session is not valid!',
      });
    }
    try {
      const authHeader = req.headers.authorization;
      const token = authHeader.split(' ')[1];
      const decoded = jwt.verify(token, 'secret_key');
      req.userData = decoded;
      next();
    } catch (err) {
      return res.status(400).send({
        message: 'Your session is not valid!',
      });
    }
  }
};
