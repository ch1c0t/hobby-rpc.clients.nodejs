{ CreateJasmine } = require './CreateJasmine.coffee'
{ CreateTmpDirectory } = require './CreateTmpDirectory.coffee'
{ StartServers } = require './StartServers.coffee'

exports.CreateTestEnvironment = ->
  dir = await CreateTmpDirectory()
  StartServers()

  {
    jasmine: CreateJasmine()
    dir: dir
  }
