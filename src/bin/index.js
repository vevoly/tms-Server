// Generated by CoffeeScript 1.12.7
(function() {
  var app, debug, http, normalizePort, onError, onListening, port, server;

  app = require('../app');

  debug = require('debug')('src:server');

  http = require('http');

  normalizePort = function(val) {
    var port;
    port = parseInt(val, 10);
    if (isNaN(port)) {
      return val;
    }
    if (port > 0) {
      return port;
    }
    return false;
  };

  port = normalizePort(process.env.PORT || '3000');

  app.set('port', port);

  server = http.createServer(app);

  onError = function(error) {
    var bind, ref;
    if (error.syscall !== 'listen') {
      throw error;
    }
    bind = (ref = typeof port === 'string') != null ? ref : 'Pipe ' + {
      port: 'Port ' + port
    };
    switch (error.code) {
      case 'EACCES':
        console.error(bind + ' requires elevated privileges');
        return process.exit(1);
      case 'EADDRINUSE':
        console.error(bind + ' is already in use');
        return process.exit(1);
      default:
        throw error;
    }
  };

  onListening = function(server) {
    var addr, bind, ref;
    addr = server.address();
    bind = (ref = typeof addr === 'string') != null ? ref : 'pipe ' + {
      addr: 'port ' + addr.port
    };
    return debug('Listening on ' + bind);
  };

  server.on('error', onError);

  server.listen(port);

}).call(this);

//# sourceMappingURL=index.js.map