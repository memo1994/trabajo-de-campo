const mysql = require('mysql');
const { promisify }= require('util');

const { database } = require('./keys');

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('La conexión con la DB se cerró.');
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('Database has to many connections');
    }
    if (err.code === 'ECONNREFUSED') {
      console.error('Conexión a la BD rechazada');
    }
  }

  if (connection) connection.release();
  console.log('BD conectada');

  return;
});

// Promisify Pool Querys
pool.query = promisify(pool.query);

module.exports = pool;
