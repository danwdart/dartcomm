passport = require 'passport'
FacebookStrategy = require('passport-facebook').Strategy

passport.use(new FacebookStrategy({
		clientID: '214280932094320'
		clientSecret: 'a086b80096152cdd5dfab50ee2803279'
		callbackURL: 'http://localhost:3000/auth/facebook/callback'
	},
	(accessToken, refreshToken, profile, done) ->
		return done null,
			profile: profile
			accessToken: accessToken
			refreshToken: refreshToken
))

passport.serializeUser (user, done)->
 	done null, user

passport.deserializeUser (user, done) ->
  	done null, user

module.exports = (app) ->
	app.use passport.initialize()
	app.use passport.session()
	app.get '/auth/facebook', passport.authenticate('facebook',
		scope: [
			'read_stream'
			'publish_actions'
		]
	)
	app.get '/auth/facebook/callback', passport.authenticate('facebook',
		successRedirect: '/settings'
		failureRedirect: '/login'
	)