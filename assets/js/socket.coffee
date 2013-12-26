socket = io.connect 'http://localhost:3000'
socket.on 'message', (data) ->
	console.log data
	socket.emit 'message', {hi: 'there'}
socket.on 'xmppmessage', (data) ->
	alert data.from + ' said: ' + data.message