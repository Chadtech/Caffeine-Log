mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema {name: String}

module.exports = mongoose.model 'User', UserSchema