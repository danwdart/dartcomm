User = require '../models/user'

module.exports =
	getIndex: (req, res) ->
		res.render 'login',
			flash: req.session.flash

	postIndex: (req, res) ->
		post = req.body
		User.findOne(
			_id: post.username.toString()
			password: post.password.toString()
		, (user) ->
			if !user
				req.session.flash = 'Invalid credentials.'
				return res.redirect '/login'

			req.session.user = user;
			res.redirect '/login/session'
		)

	getSession: (req, res) ->
		res.send req.session

	getRegister: (req, res) ->
		res.render 'register',
			flash: req.session.flash

	postRegister: (req, res) ->
		post = req.body

		if (7 > post.password.length)
			req.session.flash = 'Password is too short'
			return res.redirect '/login/register'

		if (post.password != post.password2)
			req.session.flash = 'Passwords did not match.'
			return res.redirect '/login/register'

		User.findById(post.username.toString(), (err, user) ->

			if user
				req.session.flash = 'Sorry - username was already taken.'
				return res.redirect '/login/register'
			
			user = new User(
				_id: post.username.toString()
				password: post.username.toString()
			)

			user.save( (err) ->
				if err
					console.log err

				req.session.user = user
				res.redirect '/'
			)
		)