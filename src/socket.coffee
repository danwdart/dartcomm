io = require 'socket.io'
xmpp = require './lib/server/xmpp'

module.exports = (server)->
	io = io.listen(server)
	console.log 'Socket started'
	io.sockets.on 'connection', (socket) ->
		socket.emit 'message', {hello: 'world'}
		# xmpp socket

