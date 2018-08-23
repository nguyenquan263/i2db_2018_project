var express = require('express');
var body_parser = require('body-parser');
var multer = require('multer');

var app = express();

app.use('/images', express.static(__dirname+'/images'));

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
    next();
});

app.use(body_parser.json());
app.use(body_parser.urlencoded({extended: true}));

app.use('/contest', require('./controllers/contest_controller'));
app.use('/login', require('./controllers/login_controller'));
app.use('/test', require('./controllers/test_controller'));
app.use('/question', require('./controllers/question_controller'));
app.use('/answer', require('./controllers/answer_controller'));
app.use('/taking', require('./controllers/taking_controller'));
app.use('/selection', require('./controllers/selection_controller'));
app.use('/maker', require('./controllers/maker_controller'));



var server = app.listen(1607, function () {
    var host = server.address().address;
    var port = server.address().port;

    console.log('Server is running on http://%s:%s', host, port);

});