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

      loginClass: 'input'


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

    loginSuccess: ->
      @setState loginClass: 'input success'

    loginFail: ->
      @setState loginClass: 'input problem'
      @setState loginUsername: 'Incorrect'

      reset = @loginReset
      setTimeout ->
        reset()
      , 2000

      clear = @passwordClear
      setTimeout ->
        clear()
      , 3000

    loginReset: ->
      @setState loginClass: 'input'
      @setState loginUsername: 'username'

    passwordClear: ->
      @setState loginPassword: ''

    login: ->
      destinationUrl = 'http://localhost:8091/api'

      userLogingIn =
        username:        @state.loginUsername
        password:        @state.loginPassword
      submission =
        submissionType: 'login'
        user:            userLogingIn

      failAct = @loginFail
      successAct = @loginSuccess

      $.post destinationUrl, submission, (data) ->
        switch data.message
          when 'Password correct'
            successAct()
            window.location.replace('http://localhost:8091/profile/' + data.direction)
          when 'Did not work'
            failAct()

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},

          div {className: 'box center'},

            p {className: 'point'}, 'Login'

            input 
              className:   @state.loginClass
              placeholder: 'username'
              value:       @state.loginUsername
              onChange:    @handleLoginUsername

            input 
              className:   @state.loginClass
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
 



