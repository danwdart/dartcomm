User = require '../models/user'

module.exports =
	getIndex: (req, res) ->
		res.render 'login'

	postIndex: (req, res) ->
		post = req.body
		User.findOne(
			_id: post.username.toString()
			password: post.password.toString()
		, (err, user) ->
			throw err if err
			if user is null
				req.flash 'error', 'Invalid credentials.'
				return res.redirect '/login'

			req.session.user = user;
			res.redirect '/'
		)

	getLogout: (req, res) ->
		delete req.session.user
		res.redirect '/'

	getRegister: (req, res) ->
		res.render 'register',

	postRegister: (req, res) ->
		post = req.body

		if (7 > post.password.length)
			req.flash 'error', 'Password is too short'
			return res.redirect '/login/register'

		if (post.password != post.password2)
			req.flash 'error', 'Passwords did not match.'
			return res.redirect '/login/register'

		User.findById post.username.toString(), (err, user) ->
			throw err if err

			if user
				req.flash 'error', 'Sorry - username was already taken.'
				return res.redirect '/login/register'

			user = new User(
				_id: post.username.toString()
				password: post.password.toString()
			)

			user.save (err) ->
				if err
					console.log err

				req.session.user = user
				res.redirect '/'