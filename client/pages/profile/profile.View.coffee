fission = require '../../app'
User = require '../../models/user'

{div, input, p, canvas} = fission.React.DOM

module.exports =
  fission.modelView
    model: User
    showId: ->
      u = new User @model.id
      u.fetch success: ->
        console.log  u

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          p {className: 'point'}, 
            'HELLO'
          p {className: 'point'},
            @model.id

          input {className: 'input', type:'submit', onClick:@showId}



