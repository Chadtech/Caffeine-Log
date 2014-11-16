express = require 'express'
app = express()
http = require 'http'
{join} = require 'path'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/test'
User = require './server/models/user'

app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

PORT = Number process.env.PORT or 8091

router = express.Router()

router.use (request, response, next) ->
  console.log 'SOMETHING HAPPENING'
  response.json message: ' HI THERE '
  next()

router.route '/'
  .get (request, response) ->
    User.findById request.params.user_id, (error, user) ->
      if error
        response.send error
        console.log 'ERROR A'
      response.json user

  .post (request, response) ->
    console.log 'GOT POST', request.body
    username = request.body.username
    password = request.body.password

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