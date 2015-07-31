portNum = 8900
var app = require('http').createServer(function(request,response){
    console.log("adding player")
    response.writeHeader(200, {"Content-Type": "text/plain"});
    response.write("Hello World");
    response.end();
})
var io = require('socket.io')(app);

app.listen(portNum)
console.log("Server Running on " + portNum); 

function addHandlers(){	
	io.sockets.on("connection", function(socket) {
       
	   doWelcome(socket)
		
	   socket.on("clientMessage", function(message, sender) {
	        doPrintClientMessage(message, sender)
	   })
	})
}

function doWelcome(socket){
	console.log("client connected")
	socket.emit("welcome", "1", "2")	
}

function doPrintClientMessage(message, sender){
	console.log(message + " from the lovely " + sender)
}

addHandlers()