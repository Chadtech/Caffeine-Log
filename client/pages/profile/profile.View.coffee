fission = require '../../app'
User = require '../../models/user'
Consumption = require '../../models/consumption'
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

consumptionView = (consumptionItem) ->
  if consumptionItem is undefined
    return fission.view
      render: ->
        p
          className: 'point'
          'LOADING'
  else
    consumptionItem = consumptionItem[0]
    return fission.view
      render: ->
        p
          className: 'point'
          consumptionItem.toString()

module.exports =
  fission.modelView
    model: User

    getInitialState: ->
      consumptionItem: ''
      consumptionOfUser: @model.consumption

    show: ->
      console.log 'Model Consumption', @model.consumption[0]
      console.log 'toString()', @model.consumption[0].toString()

    logConsumption: ->
      destinationUrl = 'http://localhost:8091/api'

      consumption =
        username: @model.name
        userId: @model.id
        amount: 10
        momentOfConsumption: getMomentOfConsumption()

      console.log @state.consumptionOfUser

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
            className: 'submit wide' 
            type:      'submit'
            value:     'Console Log @Model'
            onClick:   @show
          
          div {className: 'break'}
          p
            className: 'point'
            'Log Consumption'
          input
            className:   'input wide'
            placeholder: '<what you just drank>'
            value:       @state.consumptionItem
            onChange:    @handleConsumptionField
          input
            className:  'submit wide'
            type:       'submit'
            value:      'Log'
            onClick:    @logConsumption

          div {className: 'break'}
          p
            className: 'point'
            'Consumption'

          if @model.consumption isnt undefined
            for time in @model.consumption
              p
                className: 'point'
                time.date + ' : ' + time.amount + 'mg'





