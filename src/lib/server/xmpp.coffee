require 'node-xmpp'

module.exports = (socket) ->	
	client = new xmpp.Client(
		jid: 'dandart@gmail.com'
		password: 'my password'
		server: 'talk.google.com'
		port: 5222
	)
	client.on 'online', ->
		socket.on 'xmppmessage', (data)->
			chat = new xmpp.Element 'message',
				to: data.to
				type: 'chat'
			.c 'body'
			.t data.message
			client.send chat
		console.log 'online'
		client.send new xmpp.Element 'presence'
		client.on 'stanza', (stanza) ->
			if stanza.attrs.type is 'error'
				return console.log stanza.toString() + 'xmpp error message'
			else if stanza.is 'message'
				if stanza.attrs.type is 'chat'
					if stanza.getChild('composing')
						return console.log stanza.attrs.from + ' is writing'
					if stanza.getChild('paused')
						return console.log stanza.attrs.from + ' has paused'
					if stanza.getChild('inactive')
						return console.log stanza.attrs.from + ' is idle'
					body = stanza.getChild('body')
					if !body
						console.log stanza.toString()
						return
					console.log stanza.attrs.from + ' said: ' + body.getText()
					return socket.emit 'xmppmessage',
						from: stanza.attrs.from
						message: body.getText()

				console.log stanza.attrs.type+ ' is my type'
				return
			else if stanza.is 'chat'
				console.log 'tis a chat'
				return console.log stanza.attrs
			else if stanza.is 'presence'
				return console.log stanza.attrs.from + ' is online'
			else if stanza.attrs.type is 'get'
				return console.log "Somebody set us up the bomb."
			else
				return console.log 'unknown type: '+stanza.attrs.type + stanza.toString()		
			#msg = new xmpp.Element 'message', 
			#	to: stanza.from
			#	type: 'chat'
			#.c('body')
			#.t('Hello there.')
			#client.send msg

		client.on 'error', (err) ->
			console.log err

