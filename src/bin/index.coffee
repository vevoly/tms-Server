#!/usr/bin/env node

# Module dependencies.
app = require('../app')
debug = require('debug')('src:server')
http = require('http')

# Normalize a port into a number, string, or false.
normalizePort = (val) ->
  port = parseInt(val, 10)
  if isNaN(port)
    return val
  if port > 0
    return port
  false

port = normalizePort(process.env.PORT || '3000')
app.set('port', port)
# Create HTTP server.
server = http.createServer(app)

onError = (error) ->
  if error.syscall isnt 'listen'
    throw error
  bind = typeof port is 'string' ? 'Pipe ' + port : 'Port ' + port
  switch error.code
    when 'EACCES'
      console.error(bind + ' requires elevated privileges')
      process.exit(1)
    when 'EADDRINUSE'
      console.error(bind + ' is already in use')
      process.exit(1)
    else
      throw error

onListening = (server) ->
  addr = server.address()
  bind = typeof addr is 'string' ? 'pipe ' + addr : 'port ' + addr.port
  debug('Listening on ' + bind)

# Listen on provided port, on all network interfaces.

server.on('error', onError)
#server.on('listening', onListening)
server.listen(port)