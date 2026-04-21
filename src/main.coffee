http = require 'http'
{ request } = http

exports.RPC = ({ url, socket }) ->
  if url and socket
    throw new Error "Expected either url or socket. Got both."

  options =
    method: 'POST'
    headers:
      'Content-Type': 'application/json'

  if url
    url = new URL url
    options = {
      options...
      hostname: url.hostname
      port: url.port
      path: url.pathname
    }

  if socket
    options = {
      options...
      socketPath: socket
    }

  (name, input) ->
    body =
      if input
        fn: name
        in: input
      else
        fn: name
    body = JSON.stringify body

    new Promise (resolve, reject) ->
      req = request options, (res) ->
        response = ''
        res.on 'data', (chunk) -> response += chunk
        res.on 'end', ->
          resolve JSON.parse response
      req.on 'error', (error) ->
        console.error error
        reject error
      req.write body
      req.end()
