var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM CONTESTS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.post('/', function (req, res) {
    if (req.body.contest_name) {
        db.query('INSERT INTO CONTESTS VALUE(NULL,?,0)', req.body.contest_name, function (err, result) {
            if (err) {
                res.send({ error: 1, message: 'Error of database' });
            }
            else {
                res.send({ error: 0, message: 'Insert Complete' });
            }

        });
    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }


});

router.delete('/:contest_id', function (req, res) {
    if (req.params.contest_id) {
        db.query('DELETE FROM CONTESTS WHERE CONTEST_ID = ?', req.params.contest_id, function (err, result) {
            if (err) {
                res.send({ error: 1, message: 'Error of database' });
            }
            else {
                res.send({ error: 0, message: 'Delete Complete' });
            }

        });
    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }



});

router.put('/:contest_id', function (req, res) {
    if (req.body.contest_name && req.body.status) {
        db.query('UPDATE CONTESTS SET CONTEST_NAME = ?, STATUS = ? WHERE CONTEST_ID = ?', [req.body.contest_name, req.body.status, req.params.contest_id], function (err, result) {
            if (err) {
                res.send({ error: 1, message: 'Error of database' });
            }
            else {
                res.send({ error: 0, message: 'Update Complete' });
            }

        });
    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }


});


module.exports = router;