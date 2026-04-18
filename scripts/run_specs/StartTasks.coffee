{ fork } = require 'child_process'

Task = bow
  methods:
    run: ->
      new Promise (resolve, reject) =>
        @child = fork @path, @args,
          cwd: @inside_of
        @child.once 'message', (data) =>
          if data.pid
            @pid = data.pid
            resolve @pid
        @child.once 'error', (error) -> reject error
        @child.once 'exit', (code) ->
          if code isnt 0
            reject new Error "Exit code: #{code}"
  init:
    path: -> @value
    args: -> @value or []
    inside_of: -> @value
  setup: ->
    await @run()
    @

require 'coffeescript/register'
exports.StartTasks = ({ inside_of })->
  path = "#{process.cwd()}/spec/servers/rpc.coffee"
  task = await Task { path, inside_of }
  p task
  [task]
