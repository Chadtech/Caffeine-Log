fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p, canvas} = fission.React.DOM

module.exports =
  fission.modelView
    model: User

    getInitialState: ->
      id: @model.id


    showId: ->
      console.log 'A', @model.id
      console.log 'B', @state.id
      console.log 'C', @model.name

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          p {className: 'point'}, 
            'HELLO'
          p {className: 'point'},
            @model.id
          #input {className: 'input', type:'submit', onClick:@showId}



