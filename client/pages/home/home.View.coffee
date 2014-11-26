fission = require '../../app'

{div, p, input, canvas, a} = fission.React.DOM

module.exports =
  fission.view
    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          
          p {className: 'point'},
            'HOME PAGE'
