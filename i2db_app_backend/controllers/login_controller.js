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
                // res.send({ error: 0, message: 'Your query excecuted completely', data: result.length });
                if (result.length > 0){
                    res.send({ error: 0, message: 'Log-in sucessfully', is_success: true });
                } else {
                    res.send({ error: 4, message: 'Log-in fail', is_success: false });
                }
            }
        });
    } else {
        res.send("hihi");
    }


});

module.exports = router;