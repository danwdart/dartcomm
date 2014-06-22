express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'
http = require 'http'
serveStatic = require 'serve-static'
cookieParser = require 'cookie-parser'
session = require 'express-session'
bodyParser = require 'body-parser'
flash = require 'express-flash'

app = express()

config = require "./config"

process.env['NODE_ENV'] = 'production' if process.env['NODE_ENV'] is undefined
config.setEnvironment process.env['NODE_ENV']

if app.settings.env != 'production'
  mongoose.connect 'mongodb://localhost/dartcomm'
else
  console.log('If you are running in production, you may want to modify the mongoose connect path')

app.use assets()
app.use serveStatic(__dirname + '/../public')

app.locals.pretty = true

store = new session.MemoryStore
app.use cookieParser()
app.use session(
  secret: 'shhh'
  store: store
)
app.use flash()

app.set 'view engine', 'jade'

app.use bodyParser.urlencoded(
	extended: true
)
app.use bodyParser.json()

app.use (err, req, res, next) ->
  res.send (500, { error: err.message })

app.use (req, res, next) ->
  
  process.on 'uncaughtException', (err) ->
    console.log 'Caught exception: ' + err
    res.send 'Caught exception: ' + err
    res.statusCode = 500

  if '/login' is not req.url and !req.session.user
  	res.redirect '/login'
  else
  	res.locals.user = req.session.user
  	next()

require('./lib/passport/facebook')(app)
require('./lib/passport/twitter')(app)
routes = require './routes'
routes(app)

server = http.createServer app
server.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
module.exports = server

socket = require './socket' 
socket server