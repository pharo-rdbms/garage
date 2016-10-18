as yet unclassified
testNotConnected

	| newConnection |
	newConnection := fixture newConnection.
	newConnection close.
	self deny: newConnection isConnected