mongoose = require 'mongoose'
Schema = mongoose.Schema

props =
  name:           String
  password:       String
  numberOfLogins: Number

UserSchema = new Schema props


module.exports = mongoose.model 'User', UserSchema