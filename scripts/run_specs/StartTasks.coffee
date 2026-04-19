require './Task'

exports.StartTasks = ({ inside_of })->
  path = "#{process.cwd()}/spec/servers/rpc.coffee"
  task = await Task { run: path, inside_of }
  p task
  [task]
