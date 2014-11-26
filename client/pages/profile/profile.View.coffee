fission = require '../../app'
User = require '../../models/user'
$ = require 'jquery'

{div, input, p, canvas, br} = fission.React.DOM

getMomentOfConsumption = () ->
  momentOfConsumption = new Date()
  formattedMoment = momentOfConsumption.getFullYear() + ''
  formattedMoment += momentOfConsumption.getMonth()
  formattedMoment += (momentOfConsumption.getDate() - 1)
  formattedMoment += momentOfConsumption.getHours()
  formattedMoment += momentOfConsumption.getSeconds()
  formattedMoment += momentOfConsumption.getMilliseconds()

  return formattedMoment

module.exports =
  fission.modelView
    model: User

    getInitialState: ->
      consumptionItem: ''

    show: ->
      console.log 'Model Consumption', @model.consumption

    logConsumption: ->
      destinationUrl = 'http://localhost:8091/api'

      consumption =
        username: @model.name
        userId: @model.id
        amount: 10
        momentOfConsumption: getMomentOfConsumption()

      console.log @state.consumptionOfUser()

      submission = 
        submissionType: 'log consumption'
        consumption:    consumption

      $.post destinationUrl, submission, (data) ->
        console.log data

    handleConsumptionField: (event) ->
      @setState consumptionItem: event.target.value

    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},

          p 
            className: 'point' 
            'Hello, this is caffeine log'

          div {className: 'break'}
          p 
            className: 'point'
            'User Name : ' + @model.name
          p 
            className: 'point'
            'User Id : ' + @model.id
          p 
            className: 'point',
            'Number Of Logins : ' + @model.numberOfLogins
          input
            className: 'submit' 
            type:      'submit'
            value:     'Console Log @Model'
            onClick:   @show
          
          div {className: 'break'}
          p
            className: 'point'
            'Log Consumption'
          input
            className:   'input'
            placeholder: '<what you just drank>'
            value:       @state.consumptionItem
            onChange:    @handleConsumptionField
          input
            className:  'submit'
            type:       'submit'
            value:      'Log'
            onClick:    @logConsumption



