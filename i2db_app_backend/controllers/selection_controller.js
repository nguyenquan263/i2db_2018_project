var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.get('/', function (req, res) {

    db.query('SELECT * FROM SELECTIONS', function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.get('/:taking_id', function (req, res) {

    db.query('SELECT * FROM SELECTIONS WHERE TAKING_ID=' + req.params.taking_id, function (err, result) {
        if (err) {
            res.send({ error: 1, message: 'Error of database' });
        }
        else {
            res.send({ error: 0, message: 'Your query excecuted completely', data: result });
        }

    });

});

router.post('/', function (req, res) {
    var answer_string = "" + req.body.answers;
    answer_string = answer_string.substring(0, answer_string.length - 1);
    var taking_id = req.body.taking_id;

    if (answer_string !== "") {
        var answer_array = answer_string.split("&");

        var sql = "";

        for (var i = 0; i < answer_array.length; i++) {
            sql += "INSERT INTO SELECTIONS VALUE(NULL," + answer_array[i] + "," + taking_id + ");";
        }

        var sql_array = sql.substring(0, sql.length - 1).split(";");

        db.query(sql, function (err, result) {
            if (err) {
                res.send({ error: 1, message: err});
            }
            else {
                res.send({ error: 0, message: 'Insert Complete'});
            }

        });
        


    } else {
        res.send({ error: 5, message: "Taker did not choose any answer" });
    }
});




module.exports = router;