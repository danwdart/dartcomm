getMessages = (callback) ->
	msgs = []
	openInbox = (cb) ->
	  imap.openBox "INBOX", true, cb
	Imap = require("imap")
	inspect = require("util").inspect
	imap = new Imap(
	  user: "dandart@gmail.com"
	  password: "whatever_my_password_is"
	  host: "imap.gmail.com"
	  port: 993
	  tls: true
	  tlsOptions:
	    rejectUnauthorized: false
	)
	imap.once "ready", ->
	  openInbox (err, box) ->
	    throw err  if err
	    f = imap.seq.fetch("1:20",
	      bodies: "HEADER.FIELDS (FROM TO SUBJECT DATE)"
	      struct: true
	    )
	    f.on "message", (msg, seqno) ->
	      prefix = "(#" + seqno + ") "
	      msg.on "body", (stream, info) ->
	        buffer = ""
	        stream.on "data", (chunk) ->
	          buffer += chunk.toString("utf8")
	        stream.once "end", ->
	          msgs.push Imap.parseHeader(buffer)
	      msg.once "attributes", (attrs) ->
	        # console.log prefix + "Attributes: %s", inspect(attrs, false, 8)
	      msg.once "end", ->
	        # console.log prefix + "Finished"
	    f.once "error", (err) ->
	      callback [], err
	    f.once "end", ->
	      console.log "Done fetching all messages!"
	      imap.end()
	imap.once "error", (err) ->
	  callback [], err
	imap.once "end", ->
	  callback msgs
	  msgs = []
	imap.connect()

module.exports =
	getAll: (callback) ->
		getMessages (data, err) ->
			if (err)
				callback([], err)
			msgs = []
			data.forEach (data) ->
				msgs.push
					date: data.date[0],
					from: data.from[0],
					subject: data.subject[0]
			callback(msgs)
