{ RPC } = require 'hobby-rpc.client'

describe 'making RPC requests via TCP, with the client using native Node.js API,', ->
  StartAndStopTcpServerForEachExample()
  beforeEach ->
    { host, port } = @server.data
    url = "http://#{host}:#{port}"
    @rpc = RPC
      url: url

  ItCanInteractWithCoffeeScriptRPC()
