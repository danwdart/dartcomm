passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy

passport.use(new TwitterStrategy({
		consumerKey: 'o8UyiBth83UKXxZHV0QePA'
		consumerSecret: 'qiePiTAUvvm54y2A13nRCrPp3gPrzQ1EIA34UplQ2g'
		callbackURL: 'http://localhost:3000/auth/twitter/callback'
	},
	(token, tokenSecret, profile, done) ->
		return done null,
			profile
			token
			tokenSecret
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


