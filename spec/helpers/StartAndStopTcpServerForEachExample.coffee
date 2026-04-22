global.StartAndStopTcpServerForEachExample = ({ server_path }) ->
  beforeEach ->
    @server = await Task
      run: server_path

  afterEach ->
    process.kill @server.pid
