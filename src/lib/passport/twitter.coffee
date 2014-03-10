passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy

passport.use(new TwitterStrategy({
		consumerKey: 'a'
		consumerSecret: 'b'
		callbackURL: 'http://localhost:3000/auth/twitter/callback'
	},
	(token, tokenSecret, profile, done) ->
		return done null, 1
))

passport.serializeUser (user, done)->
 	done null, user

passport.deserializeUser (user, done) ->
  	done null, user

module.exports = (app) ->
	app.use passport.initialize()
	app.use passport.session()
	app.get '/auth/twitter', passport.authenticate('twitter')

	app.get '/auth/twitter/callback', passport.authenticate('twitter',
		successRedirect: '/settings'
		failureRedirect: '/login'
	)