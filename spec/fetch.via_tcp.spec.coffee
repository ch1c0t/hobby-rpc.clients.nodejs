{ RPC } = require 'hobby-rpc'

describe 'making RPC requests via TCP, with the client using the Fetch API', ->
  StartAndStopTcpServerForEachExample()
  beforeEach ->
    { host, port } = @server.data
    url = "http://#{host}:#{port}"
    @rpc = RPC
      url: url

  ItCanInteractWithCoffeeScriptRPC()
