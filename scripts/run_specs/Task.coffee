require 'coffeescript/register'
{ fork } = require 'child_process'

global.Task = bow
  methods:
    start: ->
      new Promise (resolve, reject) =>
        @child = fork @run, @args,
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
    run: -> @value
    args: -> @value or []
    inside_of: -> @value
  setup: ->
    await @start()
    @
