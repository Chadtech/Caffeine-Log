fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p} = fission.React.DOM

module.exports = 
  fission.view

    getInitialState: ->
      loginUsername:    ''
      loginPassword:    ''
      registerUsername: ''
      registerPassword: ''

      loginClass:    'input'
      registerClass: 'input'

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

      failAct = @registerFail
      successAct = @registerSuccess

      $.post desintationUrl, submission, (data) ->
        switch data.message
          when 'User created'
            successAct()
          when 'Username taken'
            failAct()

    registerSuccess: ->
      @setState registerClass: 'input success'

    registerFail: ->
      @setState registerClass: 'input problem'
      @setState registerUsername: 'already taken'

      reset = @registerReset
      setTimeout ->
        reset()
      , 2000

      clear = @registerClear
      setTimeout ->
        clear()
      , 3000

    registerReset: ->
      @setState registerClass: 'input'

    registerClear: ->
      @setState registerUsername: ''
      @setState registerPassword: ''

    loginSuccess: ->
      @setState loginClass: 'input success'

    loginFail: ->
      @setState loginClass: 'input problem'
      @setState loginUsername: 'incorrect'

      reset = @loginReset
      setTimeout ->
        reset()
      , 2000

      clear = @loginClear
      setTimeout ->
        clear()
      , 3000

    loginReset: ->
      @setState loginClass: 'input'

    loginClear: ->
      @setState loginUsername: ''
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

            profilePage = 'http://localhost:8091/profile/'
            profilePage += data.direction
            window.location.replace(profilePage)

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
              className:   @state.registerClass
              placeholder: 'username'
              value:       @state.registerUsername
              onChange:    @handleRegisterUsername
            
            input 
              className:   @state.registerClass
              type:        'password'
              placeholder: 'password'
              value:       @state.registerPassword
              onChange:    @handleRegisterPassword

            input 
              className:   'submit'
              type:        'submit'
              value:       'Submit'
              onClick:     @register
 



