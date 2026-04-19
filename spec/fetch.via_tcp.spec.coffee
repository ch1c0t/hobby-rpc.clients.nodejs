{ RPC } = require 'hobby-rpc'

describe 'making RPC requests via TCP, with the client using the Fetch API,', ->
  beforeEach ->
    server_path = "#{process.cwd()}/spec/lib/rpc_via_tcp.coffee"
    @server = await Task
      run: server_path

    { host, port } = @server.data
    url = "http://#{host}:#{port}"
    @rpc = RPC
      url: url

  afterEach ->
    process.kill @server.pid

  it 'gets the CoffeeScript version', ->
    version = await @rpc 'Version'
    expect(version).toBe '2.7.0'
