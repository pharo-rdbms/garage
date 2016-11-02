connection
connect
	| response |
	self isConnected ifTrue: [^ GAMysqlDriverError signal: 'Driver is already connected'].
	netSession := GAMysqlNetSession new
						toHost: self host andPort: self port;
						yourself.

	response := self authenticate.
	response isError ifTrue: [ GAMysqlDriverError signal: 'Failed to connect to server: ', (GAMysqlError from: netSession read) message ].

	"We tell the database the encoding we will be using. We could do it in the authenticate but we should have on the client side a table with all possible encodings and values"
	self basicQuery: 'SET NAMES ', self encoding.
	
	self register.
	^ GAMysqlOkay from: netSession read