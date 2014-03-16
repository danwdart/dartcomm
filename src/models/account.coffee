mongoose = require 'mongoose'

Account = new mongoose.Schema(
  serverid: String,
  username: String,
  password: String
)

module.exports = mongoose.model 'Account', Account