{ compile, VERSION } = require 'coffeescript'
{ Server } = require 'hobby-rpc.server'

functions =
  Version: -> VERSION
  Compile: (input) ->
    { code, bare } = input

    if code.isString()
      compile code,
        bare: !!bare
    else
      error: "Expected input.code to be a valid CoffeeScript code."

server = Server { functions }
server.listen "#{process.cwd()}/coffee-rpc.socket", ->
  process.send
    pid: process.pid
