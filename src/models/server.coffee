mongoose = require 'mongoose'

Server = new mongoose.Schema(
  host: String,
  port: Number,
  protocol: String
)

module.exports = mongoose.model 'Server', Server