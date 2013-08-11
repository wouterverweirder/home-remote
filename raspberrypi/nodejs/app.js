var express = require('express');
var app = express();
var port = 8888;

var lirc_node = require('lirc_node');
lirc_node.init();

var gpio = require("gpio");
var gpio4 = gpio.export(4, {
   direction: 'out',
   interval: 200,
   ready: function() {
   }
});

var Xbmc = require('xbmc');

var connection = new Xbmc.TCPConnection({
	host: '127.0.0.1',
	port: 9090,
	verbose: false
});
var xbmcApi = new Xbmc.XbmcApi;

xbmcApi.setConnection(connection);

xbmcApi.on('connection:data', function()  { });
xbmcApi.on('connection:open', function()  { console.log('onOpen');  });
xbmcApi.on('connection:close', function() { console.log('onClose'); });

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
	res.sendfile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/remote/:name/:key', function(req, res){
	console.log(req.params.name);
	if(req.params.name == 'xbmc') {
		xbmcApi.input.ExecuteAction(req.params.key);
	} else if(req.params.name == "belgacom" && req.params.key == "KEY_POWER") {
		gpio4.set(function(){
			setTimeout(function(){
				gpio4.set(0, function(){
				});
			}, 200);
		});
	} else {
		lirc_node.irsend.send_once(req.params.name, req.params.key, function() {
		  console.log("Sent Command", req.params.name, req.params.key);
		});
	}
	res.json({result: 'ok'});
});

app.listen(port);
console.log("Listening on port", port);