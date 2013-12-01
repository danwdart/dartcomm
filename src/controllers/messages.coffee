imap = require '../lib/server/imap'

module.exports =
	getIndex: (req, res) ->
		res.send []
		#imap.getAll (msgs, err) ->
		#	throw err if err
		#	res.send msgs
