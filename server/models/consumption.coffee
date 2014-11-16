mongoose = require 'mongoose'
Schema = mongoose.Schema

ConsumptionSchema = new Schema {date: 'number', amount: 'number'}

module.exports = mongoose.model 'Consumption', ConsumptionSchema

###
  
  20141115164626
  yyyymmddhhmmss
  xxxx1231235959

###