express = require 'express'
http = require 'http'
path = require 'path'

app = express()

app.configure () ->
  app.set 'port', process.env.PORT || 8080
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join __dirname, "..", "client"

app.configure 'development', () ->
  app.use express.errorHandler()

urlHandler = (req, res) ->
	idx = req.path.lastIndexOf '.'
	if idx < 0
		return res.sendfile path.join __dirname, "..", "client", "js", "app", "index.html"
	return res.send 404

app.use urlHandler

(http.createServer app).listen (app.get 'port'), () ->
  console.log "Express server listening on port #{app.get 'port'}"