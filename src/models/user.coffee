mongoose = require 'mongoose'

User = new mongoose.Schema(
  _id: String,
  password: String
)

module.exports = mongoose.model 'User', User