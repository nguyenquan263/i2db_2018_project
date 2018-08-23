var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM MAKERS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/:test_id', function (req, res) {

    db.query('SELECT * FROM MAKERS m JOIN TESTS t ON t.MAKER_ID = m.MAKER_ID WHERE t.TEST_ID ='+req.params.test_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});



module.exports = router;