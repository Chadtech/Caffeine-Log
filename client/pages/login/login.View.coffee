fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p} = fission.React.DOM

module.exports = 
  fission.view

    getInitialState: ->
      loginUsername: ''
      loginPassword: ''
      registerUsername: ''
      registerPassword: ''

    handleLoginUsername: (event) ->
      @setState loginUsername: event.target.value

    handleLoginPassword: (event) ->
      @setState loginPassword: event.target.value

    handleRegisterUsername: (event) ->
      @setState registerUsername: event.target.value

    handleRegisterPassword: (event) ->
      @setState registerPassword: event.target.value

    register: ->
      desintationUrl = 'http://localhost:8091/api'

      newUser = 
        username:       @state.registerUsername
        password:       @state.registerPassword
      submission =
        submissionType: 'register'
        user:           newUser

      $.post desintationUrl, submission, (data) ->
        console.log 'THIS IS DATA ', data

    login: ->
      destinationUrl = 'http://localhost:8091/api'

      userLogingIn =
        username:        @state.loginUsername
        password:        @state.loginPassword
      submission =
        submissionType: 'login'
        user:            userLogingIn

      $.post destinationUrl, submission, (data) ->
        switch data.message
          when 'Password correct'
            window.location.replace('http://www.homestarrunner.net')

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},

          div {className: 'box center'},

            p {className: 'point'}, 'Login'

            input 
              className:   'input'
              placeholder: 'username'
              value:       @state.loginUsername
              onChange:    @handleLoginUsername

            input 
              className:   'input'
              placeholder: 'password'
              type:        'password'
              value:       @state.loginPassword
              onChange:    @handleLoginPassword

            input 
              className:   'submit'
              type:        'submit'
              value:       'Submit'
              onClick:     @login

            div {className: 'break'}

            p {className: 'point'}, 'Register'

            input 
              className:   'input'
              placeholder: 'username'
              value:       @state.registerUsername
              onChange:    @handleRegisterUsername
            
            input 
              className:   'input'
              type:        'password'
              placeholder: 'password'
              value:       @state.registerPassword
              onChange:    @handleRegisterPassword

            input 
              className:   'submit'
              type:        'submit'
              value:       'Submit'
              onClick:     @register
 



