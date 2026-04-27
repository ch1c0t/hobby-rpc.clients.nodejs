{ RPC } = require 'hobby-rpc.client'

describe 'token', ->
  StartAndStopTcpServerForEachExample
    server_path: "#{process.cwd()}/spec/lib/authorization.rpc_via_tcp.coffee"

  beforeEach ->
    { host, port } = @server.data
    @url = "http://#{host}:#{port}"

    @rpc = RPC
      url: @url
      token: 'a_valid_token'

  ItCanInteractWithCoffeeScriptRPC()

  it 'throws an error when no token was passed', ->
    @rpc = RPC
      url: @url

    await expectAsync @rpc 'Compile', 'answer = 42'
      .toBeRejectedWith 403
