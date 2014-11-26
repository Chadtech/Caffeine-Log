express = require 'express'
app = express()
http = require 'http'
{join} = require 'path'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/test'
User = require './server/models/user'
Consumption = require './server/models/consumption'

app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

PORT = Number process.env.PORT or 8091

router = express.Router()

router.use (request, response, next) ->
  console.log 'SOMETHING HAPPENING'
  next()

router.route '/user/:id'
  .get (request, response) ->
    idToQuery = request.params.id
    User.findById idToQuery, (error, user) ->
      if error
        console.log 'ERROR ', error
      informationToGive =
        name: user.name
        numberOfLogins: user.numberOfLogins

      Consumption.find {consumer: user.name}, (error, consumption) ->
        if error
          response.send error
          console.log 'Error in querying consumption ', error
        informationToGive.consumption = consumption
        response.json informationToGive
        console.log 'Gave user and consumption'

router.route '/'
  .post (request, response) ->
    switch request.body.submissionType
      when 'register'
        User.findOne {name: request.body.user.username}, (error, user) ->
          if error
            console.log 'ERROR ', error
          else
            if user isnt null
              response.json {message: 'Username taken'}
              console.log 'User attempted registration, but username was already taken'
            else
              newUser = new User()
              newUser.name = request.body.user.username
              newUser.password = request.body.user.password
              newUser.numberOfLogins = 0
              newUser.save (error) ->
                if error
                  response.send error
                  console.log 'Error in creating new user ', error
              response.json message: 'User created'
              console.log 'User created ', newUser.name
      
      when 'login'
        User.findOne {name: request.body.user.username}, (error, user) ->
          if error
            console.log 'ERROR ', error
          else
            if user isnt null
              passwordAttempted = request.body.user.password
              actualPassword = user.password
              if passwordAttempted is actualPassword
                reply =
                  message: 'Password correct'
                  direction: user.id
                response.json reply
                user.numberOfLogins++
                user.save (error) ->
                  if error
                    response.send error
                    console.log 'Error in loging in ', error
              else
                response.json message: 'Did not work'
            else
              response.json message: 'Did not work'
      
      when 'log consumption'
        User.findOne {name: request.body.consumption.username}, (error, user) ->
          if error
            console.log 'ERROR ', error
          else
            if user isnt null
              newConsumption = new Consumption()
              newConsumption.date = request.body.consumption.momentOfConsumption
              newConsumption.amount = request.body.consumption.amount
              newConsumption.consumer = request.body.consumption.username
              newConsumption.save (error) ->
                if error
                  response.send error
                  console.log 'Error in recording consumption'
              response.json message: 'Consumption recorded'
              console.log 'Consumption recorded'

app.use express.static join __dirname, 'public'

app.use '/api', router

app.use (error, request, response, next) ->
  console.error error.stack
  response.send 500, 'SOMETHING BROKE'

app.get '/*', (request, response) ->
  adminFile = join __dirname, 'public/template.html'
  response.status 200
    .sendFile adminFile

httpServer = http.createServer app

httpServer.listen PORT, ->
  console.log 'SERVER RUNNING ON ' + PORT