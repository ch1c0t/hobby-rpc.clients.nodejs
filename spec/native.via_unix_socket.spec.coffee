{ RPC } = require 'hobby-rpc.client'

describe 'making RPC requests via Unix socket,', ->
  beforeAll ->
    socket = "#{TE.dir}/coffee-rpc.socket"
    @rpc = RPC
      socket: socket

  ItCanInteractWithCoffeeScriptRPC()
