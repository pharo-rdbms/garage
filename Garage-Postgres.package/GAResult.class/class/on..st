instance creation
on: aConnection

	^ self basicNew initialize
		connection: aConnection;
		yourself.
