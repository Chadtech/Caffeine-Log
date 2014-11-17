fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p, canvas} = fission.React.DOM

module.exports =
  fission.modelView
    model: User

    getInitialState: ->
      name: ''
      loginCount: ''

    setUserInformation: (name, loginCount) ->
      @setState name: name
      @setState loginCount: loginCount
      console.log 'B', @state.name
      console.log 'C', @state.loginCount

    #init: ->
    #  console.log '9', @model.id
    #  destination = 'http://localhost:8091/api'
    #  submission =
    #    id: @model.id
    #  console.log 'A', submission
    #  set = @setUserInformation
    #  $.get destination, submission, (data) ->
    #    console.log 'A.1', data
    #    set(data.name, data.numberOfLogins)

      return null



    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          p {className: 'point'}, 
            'HELLO'
          p {className: 'point'},
            @model.id
            @init()


