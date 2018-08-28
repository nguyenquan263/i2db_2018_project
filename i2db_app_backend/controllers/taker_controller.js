var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');
var pwec = require('../password_encryptor/password');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM TAKERS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});





module.exports = router;