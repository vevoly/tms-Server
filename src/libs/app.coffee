express = require('express')
path = require('path')
logger = require('morgan')
bodyParser = require('body-parser')

apiRouters = require('../routes/api')


app = express()

app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

app.use('/api', apiRouters)

# catch 404 and forward to error handler
app.use((req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)
)

# error handler


# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use((err, req, res, next) ->
    res.status(err.status || 500)
    res.render('error', {
      message: err.message
      error: err
    })
  )

# production error handler
# no stacktraces leaked to user
app.use((err, req, res, next) ->
  res.status(err.status || 500)
  res.render('error', {
    message: err.message
    error: {}
  })
)


module.exports = app
