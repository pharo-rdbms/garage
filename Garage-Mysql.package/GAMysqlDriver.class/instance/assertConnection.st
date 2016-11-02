connection
assertConnection

	self isConnected ifFalse: [^ GAMysqlNoConnectionError signal: 'Driver is not connected'].