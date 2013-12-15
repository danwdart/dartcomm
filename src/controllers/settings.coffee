module.exports =
	getIndex: (req, res) ->
		res.render 'settings'
	getAccounts: (req, res) ->
		res.send [{type: 'Twitter'}]