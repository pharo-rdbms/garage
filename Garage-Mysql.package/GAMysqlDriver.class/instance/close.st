connection
close

	self assertConnection.
	(GAMysqlCommandQuit  onSession: netSession driver: self) execute.
	netSession disconnect.
	