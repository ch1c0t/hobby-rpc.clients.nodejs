{ Server } = require 'hobby-rpc.server'
{ functions } = require './functions'

server = Server {
  functions
  FindUser: (token) ->
    if token is 'a_valid_token'
      name: 'A'
}

server.listen 0, '127.0.0.1', ->
  process.send
    pid: process.pid
    port: server.address().port
    host: server.address().address
