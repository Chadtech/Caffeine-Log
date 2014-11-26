fission = require '../app'

module.exports =
  fission.model
    props:
      name: 'string'
      id: 'string'
      numberOfLogins: 'number'
      consumption: 'array'
    url: 'http://localhost:8091/api/user'