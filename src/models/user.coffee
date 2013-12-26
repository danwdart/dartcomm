mongoose = require 'mongoose'

User = new mongoose.Schema(
  serverid: String,
  username: String,
  password: String
)

module.exports = mongoose.model 'User', User