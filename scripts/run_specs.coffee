require '@ch1c0t/ext'

{ CreateTestEnvironment } = require './run_specs/CreateTestEnvironment.coffee'

run = ->
  global.TE = await CreateTestEnvironment()
  p "Created a test environment directory at"
  p TE.dir

  TE.jasmine.execute()
    .then (info) ->
      if info.overallStatus is 'failed'
        process.exit 3

      for task in TE.tasks
        { pid } = task
        try
          process.kill pid
        catch error
          if error.code is 'ESRCH'
            # ESRCH: The task PID does not exist. Continue to the next task.
            continue
          else
            console.error error

run()
