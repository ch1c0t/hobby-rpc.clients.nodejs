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

  it 'compiles strings of CoffeeScript to JavaScript', ->
    js_string = await @rpc 'Compile',
      code: 'answer = 42'

    expect(js_string.trim()).toBe """
      (function() {
        var answer;

        answer = 42;

      }).call(this);
    """

  it 'can compile to bare output', ->
    js_string = await @rpc 'Compile',
      code: 'answer = 42'
      bare: true

    expect(js_string.trim()).toBe """
      var answer;

      answer = 42;
    """
