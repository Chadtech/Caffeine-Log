fission = require '../app'

module.exports =
  fission.model
    props:
      name: 'string'
      id: 'string'
    url: 'api/user'