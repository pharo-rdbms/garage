as yet unclassified
testConnectionsAreFinalizedOnCollection

	| newConnection |
	newConnection := fixture newConnection.
	newConnection finalize.
	self deny: newConnection isConnected.