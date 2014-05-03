express = require "express"
path    = require "path"
http    = require "http"
mongo   = require "mongodb"
monk    = require "monk"

routes  = require "./routes"

app = express()
db = monk "localhost:27017/dbname"

app.set('port', process.env.PORT || 3000)
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.json())
app.use(express.urlencoded())
app.use(express.methodOverride())
app.use(express.cookieParser('your secret here'))
app.use(express.bodyParser())
app.use(express.session())
app.use(app.router)
app.use(require('less-middleware')( path.join(__dirname, 'public') ))
app.use(express.static(path.join(__dirname, 'public')))

app.use((req, res, next) ->
  # serve compiled page template for angular js
  
  console.log(path)
  path = req.path
  if path.match /\/?pages\/[a-z]+/
    console.log('This is a template request!')
    if path[0] == '/'
      # strip leading slash
      path = path.substr(1)

    res.render(path)
  else
    next()
)

# development only
if 'development' == app.get('env')
  app.use express.errorHandler()
  app.use express.errorHandler()

app.get('/', routes.index)

# Run the HTTP server
http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get 'port'
