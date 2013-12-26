module.exports =
	getIndex: (req, res) ->
		res.send [{name: 'Bob Dobbs'}, {name: 'Connie Dobbs'}, {name: 'Dick Dobbs'}]
		#imap.getAll (msgs, err) ->
		#	throw err if err
		#	res.send msgs
