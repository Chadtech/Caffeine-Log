fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p, canvas} = fission.React.DOM

module.exports =
  fission.modelView
    model: User

    init: ->
      console.log 'A', window.location.href
      return null

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          p {className: 'point'}, 
            'HELLO'


