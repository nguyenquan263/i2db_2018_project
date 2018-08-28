var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM TAKINGS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/:taker_id', function (req, res) {
    db.query('SELECT * FROM TAKINGS WHERE TAKER_ID=' + req.params.taker_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.post('/', function (req, res) {
    if (req.body.taker_id && req.body.test_id) {
        var current_time = 0;
        db.query(`SELECT * FROM takings t 
                where t.taker_id = `+ req.body.taker_id + ` and t.test_id = ` + req.body.test_id + `
                ORDER BY taking_id DESC LIMIT 1`, function (err, result) {
                if (err) {
                    res.send({ error: 1, message: 'Error of database' });
                }
                else {
                    if (result.lengh > 0){
                        current_time = parseInt(result[0].TAKING_TIME.toString()) + 1;
                    } else {
                        current_time = 1;
                    }
                    db.query('INSERT INTO TAKINGS VALUE(NULL,' + req.body.taker_id + ',' + req.body.test_id + ',' + current_time + ',NULL)', function (err, result) {
                        if (err) {
                            res.send({ error: 1, message: 'Error of database', current_id: null });
                        }
                        else {
                            res.send({ error: 0, message: 'Insert Complete', current_id: result.insertId });
                        }

                    });
                }

            });



    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }




});

router.get("/zero_score/:taking_id", function (req, res) {
    var taking_id = req.params.taking_id;
    if (taking_id) {
        db.query('UPDATE TAKINGS SET TOTAL_SCORE = 0 WHERE TAKING_ID = ?', req.params.taking_id, function (err, result) {
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

router.delete('/:taking_id', function (req, res) {
    if (req.params.taking_id) {
        db.query('DELETE FROM TAKINGS WHERE TAKING_ID = ?', req.params.taking_id, function (err, result) {
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


module.exports = router;