var express = require('express');
var app = express();
var port = 8888;

var lirc_node = require('lirc_node');
lirc_node.init();

var gpio = require("gpio");
var gpio4 = gpio.export(4, {
   direction: 'out',
   interval: 200
});

var http = require('http');
var activePlayers = [];

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
	res.sendfile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/remote/:name/:key', function(req, res){
	res.header("Access-Control-Allow-Origin", "*");
  	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	if(req.params.name == 'xbmc') {
		if(req.params.key == 'Player.Stop' || req.params.key == 'Player.PlayPause') {
			xmbcSendToActivePlayer(req.params.key, {}, function(xmbcResult){
			});
		} else if(req.params.key == 'Player.IncreaseSpeed' || req.params.key == 'Player.DecreaseSpeed') {
			var speed = (req.params.key == 'Player.IncreaseSpeed') ? 'increment' : 'decrement';
			xmbcSendToActivePlayer('Player.SetSpeed', {speed: speed}, function(xmbcResult){
				console.log(xmbcResult);
			});
		} else {
			xmbcSend(req.params.key, {}, function(xmbcResult){
			});
		}
	} else {
		lirc_node.irsend.send_once(req.params.name, req.params.key);
	}
	res.json({result: 'ok'});
});

var getActivePlayerInterval = setInterval(function(){
	xmbcSend('Player.GetActivePlayers', {}, function(xmbcResult){
		if(xmbcResult.result) {
			activePlayers = xmbcResult.result;
		}
	});
}, 1000);

function xmbcSendToActivePlayer(method, params, callback) {
	if(activePlayers.length) {
		params.playerid = activePlayers[0].playerid;
		xmbcSend(method, params, callback);
	}
}

function xmbcSend(method, params, callback) {
	var dataString = JSON.stringify({
		id: 1,
		jsonrpc: "2.0",
		method: method,
		params: params
	});
	var options = {
	  host: '192.168.1.70',
	  port: 80,
	  path: '/jsonrpc?' + method,
	  method: 'POST',
	  headers: {
		  'Content-Type': 'application/json',
		  'Content-Length': dataString.length
		}
	};
	var xbmcReq = http.request(options, function(xbmcRes) {
		xbmcRes.setEncoding('utf-8');
		var responseString = '';
		xbmcRes.on('data', function(data) {
			responseString += data;
		});
		xbmcRes.on('end', function() {
			var resultObject = JSON.parse(responseString);
			if(callback) {
				callback(resultObject);
			}
		});
	});
	xbmcReq.on('error', function(e) {
	});
	xbmcReq.write(dataString);
	xbmcReq.end();
}

app.listen(port);
console.log("Listening on port", port);