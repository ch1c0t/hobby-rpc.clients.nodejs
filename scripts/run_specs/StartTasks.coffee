require './Task'

exports.StartTasks = ({ inside_of })->
  path = "#{process.cwd()}/spec/lib/rpc_via_unix_socket.coffee"
  task = await Task { run: path, inside_of }
  [task]
