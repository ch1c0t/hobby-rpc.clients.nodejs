{ Server } = require 'hobby-rpc.server'
{ functions } = require './functions'

server = Server { functions }
server.listen "#{process.cwd()}/coffee-rpc.socket", ->
  process.send
    pid: process.pid
