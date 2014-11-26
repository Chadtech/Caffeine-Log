mongoose = require 'mongoose'
Schema = mongoose.Schema

props =
  date:     'number'
  amount:   'number'
  consumer: 'string'

ConsumptionSchema = new Schema props

module.exports = mongoose.model 'Consumption', ConsumptionSchema