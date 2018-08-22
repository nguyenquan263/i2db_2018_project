var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.post('/', function (req, res) {

    var username = req.body.username;
    var password = req.body.password;

    if (username && password) {
        db.query("SELECT * FROM TAKERS WHERE USERNAME LIKE '" + username + "' AND PASSWORD LIKE '" + password+"'", function (err, result) {
            if (err) {
                res.send(err);
            }
            else {
                if (result.length > 0){
                    console.log(result);
                    res.send({ error: 0, message: 'Log-in sucessfully', taker_id: result[0].TAKER_ID });
                } else {
                    res.send({ error: 4, message: 'Log-in fail', taker_id: null });
                }
            }
        });
    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }


});

module.exports = router;