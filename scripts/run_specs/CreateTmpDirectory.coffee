{ randomUUID } = require 'crypto'

exports.CreateTmpDirectory = ->
  name = "hobby-rpc.clients.nodejs.test.#{process.pid}.#{randomUUID()}"
  path = "/tmp/#{name}"
  await IO.mkdir path
  path