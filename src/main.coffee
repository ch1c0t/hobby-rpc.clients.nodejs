http = require 'http'

exports.RPC = ({ url, socket, token }) ->
  if url and socket
    throw new Error "Expected either url or socket. Got both."

  { request } = http

  options =
    method: 'POST'
    headers:
      'Content-Type': 'application/json'

  if token
    options.headers.Authorization = token

  if url
    url = new URL url
    options = {
      options...
      hostname: url.hostname
      port: url.port
      path: url.pathname
    }
    if url.protocol is 'https:'
      { request } = require 'https'

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
        if res.statusCode isnt 200
          error = "Request failed. Status code: #{res.statusCode}."
          res.resume()
          reject new Error error
          return

        response = ''
        res.on 'data', (chunk) -> response += chunk
        res.on 'end', ->
          resolve JSON.parse response
      req.on 'error', (error) ->
        reject error
      req.write body
      req.end()
