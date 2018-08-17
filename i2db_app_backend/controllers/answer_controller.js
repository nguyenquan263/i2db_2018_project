var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM ANSWERS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/:question_id', function (req, res) {

    var question_id = req.params.question_id;

    db.query('SELECT * FROM ANSWERS WHERE QUESTION_ID ='+question_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/is_true/:question_id', function (req, res) {

    var question_id = req.params.question_id;

    db.query('SELECT * FROM ANSWERS WHERE IS_TRUE = 1 AND QUESTION_ID ='+question_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

module.exports = router;