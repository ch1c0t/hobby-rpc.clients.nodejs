global.StartAndStopTcpServerForEachExample = ->
  beforeEach ->
    server_path = "#{process.cwd()}/spec/lib/rpc_via_tcp.coffee"
    @server = await Task
      run: server_path

  afterEach ->
    process.kill @server.pid
