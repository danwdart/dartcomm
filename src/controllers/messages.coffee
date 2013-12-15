imap = require '../lib/server/imap'

module.exports =
	getIndex: (req, res) ->
		res.send [{date: 'Today', from: 'Bob Dobbs', subject: 'Frop', flags: 'I'}]
		#imap.getAll (msgs, err) ->
		#	throw err if err
		#	res.send msgs
