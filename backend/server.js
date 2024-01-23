const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql');
const jwt= require('jsonwebtoken');

app.use(express.json());

// Créez une connexion à la base de données
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'admin',
  database: 'horrorStory',
  password: 'admin',
  port: 8889
});

// Connectez-vous à la base de données
connection.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données : ' + err.stack);
    return;
  }

  console.log('Connecté à la base de données avec l\'ID ' + connection.threadId);

  // Effectuez une requête
  connection.query('SELECT * FROM USERS ', function(err, rows, fields) {
    if (err) throw err;
    console.log('La solution est : ', rows[0].email);
  });
});

// API pour l'enregistrement d'un utilisateur
app.post('/register', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validation des données d'entrée
    if (!email || !password) {
      return res.status(400).json({ message: "Veuillez fournir des informations correctes" });
    }

    if (password.length < 5) {
      return res.status(400).json({ message: "Le mot de passe doit contenir au moins 5 caractères" });
    }
      // Logique pour enregistrer l'utilisateur dans la base de données

    connection.query('INSERT INTO USERS (email, password) VALUES (?, ?)', [email, password], function(err, result) {
      if (err) {
        console.error('Erreur lors de l\'insertion de l\'utilisateur :', err);
        return res.status(500).json({ message: "Erreur lors de l'insertion de l'utilisateur" });
      }

     

      // Réponse réussie
      res.status(200).json({ message: "Utilisateur enregistré avec succès" });
    });

  } catch (error) {
    console.error('Erreur lors de la création de l\'utilisateur :', error);
    res.status(500).json({ message: "Erreur lors de la création de l'utilisateur" });
  }
});

// API pour la connexion d'un utilisateur
app.post('/connexion', (req, res) => {
  try {
    const { email, password } = req.body;

    // Validation des données d'entrée
    if (!email || !password) {
      return res.status(400).json({ message: "Veuillez fournir des informations correctes" });
    }

    // Logique pour l'authentification de l'utilisateur
    // ...

    // Réponse réussie
    res.status(200).json({ message: "Connexion réussie" });
  } catch (error) {
    console.error("General error:", error);
    return res.status(500).json({ message: "Erreur du serveur" });
  }
});

// API pour récupérer les histoires associées à un utilisateur
app.get('/api/histoires/:id', (req, res) => {
  const userId = req.params.id;
  sql.connect(sqlConfig, function() {
    const request = new sql.Request();
    request.query('select * from STORY', function(err, recordset) {
        if(err) console.log(err);
        res.end(JSON.stringify(recordset)); // Result in JSON format
    });
});


  // Logique pour récupérer les histoires associées à l'utilisateur avec l'ID userId
  // ...

  // Réponse réussie
  res.status(200).json({ message: "Histoires récupérées avec succès" });
});

app.listen(port, () => {
  console.log(`Le serveur Express est en cours d'écoute sur le port ${port}`);
});
