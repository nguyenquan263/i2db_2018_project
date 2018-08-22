var mysql = require('mysql')

var connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'i2db',
    multipleStatements: true
});

module.exports = connection;
