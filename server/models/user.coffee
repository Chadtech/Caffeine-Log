mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema
  name: String
  password: String
  numberOfLogins: Number

module.exports = mongoose.model 'User', UserSchema