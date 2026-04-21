http = require 'http'
{ request } = http

exports.RPC = ({ url }) ->
  options =
    method: 'POST'
    headers:
      'Content-Type': 'application/json'

  (name, input) ->
    body =
      if input
        fn: name
        in: input
      else
        fn: name
    body = JSON.stringify body

    new Promise (resolve, reject) ->
      req = request url, options, (res) ->
        response = ''
        res.on 'data', (chunk) -> response += chunk
        res.on 'end', ->
          resolve JSON.parse response
      req.on 'error', (error) ->
        console.error error
        reject error
      req.write body
      req.end()
