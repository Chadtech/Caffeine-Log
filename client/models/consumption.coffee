fission = require '../app'

module.exports =
  fission.model
    props:
      date: 'number'
      amount: 'number'
      consumer: 'string'
      id: 'string'
