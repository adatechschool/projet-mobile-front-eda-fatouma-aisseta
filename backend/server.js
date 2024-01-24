const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const uuid = require('uuid');
const userMiddleware = require('./midlwear');
const jwt = require('jsonwebtoken');
require('dotenv').config();

app.use(express.json());

app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ message: 'Internal Server Error' });
});


// Créez une connexion à la base de données
const connection = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'admin',
  database: process.env.DB_NAME || 'horrorStory',
  password: process.env.DB_PASSWORD || 'admin',
  port: process.env.DB_PORT || 8889
});

// Connectez-vous à la base de données
connection.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données : ' + err.stack);
    return;
  }
  console.log('Connecté à la base de données avec l\'ID ' + connection.threadId);
});

// API pour l'enregistrement d'un utilisateur
app.post('/register', userMiddleware.validateRegister, async (req, res) => {
  try {
    connection.query(
      'SELECT id FROM users WHERE LOWER(email) = LOWER(?)',
      [req.body.email],
      (err, result) => {
        if (err) {
          return res.status(500).send({
            message: err,
          });
        }

        if (result && result.length) {
          // Email déjà enregistré
          return res.status(409).send({
            message: 'This email is already in use!',
          });
        } else {
          // Email disponible, procéder à l'insertion
          bcrypt.hash(req.body.password, 10, (err, hash) => {
            if (err) {
              return res.status(500).send({
                message: err,
              });
            }

            const currentDate = new Date();

            connection.query(
              'INSERT INTO users (email, password) VALUES (?, ?)',
              [req.body.email, hash],
              (err, result) => {
                if (err) {
                  return res.status(400).send({
                    message: err,
                  });
                }

                return res.status(201).send({
                  message: 'Registered!',
                });
              }
            );
          });
        }
      }
    );
  } catch (error) {
    console.error('Erreur lors de la création de l\'utilisateur :', error);
    res.status(500).json({ message: "Erreur lors de la création de l'utilisateur" });
  }
});

//API pour la connexion d'un utilisateur et une fois qu'il comparle le mdp hashé il creer un token pour la connexion
app.post('/login', async (req, res) => {
  connection.query(
    `SELECT * FROM USERS WHERE email= ?;`,
    [req.body.email],
    (err, result) => {
      if (err) {
        return res.status(400).send({
          message: err,
        });
      }
      if (!result.length) {
        return res.status(400).send({
          message: 'Username or password incorrect!',
        });
      }

      bcrypt.compare(
        req.body.password,
        result[0]['password'],
        (bErr, bResult) => {
          if (bErr) {
            return res.status(400).send({
              message: 'email or password incorrect!',
            });
          }
          if (bResult) {
            // password match
            const token = jwt.sign(
              {
                userId: result[0].id,
              },
              'secret_key',
              { expiresIn: '7d' }
            );
            console.log('Generated Token:', token);

            connection.query(`UPDATE users SET last_login = now() WHERE id = ?;`, [
              result[0].id,
            ]);

            // Maintenant, utilisez le token dans la réponse
            return res.status(200).send({
              message: 'Logged in!',
              token,
              user: result[0],
            });
          }
          return res.status(400).send({
            message: 'email or password incorrect!',
          });
        }
      );
    }
  );
});


// API pour récupérer les histoires associées à un utilisateur
app.get('/api/histoires/:id', (req, res) => {
  const userId = req.params.id;
  // Utilisez connection.query ici pour exécuter une requête SQL en utilisant la connexion MySQL
  connection.query('SELECT * FROM horroStory', function (err, recordset) {
    if (err) {
      console.log(err);
      res.status(500).json({ message: "Erreur lors de la récupération des histoires" });
    } else {
      res.status(200).json({ message: "Histoires récupérées avec succès", data: recordset });
    }
  });
});

app.listen(port, () => {
  console.log(`Le serveur Express est en cours d'écoute sur le port ${port}`);
});
