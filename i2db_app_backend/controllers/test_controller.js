var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM TESTS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/:contest_id', function (req, res) {

    var contest_id = req.params.contest_id;

    db.query('SELECT * FROM TESTS WHERE CONTEST_ID ='+contest_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

module.exports = router;