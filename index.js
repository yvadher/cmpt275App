var express   = require('express');
var config  = require('./config');
var http      = require('http');
var util      = require('util');
var path = require('path');
var Excel = require('exceljs');
var async = require('async');
var json = require('./convertcsv.json');
var colors  = require('colors');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;
const MONGO_URL = 'mongodb://userPublic:public@ds121535.mlab.com:21535/gotalkdev';



var test = new Schema({
	request: String,
	time: Number
}, {
	collection: 'test'
});




var Model = mongoose.model('Model', test);

mongoose.connect(MONGO_URL);

console.log(('Server time: ').yellow, (new Date()).toString());
require('log-timestamp')(function() { return '[' + new Date() + '] %s' });

let app = express();

var bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
app.use(express.static(__dirname + '/public'));




app.get('/save/:query', cors(), function(req, res) {
	var query = req.params.query;

	var savedata = new Model({
		'request': query,
		'time': Math.floor(Date.now() / 1000)
	}).save(function(err, result) {
		if (err) throw err;

		if(result) {
			res.json(result)
		}
	})
})

app.get('/find/:query', cors(), function(req, res) {
	var query = req.params.query;
 
	Model.find({
		'request': query
	}, function(err, result) {
		if (err) throw err;
		if (result) {
			res.json(result)
		} else {
			res.send(JSON.stringify({
				error : 'Error'
			}))
		}
	})
})


app.get('/api/users',function(req,res){
	res.status(200).json(users);
});

app.get('/api/config', function(req,res){
	var obj = { 'name' : 'yagnik'};
	res.status(200).json(obj);
});

app.get('*', function(req, res) {
	console.log("Sending the index.html");
    res.status(200).sendFile(path.resolve('public/index.html'));
});

let port = process.env.VCAP_APP_PORT || config.get('port');

console.log("Listening port: " + port);
let server = http.createServer(app).listen(port, function() {
    console.log('Express server listening on port ' + port);
});