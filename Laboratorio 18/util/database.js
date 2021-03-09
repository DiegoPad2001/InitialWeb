const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'productos',
    password: ''
});

module.exports = pool.promise();