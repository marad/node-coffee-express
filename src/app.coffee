express = require "express"
connect = require "connect"
path    = require "path"
http    = require "http"
mongo   = require "mongodb"
monk    = require "monk"

routes  = require "./routes"

app = express()
db = monk "localhost:27017/dbname"


app.set 'port', process.env.PORT || 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use connect.favicon()
app.use connect.logger('dev')
app.use connect.json()
app.use connect.urlencoded()
app.use connect.methodOverride()
app.use connect.cookieParser('your secret here')
app.use connect.bodyParser()
app.use connect.session()


# Environment Settings
env = process.env.NODE_ENV || 'development'
if 'development' == env
  app.use connect.errorHandler()
  app.use connect.errorHandler()


# Routes Setup
app.route '/'
  .get routes.index


# Middleware Setup
app.use require('less-middleware')( path.join(__dirname, 'public') )
app.use express.static(path.join(__dirname, 'public'))
app.use '/pages/:pageName', (req, res, next) ->
  res.render 'pages/' + req.params.pageName
  
# Run the HTTP server
http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get 'port'
