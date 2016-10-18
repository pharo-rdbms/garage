as yet unclassified
testConnectionsAreRegisteredForFinalization

	| newConnection |
	newConnection := fixture newConnection.
	self assert: newConnection isRegisteredForFinalization.
	newConnection close.