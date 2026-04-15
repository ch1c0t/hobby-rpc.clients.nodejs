{ some } = require 'hobby-rpc.clients.nodejs'

describe 'main', ->
  it 'returns some string', ->
    string = some()
    expect(string).toBe 'some string'