const express= require('express');
const port = 3000;
const app = express();
app.use(express.json());

const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'horrorStory',
    password: 'password',
    port: 5432, // Par défaut, le port PostgreSQL est 5432
});

// Test de la connexion
pool.query('SELECT NOW()', (err, res) => {
    if (err) {
        console.error('Erreur de connexion à la base de données', err);
    } else {
        console.log('Connexion à la base de données établie');
    }
});

// Utilisez 'pool' pour effectuer des opérations sur la base de données



app.post('inscription', (req,res)=>{

})
app.post('connexion', (req,res)=>{

// logique pour se connecter faire l'authentification et faire la logique pour que les histoire soit lier a son utlisiteur faire une relation
})

app.get('api/histoires', (req,res)=>{
    //logique pour récuperer les histoires et associer une histoire à un utlisateur

})

// app.get('api/savehistoires', (req,res)=>{
//     //logique pour sauvegarder les histoires

// })
app.listen(port, () => {
    console.log(`Le serveur Express est en cours d'écoute sur le port ${port}`);
  });