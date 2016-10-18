as yet unclassified
testGetConnectionFromConnectionStringDoesNotOpenConnection

	| connection |
	connection := GADriver fromConnectionString: fixture connectionString.
	self deny: connection isConnected.