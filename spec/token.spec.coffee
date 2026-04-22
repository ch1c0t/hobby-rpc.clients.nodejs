{ RPC } = require 'hobby-rpc.client'

describe 'authorization', ->
  StartAndStopTcpServerForEachExample
    server_path: "#{process.cwd()}/spec/lib/authorization.rpc_via_tcp.coffee"

  beforeEach ->
    { host, port } = @server.data
    url = "http://#{host}:#{port}"

    @rpc = RPC
      url: url
      token: 'a_valid_token'
    @rpc_without_token = RPC
      url: url

  ItCanInteractWithCoffeeScriptRPC()
