var express   = require('express');
var config  = require('./config');
var http      = require('http');
var util      = require('util');
var path = require('path');
var async = require('async');
var colors  = require('colors');
var mongoose = require('mongoose');
var cors = require('cors');




var Schema = mongoose.Schema;
const MONGO_URL = 'mongodb://admin:admin@ds121535.mlab.com:21535/gotalkdev';



//To - do : Move all the data mongoose to differnet file.


// var test = new Schema({
// 	request: String,
// 	time: Number
// }, {
// 	collection: 'test'
// });




var users = new Schema({
		userName : String,
		userEmail : String,
		userPassword : String
	},
	{
		collection: 'users'
	});


var Model = mongoose.model('Model', users);

mongoose.connect(MONGO_URL);

console.log(('Server time: ').yellow, (new Date()).toString());
require('log-timestamp')(function() { return '[' + new Date() + '] %s' });


let app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
app.use(express.static(__dirname + '/public'));




app.post('/save/', cors(), function(req, res) {
	var data = req.body;

	var userName = null;
	var userEmail = null; 
	var userPassword = null;
	if (data.userName){
		userName = data.userName;
	}
	if (data.userEmail){
		userEmail = data.userEmail;
	}
	if (data.userPassword){
		userPassword = data.userPassword;
	}

	var saveUserData = new Model({
		'userName': userName,
		'userEmail': userEmail,
		'userPassword': userPassword
	}).save(function(err, result) {
		if (err) throw err;
		if(result) {
			res.status(200).send("Saved!");
		}
	});
	
})

app.post('/find/', cors(), function(req, res) {
	var data = req.body;
 	
 	var userEmail = "";
 	var userPwd =  "";

 	if (data.userEmail){
 		//console.log("I came: "+ data.userName)
		userEmail = data.userEmail;
	}
	if (data.userPassword){
		userPassword = data.userPassword;
	}

	console.log("Data came in : User email: "+ userEmail + " userPassword: " + userPassword);
	var responseData = 'false';
	Model.find({
		'userEmail': userEmail
	}, function(err, result) {
		if (err) throw err;
		if (result) {
			//res.json(result);
			console.log("Data found : "+ result);
			var dbPwd = "";

			if (result != ""){
				if (result[0].userPassword){
					dbPwd = result[0].userPassword;
				}
				console.log(result[0].userPassword + " dbpwd: "+dbPwd + " is = :"+ userPassword);
				//console.log(result[0].userPassword);
				if (userPassword == dbPwd){
					responseData = 'true';
					var jsonObj = {"result" : responseData};
					console.log("Sending : "+ jsonObj);
					res.json(jsonObj);
				}else {
					var jsonObj = {"result" : responseData};
					res.json(jsonObj);
					console.log("Sending : "+ jsonObj);
				}
			}else {
				var jsonObj = {"result" : responseData};
				res.json(jsonObj);
				console.log("Sending : "+ jsonObj);
			};

		} else {
			res.send(JSON.stringify({
				error : responseData
			}))
		};
	});


});


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


app.set('port', (process.env.PORT || 5000));


//MARK::::: HEROKU does not listen in any other port than 5000
app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});



// let server = http.createServer(app).listen(port, function() {
//     console.log('Express server listening on port ' + port);
// });