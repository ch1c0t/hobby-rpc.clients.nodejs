{ CreateJasmine } = require './CreateJasmine.coffee'
{ CreateTmpDirectory } = require './CreateTmpDirectory.coffee'
{ StartTasks } = require './StartTasks.coffee'

exports.CreateTestEnvironment = ->
  dir = await CreateTmpDirectory()
  tasks = await StartTasks inside_of: dir

  {
    jasmine: CreateJasmine()
    dir
    tasks
  }
