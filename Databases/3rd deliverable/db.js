const mysql = require('mysql2/promise');
require('dotenv').config();

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,  
  port: process.env.DB_PORT,
});

//Check if the database connected successfully
db.getConnection()
  .then(() => {
    console.log('Database connected successfully!');
  })
  .catch((err) => {
    console.error('Error connecting to the database:', err.message);
    process.exit(1); // Exit the process if the connection fails
  });

module.exports = db;