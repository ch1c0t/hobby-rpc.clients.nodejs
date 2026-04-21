(function() {
  var http;

  http = require('http');

  exports.RPC = function({url, socket}) {
    var options, request;
    if (url && socket) {
      throw new Error("Expected either url or socket. Got both.");
    }
    ({request} = http);
    options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    };
    if (url) {
      url = new URL(url);
      options = {
        ...options,
        hostname: url.hostname,
        port: url.port,
        path: url.pathname
      };
      if (url.protocol === 'https:') {
        ({request} = require('https'));
      }
    }
    if (socket) {
      options = {
        ...options,
        socketPath: socket
      };
    }
    return function(name, input) {
      var body;
      body = input ? {
        fn: name,
        in: input
      } : {
        fn: name
      };
      body = JSON.stringify(body);
      return new Promise(function(resolve, reject) {
        var req;
        req = request(options, function(res) {
          var response;
          response = '';
          res.on('data', function(chunk) {
            return response += chunk;
          });
          return res.on('end', function() {
            return resolve(JSON.parse(response));
          });
        });
        req.on('error', function(error) {
          console.error(error);
          return reject(error);
        });
        req.write(body);
        return req.end();
      });
    };
  };

}).call(this);
