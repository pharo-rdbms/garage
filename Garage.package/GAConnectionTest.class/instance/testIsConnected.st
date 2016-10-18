as yet unclassified
testIsConnected

	| newConnection |
	[newConnection := fixture newConnection.
	self assert: newConnection isConnected.]
	ensure: [ newConnection close ]