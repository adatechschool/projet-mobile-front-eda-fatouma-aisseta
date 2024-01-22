const express= require('express');
const port = 3000;
const app = express();
app.use(express.json());
app.listen(port, () => {
    console.log(`Le serveur Express est en cours d'écoute sur le port ${port}`);
  });