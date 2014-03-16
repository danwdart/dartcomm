express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'
http = require 'http'

app = express()

config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env

if app.settings.env != 'production'
  mongoose.connect 'mongodb://localhost/dartcomm'
else
  console.log('If you are running in production, you may want to modify the mongoose connect path')

app.use assets()
app.use express.static(process.cwd() + '/public')

store = new express.session.MemoryStore
app.use express.cookieParser()
app.use express.session(
  secret: 'shhh'
  store: store
)

app.set 'view engine', 'jade'

app.use express.urlencoded()
app.use express.json()

app.use (err, req, res, next) ->
  res.send (500, { error: err.message })

require('./lib/passport/facebook')(app)
require('./lib/passport/twitter')(app)
routes = require './routes'
routes(app)

server = http.createServer app
server.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
module.exports = server

socket = require './socket'
socket(server)