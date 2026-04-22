It is a [Hobby-RPC][hobby_rpc] client for Node.js, using the built-in [http.request][http.request]. To install:

```
npm i hobby-rpc.client
```

A usage example:
```coffeescript
import { RPC } from 'hobby-rpc.client'

rpc = RPC
  url: 'https://some.domain'
  token: 'authorization token'

# or

rpc = RPC
  socket: '/tmp/some_rpc.socket'
  token: 'authorization token'

output = await rpc 'SomeNullaryFunction'
output = await rpc 'SomeUnaryFunction', input
```

`input` can be any object serializable to JSON
(that's what will be passed to the remote function as an argument).
`output` would be an object deserialized from JSON.

It can connect either via a TCP socket(if you pass its address in `url`) or
via a Unix socket(if you pass its filesystem path in `socket`).

This client is for Node.js.
[Other client][hobby_rpc.fetch] uses an underlying mechanism available in browsers too.


[hobby_rpc]: https://github.com/ch1c0t/hobby-rpc.protocol
[hobby_rpc.fetch]: https://github.com/ch1c0t/hobby-rpc.clients.js
[http.request]: https://nodejs.org/api/http.html#httprequesturl-options-callback
