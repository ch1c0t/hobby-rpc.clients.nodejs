(function() {
  var http, request;

  http = require('http');

  ({request} = http);

  exports.RPC = function({url}) {
    var options;
    options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    };
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
        req = request(url, options, function(res) {
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
